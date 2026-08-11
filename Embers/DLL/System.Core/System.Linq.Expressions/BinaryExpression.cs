using System.Collections.Generic;
using System.Diagnostics;
using System.Dynamic.Utils;
using System.Reflection;
using System.Runtime.CompilerServices;
using Unity;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(BinaryExpressionProxy))]
public class BinaryExpression : Expression
{
	public override bool CanReduce => IsOpAssignment(NodeType);

	public Expression Right { get; }

	public Expression Left { get; }

	public MethodInfo Method => GetMethod();

	public LambdaExpression Conversion => GetConversion();

	public bool IsLifted
	{
		get
		{
			if (NodeType == ExpressionType.Coalesce || NodeType == ExpressionType.Assign)
			{
				return false;
			}
			if (Left.Type.IsNullableType())
			{
				MethodInfo method = GetMethod();
				if (!(method == null))
				{
					return !TypeUtils.AreEquivalent(method.GetParametersCached()[0].ParameterType.GetNonRefType(), Left.Type);
				}
				return true;
			}
			return false;
		}
	}

	public bool IsLiftedToNull
	{
		get
		{
			if (IsLifted)
			{
				return Type.IsNullableType();
			}
			return false;
		}
	}

	internal bool IsLiftedLogical
	{
		get
		{
			Type type = Left.Type;
			Type type2 = Right.Type;
			MethodInfo method = GetMethod();
			ExpressionType nodeType = NodeType;
			if ((nodeType == ExpressionType.AndAlso || nodeType == ExpressionType.OrElse) && TypeUtils.AreEquivalent(type2, type) && type.IsNullableType() && method != null)
			{
				return TypeUtils.AreEquivalent(method.ReturnType, type.GetNonNullableType());
			}
			return false;
		}
	}

	internal bool IsReferenceComparison
	{
		get
		{
			Type type = Left.Type;
			Type type2 = Right.Type;
			MethodInfo method = GetMethod();
			ExpressionType nodeType = NodeType;
			if ((nodeType == ExpressionType.Equal || nodeType == ExpressionType.NotEqual) && method == null && !type.IsValueType)
			{
				return !type2.IsValueType;
			}
			return false;
		}
	}

	internal BinaryExpression(Expression left, Expression right)
	{
		Left = left;
		Right = right;
	}

	private static bool IsOpAssignment(ExpressionType op)
	{
		if ((uint)(op - 63) <= 13u)
		{
			return true;
		}
		return false;
	}

	internal virtual MethodInfo GetMethod()
	{
		return null;
	}

	public BinaryExpression Update(Expression left, LambdaExpression conversion, Expression right)
	{
		if (left == Left && right == Right && conversion == Conversion)
		{
			return this;
		}
		if (IsReferenceComparison)
		{
			if (NodeType == ExpressionType.Equal)
			{
				return Expression.ReferenceEqual(left, right);
			}
			return Expression.ReferenceNotEqual(left, right);
		}
		return Expression.MakeBinary(NodeType, left, right, IsLiftedToNull, Method, conversion);
	}

	public override Expression Reduce()
	{
		if (IsOpAssignment(NodeType))
		{
			return Left.NodeType switch
			{
				ExpressionType.MemberAccess => ReduceMember(), 
				ExpressionType.Index => ReduceIndex(), 
				_ => ReduceVariable(), 
			};
		}
		return this;
	}

	private static ExpressionType GetBinaryOpFromAssignmentOp(ExpressionType op)
	{
		return op switch
		{
			ExpressionType.AddAssign => ExpressionType.Add, 
			ExpressionType.AddAssignChecked => ExpressionType.AddChecked, 
			ExpressionType.SubtractAssign => ExpressionType.Subtract, 
			ExpressionType.SubtractAssignChecked => ExpressionType.SubtractChecked, 
			ExpressionType.MultiplyAssign => ExpressionType.Multiply, 
			ExpressionType.MultiplyAssignChecked => ExpressionType.MultiplyChecked, 
			ExpressionType.DivideAssign => ExpressionType.Divide, 
			ExpressionType.ModuloAssign => ExpressionType.Modulo, 
			ExpressionType.PowerAssign => ExpressionType.Power, 
			ExpressionType.AndAssign => ExpressionType.And, 
			ExpressionType.OrAssign => ExpressionType.Or, 
			ExpressionType.RightShiftAssign => ExpressionType.RightShift, 
			ExpressionType.LeftShiftAssign => ExpressionType.LeftShift, 
			ExpressionType.ExclusiveOrAssign => ExpressionType.ExclusiveOr, 
			_ => throw ContractUtils.Unreachable, 
		};
	}

	private Expression ReduceVariable()
	{
		Expression expression = Expression.MakeBinary(GetBinaryOpFromAssignmentOp(NodeType), Left, Right, liftToNull: false, Method);
		LambdaExpression conversion = GetConversion();
		if (conversion != null)
		{
			expression = Expression.Invoke(conversion, expression);
		}
		return Expression.Assign(Left, expression);
	}

