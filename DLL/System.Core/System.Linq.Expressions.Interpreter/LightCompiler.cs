using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic.Utils;
using System.Reflection;
using System.Runtime.CompilerServices;

namespace System.Linq.Expressions.Interpreter;

internal sealed class LightCompiler
{
	private sealed class QuoteVisitor : ExpressionVisitor
	{
		private readonly Dictionary<ParameterExpression, int> _definedParameters = new Dictionary<ParameterExpression, int>();

		public readonly HashSet<ParameterExpression> _hoistedParameters = new HashSet<ParameterExpression>();

		protected internal override Expression VisitParameter(ParameterExpression node)
		{
			if (!_definedParameters.ContainsKey(node))
			{
				_hoistedParameters.Add(node);
			}
			return node;
		}

		protected internal override Expression VisitBlock(BlockExpression node)
		{
			PushParameters(node.Variables);
			base.VisitBlock(node);
			PopParameters(node.Variables);
			return node;
		}

		protected override CatchBlock VisitCatchBlock(CatchBlock node)
		{
			if (node.Variable != null)
			{
				PushParameters(new ParameterExpression[1] { node.Variable });
			}
			Visit(node.Body);
			Visit(node.Filter);
			if (node.Variable != null)
			{
				PopParameters(new ParameterExpression[1] { node.Variable });
			}
			return node;
		}

		protected internal override Expression VisitLambda<T>(Expression<T> node)
		{
			IEnumerable<ParameterExpression> parameters = Array.Empty<ParameterExpression>();
			int parameterCount = node.ParameterCount;
			if (parameterCount > 0)
			{
				List<ParameterExpression> list = new List<ParameterExpression>(parameterCount);
				for (int i = 0; i < parameterCount; i++)
				{
					list.Add(node.GetParameter(i));
				}
				parameters = list;
			}
			PushParameters(parameters);
			base.VisitLambda(node);
			PopParameters(parameters);
			return node;
		}

		private void PushParameters(IEnumerable<ParameterExpression> parameters)
		{
			foreach (ParameterExpression parameter in parameters)
			{
				if (_definedParameters.TryGetValue(parameter, out var value))
				{
					_definedParameters[parameter] = value + 1;
				}
				else
				{
					_definedParameters[parameter] = 1;
				}
			}
		}

		private void PopParameters(IEnumerable<ParameterExpression> parameters)
		{
			foreach (ParameterExpression parameter in parameters)
			{
				int num = _definedParameters[parameter];
				if (num == 0)
				{
					_definedParameters.Remove(parameter);
				}
				else
				{
					_definedParameters[parameter] = num - 1;
				}
			}
		}
	}

	private readonly InstructionList _instructions;

	private readonly LocalVariables _locals = new LocalVariables();

	private readonly List<DebugInfo> _debugInfos = new List<DebugInfo>();

	private readonly HybridReferenceDictionary<LabelTarget, LabelInfo> _treeLabels = new HybridReferenceDictionary<LabelTarget, LabelInfo>();

	private LabelScopeInfo _labelBlock = new LabelScopeInfo(null, LabelScopeKind.Lambda);

	private readonly Stack<ParameterExpression> _exceptionForRethrowStack = new Stack<ParameterExpression>();

	private readonly LightCompiler _parent;

	private readonly StackGuard _guard = new StackGuard();

	private static readonly LocalDefinition[] s_emptyLocals = Array.Empty<LocalDefinition>();

	public InstructionList Instructions => _instructions;

	public LightCompiler()
	{
		_instructions = new InstructionList();
	}

	private LightCompiler(LightCompiler parent)
		: this()
	{
		_parent = parent;
	}

	public LightDelegateCreator CompileTop(LambdaExpression node)
	{
		node.ValidateArgumentCount();
		int i = 0;
		for (int parameterCount = node.ParameterCount; i < parameterCount; i++)
		{
			ParameterExpression parameter = node.GetParameter(i);
			LocalDefinition localDefinition = _locals.DefineLocal(parameter, 0);
			_instructions.EmitInitializeParameter(localDefinition.Index);
		}
		Compile(node.Body);
		if (node.Body.Type != typeof(void) && node.ReturnType == typeof(void))
		{
			_instructions.EmitPop();
		}
		return new LightDelegateCreator(MakeInterpreter(node.Name), node);
	}

	private Interpreter MakeInterpreter(string lambdaName)
	{
		DebugInfo[] debugInfos = _debugInfos.ToArray();
		foreach (KeyValuePair<LabelTarget, LabelInfo> treeLabel in _treeLabels)
		{
			treeLabel.Value.ValidateFinish();
		}
		return new Interpreter(lambdaName, _locals, _instructions.ToArray(), debugInfos);
	}

	private void CompileConstantExpression(Expression expr)
	{
		ConstantExpression constantExpression = (ConstantExpression)expr;
		_instructions.EmitLoad(constantExpression.Value, constantExpression.Type);
	}

	private void CompileDefaultExpression(Expression expr)
	{
		CompileDefaultExpression(expr.Type);
	}

	private void CompileDefaultExpression(Type type)
	{
		if (!(type != typeof(void)))
		{
			return;
		}
		if (type.IsNullableOrReferenceType())
		{
			_instructions.EmitLoad(null);
			return;
		}
		object primitiveDefaultValue = ScriptingRuntimeHelpers.GetPrimitiveDefaultValue(type);
		if (primitiveDefaultValue != null)
		{
			_instructions.EmitLoad(primitiveDefaultValue);
		}
		else
		{
			_instructions.EmitDefaultValue(type);
		}
	}

	private LocalVariable EnsureAvailableForClosure(ParameterExpression expr)
	{
		if (_locals.TryGetLocalOrClosure(expr, out var local))
		{
			if (!local.InClosure && !local.IsBoxed)
			{
				_locals.Box(expr, _instructions);
			}
			return local;
		}
		if (_parent != null)
		{
			_parent.EnsureAvailableForClosure(expr);
			return _locals.AddClosureVariable(expr);
		}
		throw new InvalidOperationException("unbound variable: " + expr);
	}

	private LocalVariable ResolveLocal(ParameterExpression variable)
	{
		if (!_locals.TryGetLocalOrClosure(variable, out var local))
		{
			return EnsureAvailableForClosure(variable);
		}
		return local;
	}

	private void CompileGetVariable(ParameterExpression variable)
	{
		LoadLocalNoValueTypeCopy(variable);
		EmitCopyValueType(variable.Type);
	}

	private void EmitCopyValueType(Type valueType)
	{
		if (MaybeMutableValueType(valueType))
		{
			_instructions.Emit(ValueTypeCopyInstruction.Instruction);
		}
	}

	private void LoadLocalNoValueTypeCopy(ParameterExpression variable)
	{
		LocalVariable localVariable = ResolveLocal(variable);
		if (localVariable.InClosure)
		{
			_instructions.EmitLoadLocalFromClosure(localVariable.Index);
		}
		else if (localVariable.IsBoxed)
		{
			_instructions.EmitLoadLocalBoxed(localVariable.Index);
		}
		else
		{
			_instructions.EmitLoadLocal(localVariable.Index);
		}
	}

	private bool MaybeMutableValueType(Type type)
	{
		if (type.IsValueType && !type.IsEnum)
		{
			return !type.IsPrimitive;
		}
		return false;
	}

	private void CompileGetBoxedVariable(ParameterExpression variable)
	{
		LocalVariable localVariable = ResolveLocal(variable);
		if (localVariable.InClosure)
		{
			_instructions.EmitLoadLocalFromClosureBoxed(localVariable.Index);
		}
		else
		{
			_instructions.EmitLoadLocal(localVariable.Index);
		}
	}

	private void CompileSetVariable(ParameterExpression variable, bool isVoid)
	{
		LocalVariable localVariable = ResolveLocal(variable);
		if (localVariable.InClosure)
		{
			if (isVoid)
			{
				_instructions.EmitStoreLocalToClosure(localVariable.Index);
			}
			else
			{
				_instructions.EmitAssignLocalToClosure(localVariable.Index);
			}
		}
		else if (localVariable.IsBoxed)
		{
			if (isVoid)
			{
				_instructions.EmitStoreLocalBoxed(localVariable.Index);
			}
			else
			{
				_instructions.EmitAssignLocalBoxed(localVariable.Index);
			}
		}
		else if (isVoid)
		{
			_instructions.EmitStoreLocal(localVariable.Index);
		}
		else
		{
			_instructions.EmitAssignLocal(localVariable.Index);
		}
	}

	private void CompileParameterExpression(Expression expr)
	{
		ParameterExpression variable = (ParameterExpression)expr;
		CompileGetVariable(variable);
	}

	private void CompileBlockExpression(Expression expr, bool asVoid)
	{
		BlockExpression blockExpression = (BlockExpression)expr;
		if (blockExpression.ExpressionCount != 0)
		{
			LocalDefinition[] locals = CompileBlockStart(blockExpression);
			Expression expr2 = blockExpression.Expressions[blockExpression.Expressions.Count - 1];
			Compile(expr2, asVoid);
			CompileBlockEnd(locals);
		}
	}

	private LocalDefinition[] CompileBlockStart(BlockExpression node)
	{
		int count = _instructions.Count;
		ReadOnlyCollection<ParameterExpression> variables = node.Variables;
		LocalDefinition[] array;
		if (variables.Count != 0)
		{
			array = new LocalDefinition[variables.Count];
			int num = 0;
			foreach (ParameterExpression item in variables)
			{
				LocalDefinition localDefinition = _locals.DefineLocal(item, count);
				array[num++] = localDefinition;
				_instructions.EmitInitializeLocal(localDefinition.Index, item.Type);
			}
		}
		else
		{
			array = s_emptyLocals;
		}
		for (int i = 0; i < node.Expressions.Count - 1; i++)
		{
			CompileAsVoid(node.Expressions[i]);
		}
		return array;
	}

	private void CompileBlockEnd(LocalDefinition[] locals)
	{
		foreach (LocalDefinition definition in locals)
		{
			_locals.UndefineLocal(definition, _instructions.Count);
		}
	}

	private void CompileIndexExpression(Expression expr)
	{
		IndexExpression indexExpression = (IndexExpression)expr;
		if (indexExpression.Object != null)
		{
			EmitThisForMethodCall(indexExpression.Object);
		}
		int i = 0;
		for (int argumentCount = indexExpression.ArgumentCount; i < argumentCount; i++)
		{
			Compile(indexExpression.GetArgument(i));
		}
		EmitIndexGet(indexExpression);
	}

