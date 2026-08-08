using System;
using System.Linq.Expressions;
using System.Reflection;

namespace MessagePack.Internal;

internal static class ExpressionUtility
{
	private static MethodInfo GetMethodInfoCore(LambdaExpression expression)
	{
		if (expression == null)
		{
			throw new ArgumentNullException("expression");
		}
		return (expression.Body as MethodCallExpression).Method;
	}

	public static MethodInfo GetMethodInfo<T>(Expression<Func<T>> expression)
	{
		return GetMethodInfoCore(expression);
	}

	public static MethodInfo GetMethodInfo(Expression<Action> expression)
	{
		return GetMethodInfoCore(expression);
	}

	public static MethodInfo GetMethodInfo<T, TR>(Expression<Func<T, TR>> expression)
	{
		return GetMethodInfoCore(expression);
	}

	public static MethodInfo GetMethodInfo<T>(Expression<Action<T>> expression)
	{
		return GetMethodInfoCore(expression);
	}

	public static MethodInfo GetMethodInfo<T, TArg1, TR>(Expression<Func<T, TArg1, TR>> expression)
	{
		return GetMethodInfoCore(expression);
	}

	private static MemberInfo GetMemberInfoCore<T>(Expression<T> source)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		return (source.Body as MemberExpression).Member;
	}

	public static PropertyInfo GetPropertyInfo<T, TR>(Expression<Func<T, TR>> expression)
	{
		return GetMemberInfoCore(expression) as PropertyInfo;
	}

	public static FieldInfo GetFieldInfo<T, TR>(Expression<Func<T, TR>> expression)
	{
		return GetMemberInfoCore(expression) as FieldInfo;
	}
}
