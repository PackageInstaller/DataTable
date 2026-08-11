using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Reflection;

namespace GameFramework.Runtime;

public class PathExpressionVisitor
{
	private readonly List<Path> list = new List<Path>();

	public List<Path> Paths => list;

	public virtual Expression Visit(Expression expression)
	{
		if (expression == null)
		{
			return null;
		}
		if (expression is BinaryExpression node)
		{
			return VisitBinary(node);
		}
		if (expression is ConditionalExpression node2)
		{
			return VisitConditional(node2);
		}
		if (expression is ConstantExpression node3)
		{
			return VisitConstant(node3);
		}
		if (expression is LambdaExpression node4)
		{
			return VisitLambda(node4);
		}
		if (expression is ListInitExpression node5)
		{
			return VisitListInit(node5);
		}
		if (expression is MemberExpression node6)
		{
			return VisitMember(node6);
		}
		if (expression is MemberInitExpression expr)
		{
			return VisitMemberInit(expr);
		}
		if (expression is MethodCallExpression node7)
		{
			return VisitMethodCall(node7);
		}
		if (expression is NewExpression expr2)
		{
			return VisitNew(expr2);
		}
		if (expression is NewArrayExpression node8)
		{
			return VisitNewArray(node8);
		}
		if (expression is ParameterExpression node9)
		{
			return VisitParameter(node9);
		}
		if (expression is TypeBinaryExpression node10)
		{
			return VisitTypeBinary(node10);
		}
		if (expression is UnaryExpression node11)
		{
			return VisitUnary(node11);
		}
		if (expression is InvocationExpression node12)
		{
			return VisitInvocation(node12);
		}
		throw new NotSupportedException("Expressions of type " + expression.Type?.ToString() + " are not supported.");
	}

	protected virtual void Visit(IList<Expression> nodes)
	{
		if (nodes == null || nodes.Count <= 0)
		{
			return;
		}
		foreach (Expression node in nodes)
		{
			Visit(node);
		}
	}

	protected virtual Expression VisitLambda(LambdaExpression node)
	{
		if (node.Parameters != null)
		{
			Visit(((IEnumerable<ParameterExpression>)node.Parameters).Select((Func<ParameterExpression, Expression>)((ParameterExpression p) => p)).ToList());
		}
		return Visit(node.Body);
	}

	protected virtual Expression VisitBinary(BinaryExpression node)
	{
		if (node.NodeType == ExpressionType.ArrayIndex)
		{
			Visit(ParseMemberPath(node, null, list));
		}
		else
		{
			List<Expression> nodes = new List<Expression> { node.Left, node.Right, node.Conversion };
			Visit(nodes);
		}
		return null;
	}

	protected virtual Expression VisitConditional(ConditionalExpression node)
	{
		List<Expression> nodes = new List<Expression> { node.IfFalse, node.IfTrue, node.Test };
		Visit(nodes);
		return null;
	}

	protected virtual Expression VisitConstant(ConstantExpression node)
	{
		return null;
	}

	protected virtual void VisitElementInit(ElementInit init)
	{
		if (init != null)
		{
			Visit(init.Arguments);
		}
	}

	protected virtual Expression VisitListInit(ListInitExpression node)
	{
		if (node.Initializers != null)
		{
			foreach (ElementInit initializer in node.Initializers)
			{
				VisitElementInit(initializer);
			}
		}
		return Visit(node.NewExpression);
	}

	protected virtual Expression VisitMember(MemberExpression node)
	{
		Visit(ParseMemberPath(node, null, list));
		return null;
	}

	protected virtual Expression VisitInvocation(InvocationExpression node)
	{
		Visit(node.Arguments);
		return Visit(node.Expression);
	}

	protected virtual Expression VisitMemberInit(MemberInitExpression expr)
	{
		return Visit(expr.NewExpression);
	}

	protected virtual MemberListBinding VisitMemberListBinding(MemberListBinding binding)
	{
		return null;
	}

	protected virtual MemberMemberBinding VisitMemberMemberBinding(MemberMemberBinding binding)
	{
		return null;
	}

	protected virtual Expression VisitMethodCall(MethodCallExpression node)
	{
		Visit(ParseMemberPath(node, null, list));
		return null;
	}