	private void EmitIndexGet(IndexExpression index)
	{
		if (index.Indexer != null)
		{
			_instructions.EmitCall(index.Indexer.GetGetMethod(nonPublic: true));
		}
		else if (index.ArgumentCount != 1)
		{
			_instructions.EmitCall(index.Object.Type.GetMethod("Get", BindingFlags.Instance | BindingFlags.Public));
		}
		else
		{
			_instructions.EmitGetArrayItem();
		}
	}

	private void CompileIndexAssignment(BinaryExpression node, bool asVoid)
	{
		IndexExpression indexExpression = (IndexExpression)node.Left;
		if (indexExpression.Object != null)
		{
			EmitThisForMethodCall(indexExpression.Object);
		}
		int i = 0;
		for (int argumentCount = indexExpression.ArgumentCount; i < argumentCount; i++)
		{
			Compile(indexExpression.GetArgument(i));
		}
		Compile(node.Right);
		LocalDefinition definition = default(LocalDefinition);
		if (!asVoid)
		{
			definition = _locals.DefineLocal(Expression.Parameter(node.Right.Type), _instructions.Count);
			_instructions.EmitAssignLocal(definition.Index);
		}
		if (indexExpression.Indexer != null)
		{
			_instructions.EmitCall(indexExpression.Indexer.GetSetMethod(nonPublic: true));
		}
		else if (indexExpression.ArgumentCount != 1)
		{
			_instructions.EmitCall(indexExpression.Object.Type.GetMethod("Set", BindingFlags.Instance | BindingFlags.Public));
		}
		else
		{
			_instructions.EmitSetArrayItem();
		}
		if (!asVoid)
		{
			_instructions.EmitLoadLocal(definition.Index);
			_locals.UndefineLocal(definition, _instructions.Count);
		}
	}

	private void CompileMemberAssignment(BinaryExpression node, bool asVoid)
	{
		MemberExpression memberExpression = (MemberExpression)node.Left;
		Expression expression = memberExpression.Expression;
		if (expression != null)
		{
			EmitThisForMethodCall(expression);
		}
		CompileMemberAssignment(asVoid, memberExpression.Member, node.Right, forBinding: false);
	}

	private void CompileMemberAssignment(bool asVoid, MemberInfo refMember, Expression value, bool forBinding)
	{
		PropertyInfo propertyInfo = refMember as PropertyInfo;
		if (propertyInfo != null)
		{
			MethodInfo setMethod = propertyInfo.GetSetMethod(nonPublic: true);
			if (forBinding && setMethod.IsStatic)
			{
				throw Error.InvalidProgram();
			}
			EmitThisForMethodCall(value);
			int count = _instructions.Count;
			if (!asVoid)
			{
				LocalDefinition definition = _locals.DefineLocal(Expression.Parameter(value.Type), count);
				_instructions.EmitAssignLocal(definition.Index);
				_instructions.EmitCall(setMethod);
				_instructions.EmitLoadLocal(definition.Index);
				_locals.UndefineLocal(definition, _instructions.Count);
			}
			else
			{
				_instructions.EmitCall(setMethod);
			}
			return;
		}
		FieldInfo fieldInfo = (FieldInfo)refMember;
		if (fieldInfo.IsLiteral)
		{
			throw Error.NotSupported();
		}
		if (forBinding && fieldInfo.IsStatic)
		{
			_instructions.UnEmit();
		}
		EmitThisForMethodCall(value);
		int count2 = _instructions.Count;
		if (!asVoid)
		{
			LocalDefinition definition2 = _locals.DefineLocal(Expression.Parameter(value.Type), count2);
			_instructions.EmitAssignLocal(definition2.Index);
			_instructions.EmitStoreField(fieldInfo);
			_instructions.EmitLoadLocal(definition2.Index);
			_locals.UndefineLocal(definition2, _instructions.Count);
		}
		else
		{
			_instructions.EmitStoreField(fieldInfo);
		}
	}

	private void CompileVariableAssignment(BinaryExpression node, bool asVoid)
	{
		Compile(node.Right);
		ParameterExpression variable = (ParameterExpression)node.Left;
		CompileSetVariable(variable, asVoid);
	}

	private void CompileAssignBinaryExpression(Expression expr, bool asVoid)
	{
		BinaryExpression binaryExpression = (BinaryExpression)expr;
		switch (binaryExpression.Left.NodeType)
		{
		case ExpressionType.Index:
			CompileIndexAssignment(binaryExpression, asVoid);
			break;
		case ExpressionType.MemberAccess:
			CompileMemberAssignment(binaryExpression, asVoid);
			break;
		case ExpressionType.Parameter:
		case ExpressionType.Extension:
			CompileVariableAssignment(binaryExpression, asVoid);
			break;
		default:
			throw Error.InvalidLvalue(binaryExpression.Left.NodeType);
		}
	}

	private void CompileBinaryExpression(Expression expr)
	{
		BinaryExpression binaryExpression = (BinaryExpression)expr;
		if (binaryExpression.Method != null)
		{
			if (binaryExpression.IsLifted)
			{
				BranchLabel label = _instructions.MakeLabel();
				LocalDefinition definition = _locals.DefineLocal(Expression.Parameter(binaryExpression.Left.Type), _instructions.Count);
				Compile(binaryExpression.Left);
				_instructions.EmitStoreLocal(definition.Index);
				LocalDefinition definition2 = _locals.DefineLocal(Expression.Parameter(binaryExpression.Right.Type), _instructions.Count);
				Compile(binaryExpression.Right);
				_instructions.EmitStoreLocal(definition2.Index);
				ExpressionType nodeType = binaryExpression.NodeType;
				if ((nodeType == ExpressionType.Equal || nodeType == ExpressionType.NotEqual) && !binaryExpression.IsLiftedToNull)
				{
					BranchLabel branchLabel = _instructions.MakeLabel();
					BranchLabel branchLabel2 = _instructions.MakeLabel();
					_instructions.EmitLoadLocal(definition.Index);
					_instructions.EmitLoad(null, typeof(object));
					_instructions.EmitEqual(typeof(object));
					_instructions.EmitBranchFalse(branchLabel);
					_instructions.EmitLoadLocal(definition2.Index);
					_instructions.EmitLoad(null, typeof(object));
					if (binaryExpression.NodeType == ExpressionType.Equal)
					{
						_instructions.EmitEqual(typeof(object));
					}
					else
					{
						_instructions.EmitNotEqual(typeof(object));
					}
					_instructions.EmitBranch(label, hasResult: false, hasValue: true);
					_instructions.MarkLabel(branchLabel);
					_instructions.EmitLoadLocal(definition2.Index);
					_instructions.EmitLoad(null, typeof(object));
					_instructions.EmitEqual(typeof(object));
					_instructions.EmitBranchFalse(branchLabel2);
					_instructions.EmitLoad((binaryExpression.NodeType == ExpressionType.Equal) ? Utils.BoxedFalse : Utils.BoxedTrue, typeof(bool));
					_instructions.EmitBranch(label, hasResult: false, hasValue: true);
					_instructions.MarkLabel(branchLabel2);
					_instructions.EmitLoadLocal(definition.Index);
					_instructions.EmitLoadLocal(definition2.Index);
					_instructions.EmitCall(binaryExpression.Method);
				}
				else
				{
					BranchLabel branchLabel3 = _instructions.MakeLabel();
					if (binaryExpression.Left.Type.IsNullableOrReferenceType())
					{
						_instructions.EmitLoadLocal(definition.Index);
						_instructions.EmitLoad(null, typeof(object));
						_instructions.EmitEqual(typeof(object));
						_instructions.EmitBranchTrue(branchLabel3);
					}
					if (binaryExpression.Right.Type.IsNullableOrReferenceType())
					{
						_instructions.EmitLoadLocal(definition2.Index);
						_instructions.EmitLoad(null, typeof(object));
						_instructions.EmitEqual(typeof(object));
						_instructions.EmitBranchTrue(branchLabel3);
					}
					_instructions.EmitLoadLocal(definition.Index);
					_instructions.EmitLoadLocal(definition2.Index);
					_instructions.EmitCall(binaryExpression.Method);
					_instructions.EmitBranch(label, hasResult: false, hasValue: true);
					_instructions.MarkLabel(branchLabel3);
					ExpressionType nodeType2 = binaryExpression.NodeType;
					if (((uint)(nodeType2 - 15) <= 1u || (uint)(nodeType2 - 20) <= 1u) && !binaryExpression.IsLiftedToNull)
					{
						_instructions.EmitLoad(Utils.BoxedFalse, typeof(object));
					}
					else
					{
						_instructions.EmitLoad(null, typeof(object));
					}
				}
				_instructions.MarkLabel(label);
				_locals.UndefineLocal(definition, _instructions.Count);
				_locals.UndefineLocal(definition2, _instructions.Count);
			}
			else
			{
				Compile(binaryExpression.Left);
				Compile(binaryExpression.Right);
				_instructions.EmitCall(binaryExpression.Method);
			}
		}
		else
		{
			switch (binaryExpression.NodeType)
			{
			case ExpressionType.ArrayIndex:
				Compile(binaryExpression.Left);
				Compile(binaryExpression.Right);
				_instructions.EmitGetArrayItem();
				break;
			case ExpressionType.Add:
			case ExpressionType.AddChecked:
			case ExpressionType.Divide:
			case ExpressionType.Modulo:
			case ExpressionType.Multiply:
			case ExpressionType.MultiplyChecked:
			case ExpressionType.Subtract:
			case ExpressionType.SubtractChecked:
				CompileArithmetic(binaryExpression.NodeType, binaryExpression.Left, binaryExpression.Right);
				break;
			case ExpressionType.ExclusiveOr:
				Compile(binaryExpression.Left);
				Compile(binaryExpression.Right);
				_instructions.EmitExclusiveOr(binaryExpression.Left.Type);
				break;
			case ExpressionType.Or:
				Compile(binaryExpression.Left);
				Compile(binaryExpression.Right);
				_instructions.EmitOr(binaryExpression.Left.Type);
				break;
			case ExpressionType.And:
				Compile(binaryExpression.Left);
				Compile(binaryExpression.Right);
				_instructions.EmitAnd(binaryExpression.Left.Type);
				break;
			case ExpressionType.Equal:
				CompileEqual(binaryExpression.Left, binaryExpression.Right, binaryExpression.IsLiftedToNull);
				break;
			case ExpressionType.NotEqual:
				CompileNotEqual(binaryExpression.Left, binaryExpression.Right, binaryExpression.IsLiftedToNull);
				break;
			case ExpressionType.GreaterThan:
			case ExpressionType.GreaterThanOrEqual:
			case ExpressionType.LessThan:
			case ExpressionType.LessThanOrEqual:
				CompileComparison(binaryExpression);
				break;
			case ExpressionType.LeftShift:
				Compile(binaryExpression.Left);
				Compile(binaryExpression.Right);
				_instructions.EmitLeftShift(binaryExpression.Left.Type);
				break;
			case ExpressionType.RightShift:
				Compile(binaryExpression.Left);
				Compile(binaryExpression.Right);
				_instructions.EmitRightShift(binaryExpression.Left.Type);
				break;
			default:
				throw new PlatformNotSupportedException(SR.Format("The expression type '{0}' is not supported", binaryExpression.NodeType));
			}
		}
	}

