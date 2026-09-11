using System.Diagnostics;
using System.Dynamic.Utils;
using System.Reflection;
using System.Runtime.CompilerServices;
using Unity;

namespace System.Linq.Expressions;

[DebuggerTypeProxy(typeof(UnaryExpressionProxy))]
public sealed class UnaryExpression : Expression
{
	public sealed override Type Type { get; }

	public sealed override ExpressionType NodeType { get; }

	public Expression Operand { get; }

	public MethodInfo Method { get; }

	public bool IsLifted
	{
		get
		{
			if (NodeType == ExpressionType.TypeAs || NodeType == ExpressionType.Quote || NodeType == ExpressionType.Throw)
			{
				return false;
			}
			bool flag = Operand.Type.IsNullableType();
			bool flag2 = Type.IsNullableType();
			if (Method != null)
			{
				if (!flag || TypeUtils.AreEquivalent(Method.GetParametersCached()[0].ParameterType, Operand.Type))
				{
					if (flag2)
					{
						return !TypeUtils.AreEquivalent(Method.ReturnType, Type);
					}
					return false;
				}
				return true;
			}
			return flag | flag2;
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

	public override bool CanReduce
	{
		get
		{
			ExpressionType nodeType = NodeType;
			if ((uint)(nodeType - 77) <= 3u)
			{
				return true;
			}
			return false;
		}
	}

	private bool IsPrefix
	{
		get
		{
			if (NodeType != ExpressionType.PreIncrementAssign)
			{
				return NodeType == ExpressionType.PreDecrementAssign;
			}
			return true;
		}
	}

	internal UnaryExpression(ExpressionType nodeType, Expression expression, Type type, MethodInfo method)
	{
		Operand = expression;
		Method = method;
		NodeType = nodeType;
		Type = type;
	}

	protected internal override Expression Accept(ExpressionVisitor visitor)
	{
		return visitor.VisitUnary(this);
	}

	public override Expression Reduce()
	{
		if (CanReduce)
		{
			return Operand.NodeType switch
			{
				ExpressionType.Index => ReduceIndex(), 
				ExpressionType.MemberAccess => ReduceMember(), 
				_ => ReduceVariable(), 
			};
		}
		return this;
	}

	private UnaryExpression FunctionalOp(Expression operand)
	{
		ExpressionType nodeType = ((NodeType != ExpressionType.PreIncrementAssign && NodeType != ExpressionType.PostIncrementAssign) ? ExpressionType.Decrement : ExpressionType.Increment);
		return new UnaryExpression(nodeType, operand, operand.Type, Method);
	}

	private Expression ReduceVariable()
	{
		if (IsPrefix)
		{
			return Expression.Assign(Operand, FunctionalOp(Operand));
		}
		ParameterExpression parameterExpression = Expression.Parameter(Operand.Type, null);
		return Expression.Block(new TrueReadOnlyCollection<ParameterExpression>(parameterExpression), new TrueReadOnlyCollection<Expression>(Expression.Assign(parameterExpression, Operand), Expression.Assign(Operand, FunctionalOp(parameterExpression)), parameterExpression));
	}

	private Expression ReduceMember()
	{
		MemberExpression memberExpression = (MemberExpression)Operand;
		if (memberExpression.Expression == null)
		{
			return ReduceVariable();
		}
		ParameterExpression parameterExpression = Expression.Parameter(memberExpression.Expression.Type, null);
		BinaryExpression binaryExpression = Expression.Assign(parameterExpression, memberExpression.Expression);
		memberExpression = Expression.MakeMemberAccess(parameterExpression, memberExpression.Member);
		if (IsPrefix)
		{
			return Expression.Block(new TrueReadOnlyCollection<ParameterExpression>(parameterExpression), new TrueReadOnlyCollection<Expression>(binaryExpression, Expression.Assign(memberExpression, FunctionalOp(memberExpression))));
		}
		ParameterExpression parameterExpression2 = Expression.Parameter(memberExpression.Type, null);
		return Expression.Block(new TrueReadOnlyCollection<ParameterExpression>(parameterExpression, parameterExpression2), new TrueReadOnlyCollection<Expression>(binaryExpression, Expression.Assign(parameterExpression2, memberExpression), Expression.Assign(memberExpression, FunctionalOp(parameterExpression2)), parameterExpression2));
	}

	private Expression ReduceIndex()
	{
		bool isPrefix = IsPrefix;
		IndexExpression indexExpression = (IndexExpression)Operand;
		int argumentCount = indexExpression.ArgumentCount;
		Expression[] array = new Expression[argumentCount + (isPrefix ? 2 : 4)];
		ParameterExpression[] array2 = new ParameterExpression[argumentCount + (isPrefix ? 1 : 2)];
		ParameterExpression[] array3 = new ParameterExpression[argumentCount];
		int num = 0;
		array2[num] = Expression.Parameter(indexExpression.Object.Type, null);
		array[num] = Expression.Assign(array2[num], indexExpression.Object);
		for (num++; num <= argumentCount; num++)
		{
			Expression argument = indexExpression.GetArgument(num - 1);
			array3[num - 1] = (array2[num] = Expression.Parameter(argument.Type, null));
			array[num] = Expression.Assign(array2[num], argument);
		}
		ParameterExpression instance = array2[0];
		PropertyInfo indexer = indexExpression.Indexer;
		Expression[] list = array3;
		indexExpression = Expression.MakeIndex(instance, indexer, new TrueReadOnlyCollection<Expression>(list));
		if (!isPrefix)
		{
			ParameterExpression parameterExpression = (array2[num] = Expression.Parameter(indexExpression.Type, null));
			array[num] = Expression.Assign(array2[num], indexExpression);
			num++;
			array[num++] = Expression.Assign(indexExpression, FunctionalOp(parameterExpression));
			array[num++] = parameterExpression;
		}
		else
		{
			array[num++] = Expression.Assign(indexExpression, FunctionalOp(indexExpression));
		}
		return Expression.Block(new TrueReadOnlyCollection<ParameterExpression>(array2), new TrueReadOnlyCollection<Expression>(array));
	}

	public UnaryExpression Update(Expression operand)
	{
		if (operand == Operand)
		{
			return this;
		}
		return Expression.MakeUnary(NodeType, operand, Type, Method);
	}

	internal UnaryExpression()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