	private Expression ReduceMember()
	{
		MemberExpression memberExpression = (MemberExpression)Left;
		if (memberExpression.Expression == null)
		{
			return ReduceVariable();
		}
		ParameterExpression parameterExpression = Expression.Variable(memberExpression.Expression.Type, "temp1");
		Expression expression = Expression.Assign(parameterExpression, memberExpression.Expression);
		Expression expression2 = Expression.MakeBinary(GetBinaryOpFromAssignmentOp(NodeType), Expression.MakeMemberAccess(parameterExpression, memberExpression.Member), Right, liftToNull: false, Method);
		LambdaExpression conversion = GetConversion();
		if (conversion != null)
		{
			expression2 = Expression.Invoke(conversion, expression2);
		}
		ParameterExpression parameterExpression2 = Expression.Variable(expression2.Type, "temp2");
		expression2 = Expression.Assign(parameterExpression2, expression2);
		Expression expression3 = Expression.Assign(Expression.MakeMemberAccess(parameterExpression, memberExpression.Member), parameterExpression2);
		Expression expression4 = parameterExpression2;
		return Expression.Block(new TrueReadOnlyCollection<ParameterExpression>(parameterExpression, parameterExpression2), new TrueReadOnlyCollection<Expression>(expression, expression2, expression3, expression4));
	}

	private Expression ReduceIndex()
	{
		IndexExpression indexExpression = (IndexExpression)Left;
		ArrayBuilder<ParameterExpression> builder = new ArrayBuilder<ParameterExpression>(indexExpression.ArgumentCount + 2);
		ArrayBuilder<Expression> builder2 = new ArrayBuilder<Expression>(indexExpression.ArgumentCount + 3);
		ParameterExpression parameterExpression = Expression.Variable(indexExpression.Object.Type, "tempObj");
		builder.UncheckedAdd(parameterExpression);
		builder2.UncheckedAdd(Expression.Assign(parameterExpression, indexExpression.Object));
		int argumentCount = indexExpression.ArgumentCount;
		ArrayBuilder<Expression> builder3 = new ArrayBuilder<Expression>(argumentCount);
		for (int i = 0; i < argumentCount; i++)
		{
			Expression argument = indexExpression.GetArgument(i);
			ParameterExpression parameterExpression2 = Expression.Variable(argument.Type, "tempArg" + i);
			builder.UncheckedAdd(parameterExpression2);
			builder3.UncheckedAdd(parameterExpression2);
			builder2.UncheckedAdd(Expression.Assign(parameterExpression2, argument));
		}
		IndexExpression left = Expression.MakeIndex(parameterExpression, indexExpression.Indexer, builder3.ToReadOnly());
		Expression expression = Expression.MakeBinary(GetBinaryOpFromAssignmentOp(NodeType), left, Right, liftToNull: false, Method);
		LambdaExpression conversion = GetConversion();
		if (conversion != null)
		{
			expression = Expression.Invoke(conversion, expression);
		}
		ParameterExpression parameterExpression3 = Expression.Variable(expression.Type, "tempValue");
		builder.UncheckedAdd(parameterExpression3);
		builder2.UncheckedAdd(Expression.Assign(parameterExpression3, expression));
		builder2.UncheckedAdd(Expression.Assign(left, parameterExpression3));
		return Expression.Block(builder.ToReadOnly(), builder2.ToReadOnly());
	}

	internal virtual LambdaExpression GetConversion()
	{
		return null;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitBinary(this);
	}

	internal static BinaryExpression Create(ExpressionType nodeType, Expression left, Expression right, Type type, MethodInfo method, LambdaExpression conversion)
	{
		if (conversion != null)
		{
			return new CoalesceConversionBinaryExpression(left, right, conversion);
		}
		if (method != null)
		{
			return new MethodBinaryExpression(nodeType, left, right, type, method);
		}
		if (type == typeof(bool))
		{
			return new LogicalBinaryExpression(nodeType, left, right);
		}
		return new SimpleBinaryExpression(nodeType, left, right, type);
	}

	internal Expression ReduceUserdefinedLifted()
	{
		ParameterExpression parameterExpression = Expression.Parameter(Left.Type, "left");
		ParameterExpression parameterExpression2 = Expression.Parameter(Right.Type, "right");
		string name = ((NodeType == ExpressionType.AndAlso) ? "op_False" : "op_True");
		MethodInfo booleanOperator = TypeUtils.GetBooleanOperator(Method.DeclaringType, name);
		return Expression.Block(new TrueReadOnlyCollection<ParameterExpression>(parameterExpression), new TrueReadOnlyCollection<Expression>(Expression.Assign(parameterExpression, Left), Expression.Condition(Expression.Property(parameterExpression, "HasValue"), Expression.Condition(Expression.Call(booleanOperator, Expression.Call(parameterExpression, "GetValueOrDefault", null)), parameterExpression, Expression.Block(new TrueReadOnlyCollection<ParameterExpression>(parameterExpression2), new TrueReadOnlyCollection<Expression>(Expression.Assign(parameterExpression2, Right), Expression.Condition(Expression.Property(parameterExpression2, "HasValue"), Expression.Convert(Expression.Call(Method, Expression.Call(parameterExpression, "GetValueOrDefault", null), Expression.Call(parameterExpression2, "GetValueOrDefault", null)), Type), Expression.Constant(null, Type))))), Expression.Constant(null, Type))));
	}

	internal BinaryExpression()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