	private void CompileEqual(Expression left, Expression right, bool liftedToNull)
	{
		Compile(left);
		Compile(right);
		_instructions.EmitEqual(left.Type, liftedToNull);
	}

	private void CompileNotEqual(Expression left, Expression right, bool liftedToNull)
	{
		Compile(left);
		Compile(right);
		_instructions.EmitNotEqual(left.Type, liftedToNull);
	}

	private void CompileComparison(BinaryExpression node)
	{
		Expression left = node.Left;
		Expression right = node.Right;
		Compile(left);
		Compile(right);
		switch (node.NodeType)
		{
		case ExpressionType.LessThan:
			_instructions.EmitLessThan(left.Type, node.IsLiftedToNull);
			break;
		case ExpressionType.LessThanOrEqual:
			_instructions.EmitLessThanOrEqual(left.Type, node.IsLiftedToNull);
			break;
		case ExpressionType.GreaterThan:
			_instructions.EmitGreaterThan(left.Type, node.IsLiftedToNull);
			break;
		case ExpressionType.GreaterThanOrEqual:
			_instructions.EmitGreaterThanOrEqual(left.Type, node.IsLiftedToNull);
			break;
		default:
			throw ContractUtils.Unreachable;
		}
	}

	private void CompileArithmetic(ExpressionType nodeType, Expression left, Expression right)
	{
		Compile(left);
		Compile(right);
		switch (nodeType)
		{
		case ExpressionType.Add:
			_instructions.EmitAdd(left.Type, @checked: false);
			break;
		case ExpressionType.AddChecked:
			_instructions.EmitAdd(left.Type, @checked: true);
			break;
		case ExpressionType.Subtract:
			_instructions.EmitSub(left.Type, @checked: false);
			break;
		case ExpressionType.SubtractChecked:
			_instructions.EmitSub(left.Type, @checked: true);
			break;
		case ExpressionType.Multiply:
			_instructions.EmitMul(left.Type, @checked: false);
			break;
		case ExpressionType.MultiplyChecked:
			_instructions.EmitMul(left.Type, @checked: true);
			break;
		case ExpressionType.Divide:
			_instructions.EmitDiv(left.Type);
			break;
		case ExpressionType.Modulo:
			_instructions.EmitModulo(left.Type);
			break;
		default:
			throw ContractUtils.Unreachable;
		}
	}

	private void CompileConvertUnaryExpression(Expression expr)
	{
		UnaryExpression unaryExpression = (UnaryExpression)expr;
		if (unaryExpression.Method != null)
		{
			BranchLabel label = _instructions.MakeLabel();
			BranchLabel branchLabel = _instructions.MakeLabel();
			MethodInfo method = unaryExpression.Method;
			ParameterInfo[] parametersCached = method.GetParametersCached();
			ParameterInfo obj = parametersCached[0];
			Type type = unaryExpression.Operand.Type;
			LocalDefinition definition = _locals.DefineLocal(Expression.Parameter(type), _instructions.Count);
			ByRefUpdater byRefUpdater = null;
			Type type2 = obj.ParameterType;
			if (type2.IsByRef)
			{
				if (unaryExpression.IsLifted)
				{
					Compile(unaryExpression.Operand);
				}
				else
				{
					byRefUpdater = CompileAddress(unaryExpression.Operand, 0);
					type2 = type2.GetElementType();
				}
			}
			else
			{
				Compile(unaryExpression.Operand);
			}
			_instructions.EmitStoreLocal(definition.Index);
			if (!type.IsValueType || (type.IsNullableType() && unaryExpression.IsLiftedToNull))
			{
				_instructions.EmitLoadLocal(definition.Index);
				_instructions.EmitLoad(null, typeof(object));
				_instructions.EmitEqual(typeof(object));
				_instructions.EmitBranchTrue(branchLabel);
			}
			_instructions.EmitLoadLocal(definition.Index);
			if (type.IsNullableType() && type2.Equals(type.GetNonNullableType()))
			{
				_instructions.Emit(NullableMethodCallInstruction.CreateGetValue());
			}
			if (byRefUpdater == null)
			{
				_instructions.EmitCall(method);
			}
			else
			{
				_instructions.EmitByRefCall(method, parametersCached, new ByRefUpdater[1] { byRefUpdater });
				byRefUpdater.UndefineTemps(_instructions, _locals);
			}
			_instructions.EmitBranch(label, hasResult: false, hasValue: true);
			_instructions.MarkLabel(branchLabel);
			_instructions.EmitLoad(null, typeof(object));
			_instructions.MarkLabel(label);
			_locals.UndefineLocal(definition, _instructions.Count);
		}
		else if (unaryExpression.Type == typeof(void))
		{
			CompileAsVoid(unaryExpression.Operand);
		}
		else
		{
			Compile(unaryExpression.Operand);
			CompileConvertToType(unaryExpression.Operand.Type, unaryExpression.Type, unaryExpression.NodeType == ExpressionType.ConvertChecked, unaryExpression.IsLiftedToNull);
		}
	}

	private void CompileConvertToType(Type typeFrom, Type typeTo, bool isChecked, bool isLiftedToNull)
	{
		if (typeTo.Equals(typeFrom) || (typeFrom.IsValueType && typeTo.IsNullableType() && typeTo.GetNonNullableType().Equals(typeFrom)))
		{
			return;
		}
		if (typeTo.IsValueType && typeFrom.IsNullableType() && typeFrom.GetNonNullableType().Equals(typeTo))
		{
			_instructions.Emit(NullableMethodCallInstruction.CreateGetValue());
			return;
		}
		Type type = typeFrom.GetNonNullableType();
		Type type2 = typeTo.GetNonNullableType();
		if ((type.IsNumericOrBool() || type.IsEnum) && (type2.IsNumericOrBool() || type2.IsEnum || type2 == typeof(decimal)))
		{
			Type type3 = null;
			if (type.IsEnum)
			{
				type = Enum.GetUnderlyingType(type);
			}
			if (type2.IsEnum)
			{
				type3 = type2;
				type2 = Enum.GetUnderlyingType(type2);
			}
			TypeCode typeCode = type.GetTypeCode();
			TypeCode typeCode2 = type2.GetTypeCode();
			if (typeCode == typeCode2)
			{
				if ((object)type3 != null)
				{
					if (typeFrom.IsNullableType() && !typeTo.IsNullableType())
					{
						_instructions.Emit(NullableMethodCallInstruction.CreateGetValue());
					}
				}
				else
				{
					_instructions.EmitConvertToUnderlying(typeCode2, isLiftedToNull);
				}
			}
			else if (isChecked)
			{
				_instructions.EmitNumericConvertChecked(typeCode, typeCode2, isLiftedToNull);
			}
			else
			{
				_instructions.EmitNumericConvertUnchecked(typeCode, typeCode2, isLiftedToNull);
			}
			if ((object)type3 != null)
			{
				_instructions.EmitCastToEnum(type3);
			}
		}
		else if (typeTo.IsEnum)
		{
			_instructions.Emit(NullCheckInstruction.Instance);
			_instructions.EmitCastReferenceToEnum(typeTo);
		}
		else if (!(typeTo == typeof(object)) && !typeTo.IsAssignableFrom(typeFrom))
		{
			_instructions.EmitCast(typeTo);
		}
	}

	private void CompileNotExpression(UnaryExpression node)
	{
		Compile(node.Operand);
		_instructions.EmitNot(node.Operand.Type);
	}

	private void CompileUnaryExpression(Expression expr)
	{
		UnaryExpression unaryExpression = (UnaryExpression)expr;
		if (unaryExpression.Method != null)
		{
			EmitUnaryMethodCall(unaryExpression);
			return;
		}
		switch (unaryExpression.NodeType)
		{
		case ExpressionType.Not:
		case ExpressionType.OnesComplement:
			CompileNotExpression(unaryExpression);
			break;
		case ExpressionType.TypeAs:
			CompileTypeAsExpression(unaryExpression);
			break;
		case ExpressionType.ArrayLength:
			Compile(unaryExpression.Operand);
			_instructions.EmitArrayLength();
			break;
		case ExpressionType.NegateChecked:
			Compile(unaryExpression.Operand);
			_instructions.EmitNegateChecked(unaryExpression.Type);
			break;
		case ExpressionType.Negate:
			Compile(unaryExpression.Operand);
			_instructions.EmitNegate(unaryExpression.Type);
			break;
		case ExpressionType.Increment:
			Compile(unaryExpression.Operand);
			_instructions.EmitIncrement(unaryExpression.Type);
			break;
		case ExpressionType.Decrement:
			Compile(unaryExpression.Operand);
			_instructions.EmitDecrement(unaryExpression.Type);
			break;
		case ExpressionType.UnaryPlus:
			Compile(unaryExpression.Operand);
			break;
		case ExpressionType.IsTrue:
		case ExpressionType.IsFalse:
			EmitUnaryBoolCheck(unaryExpression);
			break;
		default:
			throw new PlatformNotSupportedException(SR.Format("The expression type '{0}' is not supported", unaryExpression.NodeType));
		}
	}

	private void EmitUnaryMethodCall(UnaryExpression node)
	{
		Compile(node.Operand);
		if (node.IsLifted)
		{
			BranchLabel branchLabel = _instructions.MakeLabel();
			BranchLabel label = _instructions.MakeLabel();
			_instructions.EmitCoalescingBranch(branchLabel);
			_instructions.EmitBranch(label);
			_instructions.MarkLabel(branchLabel);
			_instructions.EmitCall(node.Method);
			_instructions.MarkLabel(label);
		}
		else
		{
			_instructions.EmitCall(node.Method);
		}
	}

