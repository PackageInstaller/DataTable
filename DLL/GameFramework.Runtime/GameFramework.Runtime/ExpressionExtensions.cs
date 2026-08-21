using System;
using System.Linq.Expressions;
using System.Reflection;

namespace GameFramework.Runtime;

public static class ExpressionExtensions
{
	public static Func<object[], object> DynamicCompile(this LambdaExpression expr)
	{
		return (Func<object[], object>)((ConstantExpression)new EvaluatingVisitor().Visit(expr)).Value;
	}

	public static Func<object[], object> DynamicCompile<T>(this Expression<T> expr)
	{
		return ((LambdaExpression)expr).DynamicCompile();
	}

	internal static object Get(this MemberInfo info, object root)
	{
		FieldInfo fieldInfo = info as FieldInfo;
		if (fieldInfo != null)
		{
			IProxyFieldInfo proxyFieldInfo = fieldInfo.AsProxy();
			if (proxyFieldInfo != null)
			{
				return proxyFieldInfo.GetValue(root);
			}
			return fieldInfo.GetValue(root);
		}
		PropertyInfo propertyInfo = info as PropertyInfo;
		if (propertyInfo != null)
		{
			IProxyPropertyInfo proxyPropertyInfo = propertyInfo.AsProxy();
			if (proxyPropertyInfo != null)
			{
				return proxyPropertyInfo.GetValue(root);
			}
			MethodInfo getMethod = propertyInfo.GetGetMethod();
			if (getMethod != null)
			{
				return getMethod.Invoke(root, null);
			}
		}
		throw new NotSupportedException("Bad MemberInfo type.");
	}

	internal static void Set(this MemberInfo info, object root, object value)
	{
		FieldInfo fieldInfo = info as FieldInfo;
		if (fieldInfo != null)
		{
			IProxyFieldInfo proxyFieldInfo = fieldInfo.AsProxy();
			if (proxyFieldInfo != null)
			{
				proxyFieldInfo.SetValue(root, value);
			}
			else
			{
				fieldInfo.SetValue(root, value);
			}
			return;
		}
		PropertyInfo propertyInfo = info as PropertyInfo;
		if (propertyInfo != null)
		{
			IProxyPropertyInfo proxyPropertyInfo = propertyInfo.AsProxy();
			if (proxyPropertyInfo != null)
			{
				proxyPropertyInfo.SetValue(root, value);
				return;
			}
			MethodInfo setMethod = propertyInfo.GetSetMethod();
			if (setMethod != null)
			{
				setMethod.Invoke(root, new object[1] { value });
			}
			return;
		}
		throw new NotSupportedException("Bad MemberInfo type.");
	}

	internal static MethodInfo GetMethod(this Type type, string name, int genericParamLength)
	{
		MethodInfo[] methods = type.GetMethods();
		foreach (MethodInfo methodInfo in methods)
		{
			if (methodInfo.Name.Equals(name))
			{
				Type[] genericArguments = methodInfo.GetGenericArguments();
				if (genericArguments.Length == genericParamLength)
				{
					return methodInfo;
				}
			}
		}
		return null;
	}
}
