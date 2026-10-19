using System;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Text;

namespace Sirenix.Serialization.Utilities;

internal static class MethodInfoExtensions
{
	public static string GetFullName(this MethodBase method, string extensionMethodPrefix)
	{
		StringBuilder stringBuilder = new StringBuilder();
		if (method.IsExtensionMethod())
		{
			stringBuilder.Append(extensionMethodPrefix);
		}
		stringBuilder.Append(method.Name);
		stringBuilder.Append("(");
		stringBuilder.Append(method.GetParamsNames());
		stringBuilder.Append(")");
		return stringBuilder.ToString();
	}

	public static string GetParamsNames(this MethodBase method)
	{
		ParameterInfo[] array = (method.IsExtensionMethod() ? method.GetParameters().Skip(1).ToArray() : method.GetParameters());
		StringBuilder stringBuilder = new StringBuilder();
		int i = 0;
		for (int num = array.Length; i < num; i++)
		{
			ParameterInfo parameterInfo = array[i];
			string niceName = parameterInfo.ParameterType.GetNiceName();
			stringBuilder.Append(niceName);
			stringBuilder.Append(" ");
			stringBuilder.Append(parameterInfo.Name);
			if (i < num - 1)
			{
				stringBuilder.Append(", ");
			}
		}
		return stringBuilder.ToString();
	}

	public static string GetFullName(this MethodBase method)
	{
		return method.GetFullName("[ext] ");
	}

	public static bool IsExtensionMethod(this MethodBase method)
	{
		Type declaringType = method.DeclaringType;
		if (declaringType.IsSealed && !declaringType.IsGenericType && !declaringType.IsNested)
		{
			return method.IsDefined(typeof(ExtensionAttribute), inherit: false);
		}
		return false;
	}

	public static bool IsAliasMethod(this MethodInfo methodInfo)
	{
		return methodInfo is MemberAliasMethodInfo;
	}

	public static MethodInfo DeAliasMethod(this MethodInfo methodInfo, bool throwOnNotAliased = false)
	{
		MemberAliasMethodInfo memberAliasMethodInfo = methodInfo as MemberAliasMethodInfo;
		if (memberAliasMethodInfo != null)
		{
			while (memberAliasMethodInfo.AliasedMethod is MemberAliasMethodInfo)
			{
				memberAliasMethodInfo = memberAliasMethodInfo.AliasedMethod as MemberAliasMethodInfo;
			}
			return memberAliasMethodInfo.AliasedMethod;
		}
		if (throwOnNotAliased)
		{
			throw new ArgumentException("The method " + methodInfo.GetNiceName() + " was not aliased.");
		}
		return methodInfo;
	}
}