	private void EmitUnaryBoolCheck(UnaryExpression node)
	{
		Compile(node.Operand);
		if (node.IsLifted)
		{
			BranchLabel branchLabel = _instructions.MakeLabel();
			BranchLabel label = _instructions.MakeLabel();
			_instructions.EmitCoalescingBranch(branchLabel);
			_instructions.EmitBranch(label);
			_instructions.MarkLabel(branchLabel);
			_instructions.EmitLoad(node.NodeType == ExpressionType.IsTrue);
			_instructions.EmitEqual(typeof(bool));
			_instructions.MarkLabel(label);
		}
		else
		{
			_instructions.EmitLoad(node.NodeType == ExpressionType.IsTrue);
			_instructions.EmitEqual(typeof(bool));
		}
	}

	private void CompileAndAlsoBinaryExpression(Expression expr)
	{
		CompileLogicalBinaryExpression((BinaryExpression)expr, andAlso: true);
	}

	private void CompileOrElseBinaryExpression(Expression expr)
	{
		CompileLogicalBinaryExpression((BinaryExpression)expr, andAlso: false);
	}

	private void CompileLogicalBinaryExpression(BinaryExpression b, bool andAlso)
	{
		if (b.Method != null && !b.IsLiftedLogical)
		{
			CompileMethodLogicalBinaryExpression(b, andAlso);
		}
		else if (b.Left.Type == typeof(bool?))
		{
			CompileLiftedLogicalBinaryExpression(b, andAlso);
		}
		else if (b.IsLiftedLogical)
		{
			Compile(b.ReduceUserdefinedLifted());
		}
		else
		{
			CompileUnliftedLogicalBinaryExpression(b, andAlso);
		}
	}

	private void CompileMethodLogicalBinaryExpression(BinaryExpression expr, bool andAlso)
	{
		BranchLabel branchLabel = _instructions.MakeLabel();
		Compile(expr.Left);
		_instructions.EmitDup();
		MethodInfo booleanOperator = TypeUtils.GetBooleanOperator(expr.Method.DeclaringType, andAlso ? "op_False" : "op_True");
		_instructions.EmitCall(booleanOperator);
		_instructions.EmitBranchTrue(branchLabel);
		Compile(expr.Right);
		_instructions.EmitCall(expr.Method);
		_instructions.MarkLabel(branchLabel);
	}

	private void CompileLiftedLogicalBinaryExpression(BinaryExpression node, bool andAlso)
	{
		BranchLabel branchLabel = _instructions.MakeLabel();
		BranchLabel branchLabel2 = _instructions.MakeLabel();
		BranchLabel branchLabel3 = _instructions.MakeLabel();
		BranchLabel label = _instructions.MakeLabel();
		LocalDefinition definition = _locals.DefineLocal(Expression.Parameter(node.Left.Type), _instructions.Count);
		LocalDefinition definition2 = _locals.DefineLocal(Expression.Parameter(node.Left.Type), _instructions.Count);
		Compile(node.Left);
		_instructions.EmitStoreLocal(definition2.Index);
		_instructions.EmitLoadLocal(definition2.Index);
		_instructions.EmitLoad(null, typeof(object));
		_instructions.EmitEqual(typeof(object));
		_instructions.EmitBranchTrue(branchLabel);
		_instructions.EmitLoadLocal(definition2.Index);
		if (andAlso)
		{
			_instructions.EmitBranchFalse(branchLabel2);
		}
		else
		{
			_instructions.EmitBranchTrue(branchLabel2);
		}
		_instructions.MarkLabel(branchLabel);
		LocalDefinition definition3 = _locals.DefineLocal(Expression.Parameter(node.Right.Type), _instructions.Count);
		Compile(node.Right);
		_instructions.EmitStoreLocal(definition3.Index);
		_instructions.EmitLoadLocal(definition3.Index);
		_instructions.EmitLoad(null, typeof(object));
		_instructions.EmitEqual(typeof(object));
		_instructions.EmitBranchTrue(branchLabel3);
		_instructions.EmitLoadLocal(definition3.Index);
		if (andAlso)
		{
			_instructions.EmitBranchFalse(branchLabel2);
		}
		else
		{
			_instructions.EmitBranchTrue(branchLabel2);
		}
		_instructions.EmitLoadLocal(definition2.Index);
		_instructions.EmitLoad(null, typeof(object));
		_instructions.EmitEqual(typeof(object));
		_instructions.EmitBranchTrue(branchLabel3);
		_instructions.EmitLoad(andAlso ? Utils.BoxedTrue : Utils.BoxedFalse, typeof(object));
		_instructions.EmitStoreLocal(definition.Index);
		_instructions.EmitBranch(label);
		_instructions.MarkLabel(branchLabel2);
		_instructions.EmitLoad(andAlso ? Utils.BoxedFalse : Utils.BoxedTrue, typeof(object));
		_instructions.EmitStoreLocal(definition.Index);
		_instructions.EmitBranch(label);
		_instructions.MarkLabel(branchLabel3);
		_instructions.EmitLoad(null, typeof(object));
		_instructions.EmitStoreLocal(definition.Index);
		_instructions.MarkLabel(label);
		_instructions.EmitLoadLocal(definition.Index);
		_locals.UndefineLocal(definition2, _instructions.Count);
		_locals.UndefineLocal(definition3, _instructions.Count);
		_locals.UndefineLocal(definition, _instructions.Count);
	}

	private void CompileUnliftedLogicalBinaryExpression(BinaryExpression expr, bool andAlso)
	{
		BranchLabel branchLabel = _instructions.MakeLabel();
		BranchLabel label = _instructions.MakeLabel();
		Compile(expr.Left);
		if (andAlso)
		{
			_instructions.EmitBranchFalse(branchLabel);
		}
		else
		{
			_instructions.EmitBranchTrue(branchLabel);
		}
		Compile(expr.Right);
		_instructions.EmitBranch(label, hasResult: false, hasValue: true);
		_instructions.MarkLabel(branchLabel);
		_instructions.EmitLoad(!andAlso);
		_instructions.MarkLabel(label);
	}

	private void CompileConditionalExpression(Expression expr, bool asVoid)
	{
		ConditionalExpression conditionalExpression = (ConditionalExpression)expr;
		Compile(conditionalExpression.Test);
		if (conditionalExpression.IfTrue == Utils.Empty)
		{
			BranchLabel branchLabel = _instructions.MakeLabel();
			_instructions.EmitBranchTrue(branchLabel);
			Compile(conditionalExpression.IfFalse, asVoid);
			_instructions.MarkLabel(branchLabel);
			return;
		}
		BranchLabel branchLabel2 = _instructions.MakeLabel();
		_instructions.EmitBranchFalse(branchLabel2);
		Compile(conditionalExpression.IfTrue, asVoid);
		if (conditionalExpression.IfFalse != Utils.Empty)
		{
			BranchLabel label = _instructions.MakeLabel();
			_instructions.EmitBranch(label, hasResult: false, !asVoid);
			_instructions.MarkLabel(branchLabel2);
			Compile(conditionalExpression.IfFalse, asVoid);
			_instructions.MarkLabel(label);
		}
		else
		{
			_instructions.MarkLabel(branchLabel2);
		}
	}

	private void CompileLoopExpression(Expression expr)
	{
		LoopExpression loopExpression = (LoopExpression)expr;
		PushLabelBlock(LabelScopeKind.Statement);
		LabelInfo labelInfo = DefineLabel(loopExpression.BreakLabel);
		LabelInfo labelInfo2 = DefineLabel(loopExpression.ContinueLabel);
		_instructions.MarkLabel(labelInfo2.GetLabel(this));
		CompileAsVoid(loopExpression.Body);
		_instructions.EmitBranch(labelInfo2.GetLabel(this), loopExpression.Type != typeof(void), hasValue: false);
		_instructions.MarkLabel(labelInfo.GetLabel(this));
		PopLabelBlock(LabelScopeKind.Statement);
	}

	private void CompileSwitchExpression(Expression expr)
	{
		SwitchExpression switchExpression = (SwitchExpression)expr;
		if (switchExpression.Cases.All((SwitchCase c) => c.TestValues.All((Expression t) => t is ConstantExpression)))
		{
			if (switchExpression.Cases.Count == 0)
			{
				CompileAsVoid(switchExpression.SwitchValue);
				if (switchExpression.DefaultBody != null)
				{
					Compile(switchExpression.DefaultBody);
				}
				return;
			}
			TypeCode typeCode = switchExpression.SwitchValue.Type.GetTypeCode();
			if (switchExpression.Comparison == null)
			{
				switch (typeCode)
				{
				case TypeCode.Int32:
					CompileIntSwitchExpression<int>(switchExpression);
					return;
				case TypeCode.SByte:
				case TypeCode.Byte:
				case TypeCode.Int16:
				case TypeCode.UInt16:
				case TypeCode.UInt32:
				case TypeCode.Int64:
				case TypeCode.UInt64:
					CompileIntSwitchExpression<object>(switchExpression);
					return;
				}
			}
			if (typeCode == TypeCode.String)
			{
				MethodInfo methodInfo = CachedReflectionInfo.String_op_Equality_String_String;
				if (methodInfo != null && !methodInfo.IsStatic)
				{
					methodInfo = null;
				}
				if (object.Equals(switchExpression.Comparison, methodInfo))
				{
					CompileStringSwitchExpression(switchExpression);
					return;
				}
			}
		}
		LocalDefinition definition = _locals.DefineLocal(Expression.Parameter(switchExpression.SwitchValue.Type), _instructions.Count);
		Compile(switchExpression.SwitchValue);
		_instructions.EmitStoreLocal(definition.Index);
		LabelTarget target = Expression.Label(switchExpression.Type, "done");
		foreach (SwitchCase @case in switchExpression.Cases)
		{
			foreach (Expression testValue in @case.TestValues)
			{
				CompileConditionalExpression(Expression.Condition(Expression.Equal(definition.Parameter, testValue, liftToNull: false, switchExpression.Comparison), Expression.Goto(target, @case.Body), Utils.Empty), asVoid: true);
			}
		}
		CompileLabelExpression(Expression.Label(target, switchExpression.DefaultBody));
		_locals.UndefineLocal(definition, _instructions.Count);
	}