	protected virtual Expression VisitNew(NewExpression expr)
	{
		Visit(expr.Arguments);
		return null;
	}

	protected virtual Expression VisitNewArray(NewArrayExpression node)
	{
		Visit(node.Expressions);
		return null;
	}

	protected virtual Expression VisitParameter(ParameterExpression node)
	{
		return null;
	}

	protected virtual Expression VisitTypeBinary(TypeBinaryExpression node)
	{
		return Visit(node.Expression);
	}

	protected virtual Expression VisitUnary(UnaryExpression node)
	{
		return Visit(node.Operand);
	}

	private static Expression ConvertMemberAccessToConstant(Expression argument)
	{
		if (argument is ConstantExpression)
		{
			return argument;
		}
		UnaryExpression body = Expression.Convert(argument, typeof(object));
		Func<object[], object> func = Expression.Lambda<Func<object>>(body, Array.Empty<ParameterExpression>()).DynamicCompile();
		object value = func(new object[0]);
		return Expression.Constant(value);
	}

	private IList<Expression> ParseMemberPath(Expression expression, Path path, IList<Path> list)
	{
		if (expression.NodeType != ExpressionType.MemberAccess && expression.NodeType != ExpressionType.Call && expression.NodeType != ExpressionType.ArrayIndex)
		{
			throw new Exception();
		}
		List<Expression> list2 = new List<Expression>();
		Expression expression2 = expression;
		while (expression2 != null && (expression2 is MemberExpression || expression2 is MethodCallExpression || expression2 is BinaryExpression || expression2 is ParameterExpression || expression2 is ConstantExpression))
		{
			if (expression2 is MemberExpression)
			{
				if (path == null)
				{
					path = new Path();
					list.Add(path);
				}
				MemberExpression memberExpression = (MemberExpression)expression2;
				FieldInfo fieldInfo = memberExpression.Member as FieldInfo;
				if (fieldInfo != null)
				{
					path.Prepend(new MemberNode(fieldInfo));
				}
				PropertyInfo propertyInfo = memberExpression.Member as PropertyInfo;
				if (propertyInfo != null)
				{
					path.Prepend(new MemberNode(propertyInfo));
				}
				expression2 = memberExpression.Expression;
			}
			else if (expression2 is MethodCallExpression)
			{
				MethodCallExpression methodCallExpression = (MethodCallExpression)expression2;
				if (methodCallExpression.Method.Name.Equals("get_Item") && methodCallExpression.Arguments.Count == 1)
				{
					if (path == null)
					{
						path = new Path();
						list.Add(path);
					}
					Expression expression3 = methodCallExpression.Arguments[0];
					if (!(expression3 is ConstantExpression))
					{
						expression3 = ConvertMemberAccessToConstant(expression3);
					}
					object value = (expression3 as ConstantExpression).Value;
					if (value is string)
					{
						path.PrependIndexed((string)value);
					}
					else if (value is int)
					{
						path.PrependIndexed((int)value);
					}
					expression2 = methodCallExpression.Object;
				}
				else
				{
					expression2 = null;
					list2.AddRange(methodCallExpression.Arguments);
					list2.Add(methodCallExpression.Object);
				}
			}
			else if (expression2 is BinaryExpression)
			{
				BinaryExpression binaryExpression = expression2 as BinaryExpression;
				if (binaryExpression.NodeType == ExpressionType.ArrayIndex)
				{
					if (path == null)
					{
						path = new Path();
						list.Add(path);
					}
					Expression left = binaryExpression.Left;
					Expression expression4 = binaryExpression.Right;
					if (!(expression4 is ConstantExpression))
					{
						expression4 = ConvertMemberAccessToConstant(expression4);
					}
					object value2 = (expression4 as ConstantExpression).Value;
					if (value2 is string)
					{
						path.PrependIndexed((string)value2);
					}
					else if (value2 is int)
					{
						path.PrependIndexed((int)value2);
					}
					expression2 = left;
				}
				else
				{
					expression2 = null;
				}
			}
			else if (expression2 is ParameterExpression)
			{
				expression2 = null;
			}
			else if (expression2 is ConstantExpression)
			{
				expression2 = null;
			}
		}
		if (expression2 != null)
		{
			list2.Add(expression2);
		}
		return list2;
	}
}
