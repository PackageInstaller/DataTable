using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq.Expressions;

namespace GameFramework.Runtime;

internal abstract class ExpressionVisitor
{
	public virtual Expression Visit(Expression expr)
	{
		if (expr == null)
		{
			return null;
		}
		switch (expr.NodeType)
		{
		case ExpressionType.ArrayLength:
		case ExpressionType.Convert:
		case ExpressionType.ConvertChecked:
		case ExpressionType.Negate:
		case ExpressionType.NegateChecked:
		case ExpressionType.Not:
		case ExpressionType.Quote:
		case ExpressionType.TypeAs:
			return VisitUnary((UnaryExpression)expr);
		case ExpressionType.Add:
		case ExpressionType.AddChecked:
		case ExpressionType.And:
		case ExpressionType.AndAlso:
		case ExpressionType.ArrayIndex:
		case ExpressionType.Coalesce:
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
		case ExpressionType.OrElse:
		case ExpressionType.RightShift:
		case ExpressionType.Subtract:
		case ExpressionType.SubtractChecked:
			return VisitBinary((BinaryExpression)expr);
		case ExpressionType.Call:
			return VisitMethodCall((MethodCallExpression)expr);
		case ExpressionType.Invoke:
			return VisitInvocation((InvocationExpression)expr);
		case ExpressionType.MemberAccess:
			return VisitMember((MemberExpression)expr);
		case ExpressionType.TypeIs:
			return VisitTypeBinary((TypeBinaryExpression)expr);
		case ExpressionType.Lambda:
			return VisitLambda((LambdaExpression)expr);
		case ExpressionType.Conditional:
			return VisitConditional((ConditionalExpression)expr);
		case ExpressionType.Constant:
			return VisitConstant((ConstantExpression)expr);
		case ExpressionType.Parameter:
			return VisitParameter((ParameterExpression)expr);
		case ExpressionType.NewArrayInit:
			return VisitNewArrayInit((NewArrayExpression)expr);
		default:
			throw new NotSupportedException("Expressions of type " + expr.Type?.ToString() + " are not supported.");
		}
	}

	protected virtual ReadOnlyCollection<T> VisitExpressionList<T>(ReadOnlyCollection<T> original) where T : Expression
	{
		List<T> list = null;
		int i = 0;
		for (int count = original.Count; i < count; i++)
		{
			Expression expression = Visit(original[i]);
			if (list != null)
			{
				list.Add((T)expression);
			}
			else if (expression != original[i])
			{
				list = new List<T>(count);
				for (int j = 0; j < i; j++)
				{
					list.Add(original[j]);
				}
				list.Add((T)expression);
			}
		}
		if (list != null)
		{
			return list.AsReadOnly();
		}
		return original;
	}

	protected virtual Expression VisitBinary(BinaryExpression expr)
	{
		Expression expression = Visit(expr.Left);
		Expression expression2 = Visit(expr.Right);
		Expression expression3 = Visit(expr.Conversion);
		if (expression != expr.Left || expression2 != expr.Right || expression3 != expr.Conversion)
		{
			if (expr.NodeType == ExpressionType.Coalesce && expr.Conversion != null)
			{
				return Expression.Coalesce(expression, expression2, expression3 as LambdaExpression);
			}
			return Expression.MakeBinary(expr.NodeType, expression, expression2, expr.IsLiftedToNull, expr.Method);
		}
		return expr;
	}

	protected virtual Expression VisitConditional(ConditionalExpression expr)
	{
		Expression expression = Visit(expr.Test);
		Expression expression2 = Visit(expr.IfTrue);
		Expression expression3 = Visit(expr.IfFalse);
		if (expression != expr.Test || expression2 != expr.IfTrue || expression3 != expr.IfFalse)
		{
			return Expression.Condition(expression, expression2, expression3);
		}
		return expr;
	}

	protected virtual Expression VisitLambda(LambdaExpression expr)
	{
		Expression expression = Visit(expr.Body);
		IEnumerable<ParameterExpression> enumerable = VisitExpressionList(expr.Parameters);
		if (expression != expr.Body || enumerable != expr.Parameters)
		{
			return Expression.Lambda(expr.Type, expression, enumerable);
		}
		return expr;
	}

	protected virtual Expression VisitInvocation(InvocationExpression expr)
	{
		IEnumerable<Expression> enumerable = VisitExpressionList(expr.Arguments);
		Expression expression = Visit(expr.Expression);
		if (enumerable != expr.Arguments || expression != expr.Expression)
		{
			return Expression.Invoke(expression, enumerable);
		}
		return expr;
	}

	protected virtual Expression VisitMember(MemberExpression expr)
	{
		Expression expression = Visit(expr.Expression);
		if (expression != expr.Expression)
		{
			return Expression.MakeMemberAccess(expression, expr.Member);
		}
		return expr;
	}

	protected virtual Expression VisitMethodCall(MethodCallExpression expr)
	{
		Expression expression = Visit(expr.Object);
		IEnumerable<Expression> enumerable = VisitExpressionList(expr.Arguments);
		if (expression != expr.Object || enumerable != expr.Arguments)
		{
			return Expression.Call(expression, expr.Method, enumerable);
		}
		return expr;
	}

	protected virtual Expression VisitUnary(UnaryExpression expr)
	{
		Expression expression = Visit(expr.Operand);
		if (expression != expr.Operand)
		{
			return Expression.MakeUnary(expr.NodeType, expression, expr.Type, expr.Method);
		}
		return expr;
	}

	protected virtual Expression VisitTypeBinary(TypeBinaryExpression expr)
	{
		Expression expression = Visit(expr.Expression);
		if (expression != expr.Expression)
		{
			return Expression.TypeIs(expression, expr.TypeOperand);
		}
		return expr;
	}

	protected virtual Expression VisitNewArrayInit(NewArrayExpression expr)
	{
		IEnumerable<Expression> enumerable = VisitExpressionList(expr.Expressions);
		if (enumerable != expr.Expressions)
		{
			return Expression.NewArrayInit(expr.Type, enumerable);
		}
		return expr;
	}

	protected virtual Expression VisitConstant(ConstantExpression expr)
	{
		return expr;
	}

	protected virtual Expression VisitParameter(ParameterExpression expr)
	{
		return expr;
	}
}