	private void CompileIntSwitchExpression<T>(SwitchExpression node)
	{
		LabelInfo labelInfo = DefineLabel(null);
		bool flag = node.Type != typeof(void);
		Compile(node.SwitchValue);
		Dictionary<T, int> dictionary = new Dictionary<T, int>();
		int count = _instructions.Count;
		_instructions.EmitIntSwitch(dictionary);
		if (node.DefaultBody != null)
		{
			Compile(node.DefaultBody, !flag);
		}
		_instructions.EmitBranch(labelInfo.GetLabel(this), hasResult: false, flag);
		for (int i = 0; i < node.Cases.Count; i++)
		{
			SwitchCase switchCase = node.Cases[i];
			int value = _instructions.Count - count;
			foreach (ConstantExpression testValue in switchCase.TestValues)
			{
				T key = (T)testValue.Value;
				dictionary.TryAdd(key, value);
			}
			Compile(switchCase.Body, !flag);
			if (i < node.Cases.Count - 1)
			{
				_instructions.EmitBranch(labelInfo.GetLabel(this), hasResult: false, flag);
			}
		}
		_instructions.MarkLabel(labelInfo.GetLabel(this));
	}

	private void CompileStringSwitchExpression(SwitchExpression node)
	{
		LabelInfo labelInfo = DefineLabel(null);
		bool flag = node.Type != typeof(void);
		Compile(node.SwitchValue);
		Dictionary<string, int> dictionary = new Dictionary<string, int>();
		int count = _instructions.Count;
		StrongBox<int> strongBox = new StrongBox<int>(1);
		_instructions.EmitStringSwitch(dictionary, strongBox);
		if (node.DefaultBody != null)
		{
			Compile(node.DefaultBody, !flag);
		}
		_instructions.EmitBranch(labelInfo.GetLabel(this), hasResult: false, flag);
		for (int i = 0; i < node.Cases.Count; i++)
		{
			SwitchCase switchCase = node.Cases[i];
			int value = _instructions.Count - count;
			foreach (ConstantExpression testValue in switchCase.TestValues)
			{
				string text = (string)testValue.Value;
				if (text == null)
				{
					if (strongBox.Value == 1)
					{
						strongBox.Value = value;
					}
				}
				else
				{
					dictionary.TryAdd(text, value);
				}
			}
			Compile(switchCase.Body, !flag);
			if (i < node.Cases.Count - 1)
			{
				_instructions.EmitBranch(labelInfo.GetLabel(this), hasResult: false, flag);
			}
		}
		_instructions.MarkLabel(labelInfo.GetLabel(this));
	}

	private void CompileLabelExpression(Expression expr)
	{
		LabelExpression labelExpression = (LabelExpression)expr;
		LabelInfo info = null;
		if (_labelBlock.Kind == LabelScopeKind.Block)
		{
			_labelBlock.TryGetLabelInfo(labelExpression.Target, out info);
			if (info == null && _labelBlock.Parent.Kind == LabelScopeKind.Switch)
			{
				_labelBlock.Parent.TryGetLabelInfo(labelExpression.Target, out info);
			}
		}
		if (info == null)
		{
			info = DefineLabel(labelExpression.Target);
		}
		if (labelExpression.DefaultValue != null)
		{
			if (labelExpression.Target.Type == typeof(void))
			{
				CompileAsVoid(labelExpression.DefaultValue);
			}
			else
			{
				Compile(labelExpression.DefaultValue);
			}
		}
		_instructions.MarkLabel(info.GetLabel(this));
	}

	private void CompileGotoExpression(Expression expr)
	{
		GotoExpression gotoExpression = (GotoExpression)expr;
		LabelInfo labelInfo = ReferenceLabel(gotoExpression.Target);
		if (gotoExpression.Value != null)
		{
			Compile(gotoExpression.Value);
		}
		_instructions.EmitGoto(labelInfo.GetLabel(this), gotoExpression.Type != typeof(void), gotoExpression.Value != null && gotoExpression.Value.Type != typeof(void), gotoExpression.Target.Type != typeof(void));
	}

	private void PushLabelBlock(LabelScopeKind type)
	{
		_labelBlock = new LabelScopeInfo(_labelBlock, type);
	}

	private void PopLabelBlock(LabelScopeKind kind)
	{
		_labelBlock = _labelBlock.Parent;
	}

	private LabelInfo EnsureLabel(LabelTarget node)
	{
		if (!_treeLabels.TryGetValue(node, out var value))
		{
			value = (_treeLabels[node] = new LabelInfo(node));
		}
		return value;
	}

	private LabelInfo ReferenceLabel(LabelTarget node)
	{
		LabelInfo labelInfo = EnsureLabel(node);
		labelInfo.Reference(_labelBlock);
		return labelInfo;
	}

	private LabelInfo DefineLabel(LabelTarget node)
	{
		if (node == null)
		{
			return new LabelInfo(null);
		}
		LabelInfo labelInfo = EnsureLabel(node);
		labelInfo.Define(_labelBlock);
		return labelInfo;
	}

	private bool TryPushLabelBlock(Expression node)
	{
		switch (node.NodeType)
		{
		default:
			if (_labelBlock.Kind != LabelScopeKind.Expression)
			{
				PushLabelBlock(LabelScopeKind.Expression);
				return true;
			}
			return false;
		case ExpressionType.Label:
			if (_labelBlock.Kind == LabelScopeKind.Block)
			{
				LabelTarget target = ((LabelExpression)node).Target;
				if (_labelBlock.ContainsTarget(target))
				{
					return false;
				}
				if (_labelBlock.Parent.Kind == LabelScopeKind.Switch && _labelBlock.Parent.ContainsTarget(target))
				{
					return false;
				}
			}
			PushLabelBlock(LabelScopeKind.Statement);
			return true;
		case ExpressionType.Block:
			PushLabelBlock(LabelScopeKind.Block);
			if (_labelBlock.Parent.Kind != LabelScopeKind.Switch)
			{
				DefineBlockLabels(node);
			}
			return true;
		case ExpressionType.Switch:
		{
			PushLabelBlock(LabelScopeKind.Switch);
			SwitchExpression switchExpression = (SwitchExpression)node;
			foreach (SwitchCase @case in switchExpression.Cases)
			{
				DefineBlockLabels(@case.Body);
			}
			DefineBlockLabels(switchExpression.DefaultBody);
			return true;
		}
		case ExpressionType.Convert:
			if (!(node.Type != typeof(void)))
			{
				PushLabelBlock(LabelScopeKind.Statement);
				return true;
			}
			goto default;
		case ExpressionType.Conditional:
		case ExpressionType.Goto:
		case ExpressionType.Loop:
			PushLabelBlock(LabelScopeKind.Statement);
			return true;
		}
	}

	private void DefineBlockLabels(Expression node)
	{
		if (!(node is BlockExpression blockExpression))
		{
			return;
		}
		int i = 0;
		for (int count = blockExpression.Expressions.Count; i < count; i++)
		{
			if (blockExpression.Expressions[i] is LabelExpression labelExpression)
			{
				DefineLabel(labelExpression.Target);
			}
		}
	}

	private void CheckRethrow()
	{
		for (LabelScopeInfo labelScopeInfo = _labelBlock; labelScopeInfo != null; labelScopeInfo = labelScopeInfo.Parent)
		{
			if (labelScopeInfo.Kind == LabelScopeKind.Catch)
			{
				return;
			}
			if (labelScopeInfo.Kind == LabelScopeKind.Finally)
			{
				break;
			}
		}
		throw Error.RethrowRequiresCatch();
	}

	private void CompileThrowUnaryExpression(Expression expr, bool asVoid)
	{
		UnaryExpression unaryExpression = (UnaryExpression)expr;
		if (unaryExpression.Operand == null)
		{
			CheckRethrow();
			CompileParameterExpression(_exceptionForRethrowStack.Peek());
			if (asVoid)
			{
				_instructions.EmitRethrowVoid();
			}
			else
			{
				_instructions.EmitRethrow();
			}
		}
		else
		{
			Compile(unaryExpression.Operand);
			if (asVoid)
			{
				_instructions.EmitThrowVoid();
			}
			else
			{
				_instructions.EmitThrow();
			}
		}
	}

	private void CompileTryExpression(Expression expr)
	{
		TryExpression tryExpression = (TryExpression)expr;
		if (tryExpression.Fault != null)
		{
			CompileTryFaultExpression(tryExpression);
			return;
		}
		BranchLabel label = _instructions.MakeLabel();
		BranchLabel branchLabel = _instructions.MakeLabel();
		int count = _instructions.Count;
		BranchLabel branchLabel2 = null;
		if (tryExpression.Finally != null)
		{
			branchLabel2 = _instructions.MakeLabel();
			_instructions.EmitEnterTryFinally(branchLabel2);
		}
		else
		{
			_instructions.EmitEnterTryCatch();
		}
		List<ExceptionHandler> list = null;
		EnterTryCatchFinallyInstruction enterTryCatchFinallyInstruction = _instructions.GetInstruction(count) as EnterTryCatchFinallyInstruction;
		PushLabelBlock(LabelScopeKind.Try);
		bool flag = tryExpression.Type != typeof(void);
		Compile(tryExpression.Body, !flag);
		int count2 = _instructions.Count;
		_instructions.MarkLabel(branchLabel);
		_instructions.EmitGoto(label, flag, flag, flag);
		if (tryExpression.Handlers.Count > 0)
		{
			list = new List<ExceptionHandler>();
			foreach (CatchBlock handler in tryExpression.Handlers)
			{
				ParameterExpression parameterExpression = handler.Variable ?? Expression.Parameter(handler.Test);
				LocalDefinition definition = _locals.DefineLocal(parameterExpression, _instructions.Count);
				_exceptionForRethrowStack.Push(parameterExpression);
				ExceptionFilter filter = null;
				if (handler.Filter != null)
				{
					PushLabelBlock(LabelScopeKind.Filter);
					_instructions.EmitEnterExceptionFilter();
					int labelIndex = _instructions.MarkRuntimeLabel();
					int count3 = _instructions.Count;
					CompileSetVariable(parameterExpression, isVoid: true);
					Compile(handler.Filter);
					CompileGetVariable(parameterExpression);
					filter = new ExceptionFilter(labelIndex, count3, _instructions.Count);
					_instructions.EmitLeaveExceptionFilter();
					PopLabelBlock(LabelScopeKind.Filter);
				}
				PushLabelBlock(LabelScopeKind.Catch);
				if (flag)
				{
					_instructions.EmitEnterExceptionHandlerNonVoid();
				}
				else
				{
					_instructions.EmitEnterExceptionHandlerVoid();
				}
				int labelIndex2 = _instructions.MarkRuntimeLabel();
				int count4 = _instructions.Count;
				CompileSetVariable(parameterExpression, isVoid: true);
				Compile(handler.Body, !flag);
				_exceptionForRethrowStack.Pop();
				_instructions.EmitLeaveExceptionHandler(flag, branchLabel);
				list.Add(new ExceptionHandler(labelIndex2, count4, _instructions.Count, handler.Test, filter));
				PopLabelBlock(LabelScopeKind.Catch);
				_locals.UndefineLocal(definition, _instructions.Count);
			}
		}
		if (tryExpression.Finally != null)
		{
			PushLabelBlock(LabelScopeKind.Finally);
			_instructions.MarkLabel(branchLabel2);
			_instructions.EmitEnterFinally(branchLabel2);
			CompileAsVoid(tryExpression.Finally);
			_instructions.EmitLeaveFinally();
			enterTryCatchFinallyInstruction.SetTryHandler(new TryCatchFinallyHandler(count, count2, branchLabel.TargetIndex, branchLabel2.TargetIndex, _instructions.Count, list?.ToArray()));
			PopLabelBlock(LabelScopeKind.Finally);
		}
		else
		{
			enterTryCatchFinallyInstruction.SetTryHandler(new TryCatchFinallyHandler(count, count2, branchLabel.TargetIndex, list.ToArray()));
		}
		_instructions.MarkLabel(label);
		PopLabelBlock(LabelScopeKind.Try);
	}

	private void CompileTryFaultExpression(TryExpression expr)
	{
		int count = _instructions.Count;
		BranchLabel branchLabel = _instructions.MakeLabel();
		EnterTryFaultInstruction enterTryFaultInstruction = _instructions.EmitEnterTryFault(branchLabel);
		PushLabelBlock(LabelScopeKind.Try);
		bool flag = expr.Type != typeof(void);
		Compile(expr.Body, !flag);
		int count2 = _instructions.Count;
		_instructions.EmitGoto(branchLabel, flag, flag, flag);
		PushLabelBlock(LabelScopeKind.Finally);
		BranchLabel branchLabel2 = _instructions.MakeLabel();
		_instructions.MarkLabel(branchLabel2);
		_instructions.EmitEnterFault(branchLabel2);
		CompileAsVoid(expr.Fault);
		_instructions.EmitLeaveFault();
		enterTryFaultInstruction.SetTryHandler(new TryFaultHandler(count, count2, branchLabel2.TargetIndex, _instructions.Count));
		PopLabelBlock(LabelScopeKind.Finally);
		PopLabelBlock(LabelScopeKind.Try);
		_instructions.MarkLabel(branchLabel);
	}

	private void CompileMethodCallExpression(Expression expr)
	{
		MethodCallExpression methodCallExpression = (MethodCallExpression)expr;
		CompileMethodCallExpression(methodCallExpression.Object, methodCallExpression.Method, methodCallExpression);
	}

	private void CompileMethodCallExpression(Expression @object, MethodInfo method, IArgumentProvider arguments)
	{
		ParameterInfo[] parametersCached = method.GetParametersCached();
		List<ByRefUpdater> list = null;
		if (!method.IsStatic)
		{
			ByRefUpdater byRefUpdater = CompileAddress(@object, -1);
			if (byRefUpdater != null)
			{
				list = new List<ByRefUpdater> { byRefUpdater };
			}
		}
		int i = 0;
		for (int argumentCount = arguments.ArgumentCount; i < argumentCount; i++)
		{
			Expression argument = arguments.GetArgument(i);
			if (parametersCached[i].ParameterType.IsByRef)
			{
				ByRefUpdater byRefUpdater2 = CompileAddress(argument, i);
				if (byRefUpdater2 != null)
				{
					if (list == null)
					{
						list = new List<ByRefUpdater>();
					}
					list.Add(byRefUpdater2);
				}
			}
			else
			{
				Compile(argument);
			}
		}
		if (!method.IsStatic && @object.Type.IsNullableType())
		{
			_instructions.EmitNullableCall(method, parametersCached);
			return;
		}
		if (list == null)
		{
			_instructions.EmitCall(method, parametersCached);
			return;
		}
		_instructions.EmitByRefCall(method, parametersCached, list.ToArray());
		foreach (ByRefUpdater item in list)
		{
			item.UndefineTemps(_instructions, _locals);
		}
	}

	private ByRefUpdater CompileArrayIndexAddress(Expression array, Expression index, int argumentIndex)
	{
		LocalDefinition array2 = _locals.DefineLocal(Expression.Parameter(array.Type, "array"), _instructions.Count);
		LocalDefinition index2 = _locals.DefineLocal(Expression.Parameter(index.Type, "index"), _instructions.Count);
		Compile(array);
		_instructions.EmitStoreLocal(array2.Index);
		Compile(index);
		_instructions.EmitStoreLocal(index2.Index);
		_instructions.EmitLoadLocal(array2.Index);
		_instructions.EmitLoadLocal(index2.Index);
		_instructions.EmitGetArrayItem();
		return new ArrayByRefUpdater(array2, index2, argumentIndex);
	}

	private void EmitThisForMethodCall(Expression node)
	{
		CompileAddress(node, -1);
	}

	private static bool ShouldWritebackNode(Expression node)
	{
		if (node.Type.IsValueType)
		{
			switch (node.NodeType)
			{
			case ExpressionType.ArrayIndex:
			case ExpressionType.Call:
			case ExpressionType.Parameter:
				return true;
			case ExpressionType.Index:
				return ((IndexExpression)node).Object.Type.IsArray;
			case ExpressionType.MemberAccess:
				return ((MemberExpression)node).Member is FieldInfo;
			}
		}
		return false;
	}

	private ByRefUpdater CompileAddress(Expression node, int index)
	{
		if (index != -1 || ShouldWritebackNode(node))
		{
			switch (node.NodeType)
			{
			case ExpressionType.Parameter:
				LoadLocalNoValueTypeCopy((ParameterExpression)node);
				return new ParameterByRefUpdater(ResolveLocal((ParameterExpression)node), index);
			case ExpressionType.ArrayIndex:
			{
				BinaryExpression binaryExpression = (BinaryExpression)node;
				return CompileArrayIndexAddress(binaryExpression.Left, binaryExpression.Right, index);
			}
			case ExpressionType.Index:
			{
				IndexExpression indexExpression = (IndexExpression)node;
				if (indexExpression.Indexer != null)
				{
					LocalDefinition? obj = null;
					if (indexExpression.Object != null)
					{
						obj = _locals.DefineLocal(Expression.Parameter(indexExpression.Object.Type), _instructions.Count);
						EmitThisForMethodCall(indexExpression.Object);
						_instructions.EmitDup();
						_instructions.EmitStoreLocal(obj.GetValueOrDefault().Index);
					}
					int argumentCount = indexExpression.ArgumentCount;
					LocalDefinition[] array = new LocalDefinition[argumentCount];
					for (int i = 0; i < argumentCount; i++)
					{
						Expression argument = indexExpression.GetArgument(i);
						Compile(argument);
						LocalDefinition localDefinition = _locals.DefineLocal(Expression.Parameter(argument.Type), _instructions.Count);
						_instructions.EmitDup();
						_instructions.EmitStoreLocal(localDefinition.Index);
						array[i] = localDefinition;
					}
					EmitIndexGet(indexExpression);
					return new IndexMethodByRefUpdater(obj, array, indexExpression.Indexer.GetSetMethod(), index);
				}
				if (indexExpression.ArgumentCount == 1)
				{
					return CompileArrayIndexAddress(indexExpression.Object, indexExpression.GetArgument(0), index);
				}
				return CompileMultiDimArrayAccess(indexExpression.Object, indexExpression, index);
			}
			case ExpressionType.MemberAccess:
			{
				MemberExpression memberExpression = (MemberExpression)node;
				LocalDefinition? obj2 = null;
				if (memberExpression.Expression != null)
				{
					obj2 = _locals.DefineLocal(Expression.Parameter(memberExpression.Expression.Type, "member"), _instructions.Count);
					EmitThisForMethodCall(memberExpression.Expression);
					_instructions.EmitDup();
					_instructions.EmitStoreLocal(obj2.GetValueOrDefault().Index);
				}
				FieldInfo fieldInfo = memberExpression.Member as FieldInfo;
				if (fieldInfo != null)
				{
					_instructions.EmitLoadField(fieldInfo);
					if (!fieldInfo.IsLiteral && !fieldInfo.IsInitOnly)
					{
						return new FieldByRefUpdater(obj2, fieldInfo, index);
					}
					return null;
				}
				PropertyInfo propertyInfo = (PropertyInfo)memberExpression.Member;
				_instructions.EmitCall(propertyInfo.GetGetMethod(nonPublic: true));
				if (propertyInfo.CanWrite)
				{
					return new PropertyByRefUpdater(obj2, propertyInfo, index);
				}
				return null;
			}
			case ExpressionType.Call:
			{
				MethodCallExpression methodCallExpression = (MethodCallExpression)node;
				if (!methodCallExpression.Method.IsStatic && methodCallExpression.Object.Type.IsArray && methodCallExpression.Method == methodCallExpression.Object.Type.GetMethod("Get", BindingFlags.Instance | BindingFlags.Public))
				{
					return CompileMultiDimArrayAccess(methodCallExpression.Object, methodCallExpression, index);
				}
				break;
			}
			}
		}
		Compile(node);
		return null;
	}

	private ByRefUpdater CompileMultiDimArrayAccess(Expression array, IArgumentProvider arguments, int index)
	{
		Compile(array);
		LocalDefinition value = _locals.DefineLocal(Expression.Parameter(array.Type), _instructions.Count);
		_instructions.EmitDup();
		_instructions.EmitStoreLocal(value.Index);
		int argumentCount = arguments.ArgumentCount;
		LocalDefinition[] array2 = new LocalDefinition[argumentCount];
		for (int i = 0; i < argumentCount; i++)
		{
			Expression argument = arguments.GetArgument(i);
			Compile(argument);
			LocalDefinition localDefinition = _locals.DefineLocal(Expression.Parameter(argument.Type), _instructions.Count);
			_instructions.EmitDup();
			_instructions.EmitStoreLocal(localDefinition.Index);
			array2[i] = localDefinition;
		}
		_instructions.EmitCall(array.Type.GetMethod("Get", BindingFlags.Instance | BindingFlags.Public));
		return new IndexMethodByRefUpdater(value, array2, array.Type.GetMethod("Set", BindingFlags.Instance | BindingFlags.Public), index);
	}

	private void CompileNewExpression(Expression expr)
	{
		NewExpression newExpression = (NewExpression)expr;
		if (newExpression.Constructor != null)
		{
			if (newExpression.Constructor.DeclaringType.IsAbstract)
			{
				throw Error.NonAbstractConstructorRequired();
			}
			ParameterInfo[] parametersCached = newExpression.Constructor.GetParametersCached();
			List<ByRefUpdater> list = null;
			for (int i = 0; i < parametersCached.Length; i++)
			{
				Expression argument = newExpression.GetArgument(i);
				if (parametersCached[i].ParameterType.IsByRef)
				{
					ByRefUpdater byRefUpdater = CompileAddress(argument, i);
					if (byRefUpdater != null)
					{
						if (list == null)
						{
							list = new List<ByRefUpdater>();
						}
						list.Add(byRefUpdater);
					}
				}
				else
				{
					Compile(argument);
				}
			}
			if (list != null)
			{
				_instructions.EmitByRefNew(newExpression.Constructor, parametersCached, list.ToArray());
			}
			else
			{
				_instructions.EmitNew(newExpression.Constructor, parametersCached);
			}
		}
		else
		{
			Type type = newExpression.Type;
			if (type.IsNullableType())
			{
				_instructions.EmitLoad(null);
			}
			else
			{
				_instructions.EmitDefaultValue(type);
			}
		}
	}

	private void CompileMemberExpression(Expression expr)
	{
		MemberExpression memberExpression = (MemberExpression)expr;
		CompileMember(memberExpression.Expression, memberExpression.Member, forBinding: false);
	}

	private void CompileMember(Expression from, MemberInfo member, bool forBinding)
	{
		FieldInfo fieldInfo = member as FieldInfo;
		if (fieldInfo != null)
		{
			if (fieldInfo.IsLiteral)
			{
				_instructions.EmitLoad(fieldInfo.GetValue(null), fieldInfo.FieldType);
			}
			else if (fieldInfo.IsStatic)
			{
				if (forBinding)
				{
					throw Error.InvalidProgram();
				}
				if (fieldInfo.IsInitOnly)
				{
					_instructions.EmitLoad(fieldInfo.GetValue(null), fieldInfo.FieldType);
				}
				else
				{
					_instructions.EmitLoadField(fieldInfo);
				}
			}
			else
			{
				if (from != null)
				{
					EmitThisForMethodCall(from);
				}
				_instructions.EmitLoadField(fieldInfo);
			}
			return;
		}
		PropertyInfo propertyInfo = (PropertyInfo)member;
		if (propertyInfo != null)
		{
			MethodInfo getMethod = propertyInfo.GetGetMethod(nonPublic: true);
			if (forBinding && getMethod.IsStatic)
			{
				throw Error.InvalidProgram();
			}
			if (from != null)
			{
				EmitThisForMethodCall(from);
			}
			if (!getMethod.IsStatic && from != null && from.Type.IsNullableType())
			{
				_instructions.EmitNullableCall(getMethod, Array.Empty<ParameterInfo>());
			}
			else
			{
				_instructions.EmitCall(getMethod);
			}
		}
	}

	private void CompileNewArrayExpression(Expression expr)
	{
		NewArrayExpression newArrayExpression = (NewArrayExpression)expr;
		foreach (Expression expression in newArrayExpression.Expressions)
		{
			Compile(expression);
		}
		Type elementType = newArrayExpression.Type.GetElementType();
		int count = newArrayExpression.Expressions.Count;
		if (newArrayExpression.NodeType == ExpressionType.NewArrayInit)
		{
			_instructions.EmitNewArrayInit(elementType, count);
		}
		else if (count == 1)
		{
			_instructions.EmitNewArray(elementType);
		}
		else
		{
			_instructions.EmitNewArrayBounds(elementType, count);
		}
	}

	private void CompileDebugInfoExpression(Expression expr)
	{
		DebugInfoExpression debugInfoExpression = (DebugInfoExpression)expr;
		int count = _instructions.Count;
		DebugInfo item = new DebugInfo
		{
			Index = count,
			FileName = debugInfoExpression.Document.FileName,
			StartLine = debugInfoExpression.StartLine,
			EndLine = debugInfoExpression.EndLine,
			IsClear = debugInfoExpression.IsClear
		};
		_debugInfos.Add(item);
	}

	private void CompileRuntimeVariablesExpression(Expression expr)
	{
		RuntimeVariablesExpression runtimeVariablesExpression = (RuntimeVariablesExpression)expr;
		foreach (ParameterExpression variable in runtimeVariablesExpression.Variables)
		{
			EnsureAvailableForClosure(variable);
			CompileGetBoxedVariable(variable);
		}
		_instructions.EmitNewRuntimeVariables(runtimeVariablesExpression.Variables.Count);
	}

	private void CompileLambdaExpression(Expression expr)
	{
		LambdaExpression node = (LambdaExpression)expr;
		LightCompiler lightCompiler = new LightCompiler(this);
		LightDelegateCreator creator = lightCompiler.CompileTop(node);
		if (lightCompiler._locals.ClosureVariables != null)
		{
			foreach (ParameterExpression key in lightCompiler._locals.ClosureVariables.Keys)
			{
				EnsureAvailableForClosure(key);
				CompileGetBoxedVariable(key);
			}
		}
		_instructions.EmitCreateDelegate(creator);
	}

	private void CompileCoalesceBinaryExpression(Expression expr)
	{
		BinaryExpression binaryExpression = (BinaryExpression)expr;
		bool flag = binaryExpression.Conversion != null;
		bool flag2 = false;
		if (!flag && binaryExpression.Left.Type.IsNullableType())
		{
			Type type = binaryExpression.Left.Type;
			if (!binaryExpression.Type.IsNullableType())
			{
				type = type.GetNonNullableType();
			}
			if (!TypeUtils.AreEquivalent(binaryExpression.Type, type))
			{
				flag2 = true;
				flag = true;
			}
		}
		BranchLabel branchLabel = _instructions.MakeLabel();
		BranchLabel label = null;
		Compile(binaryExpression.Left);
		_instructions.EmitCoalescingBranch(branchLabel);
		_instructions.EmitPop();
		Compile(binaryExpression.Right);
		if (flag)
		{
			label = _instructions.MakeLabel();
			_instructions.EmitBranch(label);
		}
		else if (binaryExpression.Right.Type.IsValueType && !TypeUtils.AreEquivalent(binaryExpression.Type, binaryExpression.Right.Type))
		{
			CompileConvertToType(binaryExpression.Right.Type, binaryExpression.Type, isChecked: true, binaryExpression.Type.IsNullableType());
		}
		_instructions.MarkLabel(branchLabel);
		if (binaryExpression.Conversion != null)
		{
			ParameterExpression parameterExpression = Expression.Parameter(binaryExpression.Left.Type, "temp");
			LocalDefinition definition = _locals.DefineLocal(parameterExpression, _instructions.Count);
			_instructions.EmitStoreLocal(definition.Index);
			LambdaExpression conversion = binaryExpression.Conversion;
			MethodInfo invokeMethod = binaryExpression.Conversion.Type.GetInvokeMethod();
			Expression[] arguments = new ParameterExpression[1] { parameterExpression };
			CompileMethodCallExpression(Expression.Call(conversion, invokeMethod, arguments));
			_locals.UndefineLocal(definition, _instructions.Count);
		}
		else if (flag2)
		{
			Type nonNullableType = binaryExpression.Left.Type.GetNonNullableType();
			CompileConvertToType(nonNullableType, binaryExpression.Type, isChecked: true, isLiftedToNull: false);
		}
		if (flag)
		{
			_instructions.MarkLabel(label);
		}
	}

	private void CompileInvocationExpression(Expression expr)
	{
		InvocationExpression invocationExpression = (InvocationExpression)expr;
		if (typeof(LambdaExpression).IsAssignableFrom(invocationExpression.Expression.Type))
		{
			MethodInfo method = invocationExpression.Expression.Type.GetMethod("Compile", Array.Empty<Type>());
			CompileMethodCallExpression(Expression.Call(invocationExpression.Expression, method), method.ReturnType.GetInvokeMethod(), invocationExpression);
		}
		else
		{
			CompileMethodCallExpression(invocationExpression.Expression, invocationExpression.Expression.Type.GetInvokeMethod(), invocationExpression);
		}
	}

	private void CompileListInitExpression(Expression expr)
	{
		ListInitExpression listInitExpression = (ListInitExpression)expr;
		EmitThisForMethodCall(listInitExpression.NewExpression);
		ReadOnlyCollection<ElementInit> initializers = listInitExpression.Initializers;
		CompileListInit(initializers);
	}

	private void CompileListInit(ReadOnlyCollection<ElementInit> initializers)
	{
		for (int i = 0; i < initializers.Count; i++)
		{
			ElementInit elementInit = initializers[i];
			_instructions.EmitDup();
			foreach (Expression argument in elementInit.Arguments)
			{
				Compile(argument);
			}
			MethodInfo addMethod = elementInit.AddMethod;
			_instructions.EmitCall(addMethod);
			if (addMethod.ReturnType != typeof(void))
			{
				_instructions.EmitPop();
			}
		}
	}

	private void CompileMemberInitExpression(Expression expr)
	{
		MemberInitExpression memberInitExpression = (MemberInitExpression)expr;
		EmitThisForMethodCall(memberInitExpression.NewExpression);
		CompileMemberInit(memberInitExpression.Bindings);
	}

	private void CompileMemberInit(ReadOnlyCollection<MemberBinding> bindings)
	{
		foreach (MemberBinding binding in bindings)
		{
			switch (binding.BindingType)
			{
			case MemberBindingType.Assignment:
				_instructions.EmitDup();
				CompileMemberAssignment(asVoid: true, ((MemberAssignment)binding).Member, ((MemberAssignment)binding).Expression, forBinding: true);
				break;
			case MemberBindingType.ListBinding:
			{
				MemberListBinding memberListBinding = (MemberListBinding)binding;
				_instructions.EmitDup();
				CompileMember(null, memberListBinding.Member, forBinding: true);
				CompileListInit(memberListBinding.Initializers);
				_instructions.EmitPop();
				break;
			}
			case MemberBindingType.MemberBinding:
			{
				MemberMemberBinding memberMemberBinding = (MemberMemberBinding)binding;
				_instructions.EmitDup();
				Type memberType = GetMemberType(memberMemberBinding.Member);
				if (memberMemberBinding.Member is PropertyInfo && memberType.IsValueType)
				{
					throw Error.CannotAutoInitializeValueTypeMemberThroughProperty(memberMemberBinding.Bindings);
				}
				CompileMember(null, memberMemberBinding.Member, forBinding: true);
				CompileMemberInit(memberMemberBinding.Bindings);
				_instructions.EmitPop();
				break;
			}
			}
		}
	}

	private static Type GetMemberType(MemberInfo member)
	{
		FieldInfo fieldInfo = member as FieldInfo;
		if (fieldInfo != null)
		{
			return fieldInfo.FieldType;
		}
		PropertyInfo propertyInfo = member as PropertyInfo;
		if (propertyInfo != null)
		{
			return propertyInfo.PropertyType;
		}
		throw new InvalidOperationException("MemberNotFieldOrProperty");
	}

	private void CompileQuoteUnaryExpression(Expression expr)
	{
		UnaryExpression unaryExpression = (UnaryExpression)expr;
		QuoteVisitor quoteVisitor = new QuoteVisitor();
		quoteVisitor.Visit(unaryExpression.Operand);
		Dictionary<ParameterExpression, LocalVariable> dictionary = new Dictionary<ParameterExpression, LocalVariable>();
		foreach (ParameterExpression hoistedParameter in quoteVisitor._hoistedParameters)
		{
			EnsureAvailableForClosure(hoistedParameter);
			dictionary[hoistedParameter] = ResolveLocal(hoistedParameter);
		}
		_instructions.Emit(new QuoteInstruction(unaryExpression.Operand, (dictionary.Count > 0) ? dictionary : null));
	}

	private void CompileUnboxUnaryExpression(Expression expr)
	{
		UnaryExpression unaryExpression = (UnaryExpression)expr;
		Compile(unaryExpression.Operand);
		if (unaryExpression.Type.IsValueType && !unaryExpression.Type.IsNullableType())
		{
			_instructions.Emit(NullCheckInstruction.Instance);
		}
	}

	private void CompileTypeEqualExpression(Expression expr)
	{
		TypeBinaryExpression typeBinaryExpression = (TypeBinaryExpression)expr;
		Compile(typeBinaryExpression.Expression);
		if (typeBinaryExpression.Expression.Type == typeof(void))
		{
			_instructions.EmitLoad(typeBinaryExpression.TypeOperand == typeof(void), typeof(bool));
			return;
		}
		_instructions.EmitLoad(typeBinaryExpression.TypeOperand.GetNonNullableType());
		_instructions.EmitTypeEquals();
	}

	private void CompileTypeAsExpression(UnaryExpression node)
	{
		Compile(node.Operand);
		_instructions.EmitTypeAs(node.Type);
	}

	private void CompileTypeIsExpression(Expression expr)
	{
		TypeBinaryExpression typeBinaryExpression = (TypeBinaryExpression)expr;
		AnalyzeTypeIsResult analyzeTypeIsResult = ConstantCheck.AnalyzeTypeIs(typeBinaryExpression);
		Compile(typeBinaryExpression.Expression);
		switch (analyzeTypeIsResult)
		{
		case AnalyzeTypeIsResult.KnownFalse:
		case AnalyzeTypeIsResult.KnownTrue:
			if (typeBinaryExpression.Expression.Type != typeof(void))
			{
				_instructions.EmitPop();
			}
			_instructions.EmitLoad(analyzeTypeIsResult == AnalyzeTypeIsResult.KnownTrue);
			break;
		case AnalyzeTypeIsResult.KnownAssignable:
			_instructions.EmitLoad(null);
			_instructions.EmitNotEqual(typeof(object));
			break;
		default:
			if (typeBinaryExpression.TypeOperand.IsValueType)
			{
				_instructions.EmitLoad(typeBinaryExpression.TypeOperand.GetNonNullableType());
				_instructions.EmitTypeEquals();
			}
			else
			{
				_instructions.EmitTypeIs(typeBinaryExpression.TypeOperand);
			}
			break;
		}
	}

	private void Compile(Expression expr, bool asVoid)
	{
		if (asVoid)
		{
			CompileAsVoid(expr);
		}
		else
		{
			Compile(expr);
		}
	}

	private void CompileAsVoid(Expression expr)
	{
		bool flag = TryPushLabelBlock(expr);
		_ = _instructions.CurrentStackDepth;
		switch (expr.NodeType)
		{
		case ExpressionType.Assign:
			CompileAssignBinaryExpression(expr, asVoid: true);
			break;
		case ExpressionType.Block:
			CompileBlockExpression(expr, asVoid: true);
			break;
		case ExpressionType.Throw:
			CompileThrowUnaryExpression(expr, asVoid: true);
			break;
		default:
			CompileNoLabelPush(expr);
			if (expr.Type != typeof(void))
			{
				_instructions.EmitPop();
			}
			break;
		case ExpressionType.Constant:
		case ExpressionType.Parameter:
		case ExpressionType.Default:
			break;
		}
		if (flag)
		{
			PopLabelBlock(_labelBlock.Kind);
		}
	}

	private void CompileNoLabelPush(Expression expr)
	{
		if (!_guard.TryEnterOnCurrentStack())
		{
			_guard.RunOnEmptyStack(delegate(LightCompiler @this, Expression e)
			{
				@this.CompileNoLabelPush(e);
			}, this, expr);
			return;
		}
		_ = _instructions.CurrentStackDepth;
		switch (expr.NodeType)
		{
		case ExpressionType.Add:
		case ExpressionType.AddChecked:
		case ExpressionType.And:
		case ExpressionType.ArrayIndex:
		case ExpressionType.Divide:
		case ExpressionType.Equal:
		case ExpressionType.ExclusiveOr:
		case ExpressionType.GreaterThan:
		case ExpressionType.GreaterThanOrEqual:
		case ExpressionType.LeftShift:
		case ExpressionType.LessThan:
		case ExpressionType.LessThanOrEqual:
		case ExpressionType.Modulo:
		case ExpressionType.Multiply:
		case ExpressionType.MultiplyChecked:
		case ExpressionType.NotEqual:
		case ExpressionType.Or:
		case ExpressionType.Power:
		case ExpressionType.RightShift:
		case ExpressionType.Subtract:
		case ExpressionType.SubtractChecked:
			CompileBinaryExpression(expr);
			break;
		case ExpressionType.AndAlso:
			CompileAndAlsoBinaryExpression(expr);
			break;
		case ExpressionType.OrElse:
			CompileOrElseBinaryExpression(expr);
			break;
		case ExpressionType.Coalesce:
			CompileCoalesceBinaryExpression(expr);
			break;
		case ExpressionType.ArrayLength:
		case ExpressionType.Negate:
		case ExpressionType.UnaryPlus:
		case ExpressionType.NegateChecked:
		case ExpressionType.Not:
		case ExpressionType.TypeAs:
		case ExpressionType.Decrement:
		case ExpressionType.Increment:
		case ExpressionType.OnesComplement:
		case ExpressionType.IsTrue:
		case ExpressionType.IsFalse:
			CompileUnaryExpression(expr);
			break;
		case ExpressionType.Convert:
		case ExpressionType.ConvertChecked:
			CompileConvertUnaryExpression(expr);
			break;
		case ExpressionType.Quote:
			CompileQuoteUnaryExpression(expr);
			break;
		case ExpressionType.Throw:
			CompileThrowUnaryExpression(expr, expr.Type == typeof(void));
			break;
		case ExpressionType.Unbox:
			CompileUnboxUnaryExpression(expr);
			break;
		case ExpressionType.Call:
			CompileMethodCallExpression(expr);
			break;
		case ExpressionType.Conditional:
			CompileConditionalExpression(expr, expr.Type == typeof(void));
			break;
		case ExpressionType.Constant:
			CompileConstantExpression(expr);
			break;
		case ExpressionType.Invoke:
			CompileInvocationExpression(expr);
			break;
		case ExpressionType.Lambda:
			CompileLambdaExpression(expr);
			break;
		case ExpressionType.ListInit:
			CompileListInitExpression(expr);
			break;
		case ExpressionType.MemberAccess:
			CompileMemberExpression(expr);
			break;
		case ExpressionType.MemberInit:
			CompileMemberInitExpression(expr);
			break;
		case ExpressionType.New:
			CompileNewExpression(expr);
			break;
		case ExpressionType.NewArrayInit:
		case ExpressionType.NewArrayBounds:
			CompileNewArrayExpression(expr);
			break;
		case ExpressionType.Parameter:
			CompileParameterExpression(expr);
			break;
		case ExpressionType.TypeIs:
			CompileTypeIsExpression(expr);
			break;
		case ExpressionType.TypeEqual:
			CompileTypeEqualExpression(expr);
			break;
		case ExpressionType.Assign:
			CompileAssignBinaryExpression(expr, expr.Type == typeof(void));
			break;
		case ExpressionType.Block:
			CompileBlockExpression(expr, expr.Type == typeof(void));
			break;
		case ExpressionType.DebugInfo:
			CompileDebugInfoExpression(expr);
			break;
		case ExpressionType.Default:
			CompileDefaultExpression(expr);
			break;
		case ExpressionType.Goto:
			CompileGotoExpression(expr);
			break;
		case ExpressionType.Index:
			CompileIndexExpression(expr);
			break;
		case ExpressionType.Label:
			CompileLabelExpression(expr);
			break;
		case ExpressionType.RuntimeVariables:
			CompileRuntimeVariablesExpression(expr);
			break;
		case ExpressionType.Loop:
			CompileLoopExpression(expr);
			break;
		case ExpressionType.Switch:
			CompileSwitchExpression(expr);
			break;
		case ExpressionType.Try:
			CompileTryExpression(expr);
			break;
		default:
			Compile(expr.ReduceAndCheck());
			break;
		}
	}

	private void Compile(Expression expr)
	{
		bool num = TryPushLabelBlock(expr);
		CompileNoLabelPush(expr);
		if (num)
		{
			PopLabelBlock(_labelBlock.Kind);
		}
	}
}
