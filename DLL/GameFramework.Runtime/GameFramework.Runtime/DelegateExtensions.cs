using System;
using System.Reflection;

namespace GameFramework.Runtime;

internal static class DelegateExtensions
{
	internal static Type ReturnType(this Delegate del)
	{
		MethodInfo method = del.GetType().GetMethod("Invoke");
		if (method == null)
		{
			return null;
		}
		return method.ReturnType;
	}

	internal static Type ParameterType(this Delegate del)
	{
		MethodInfo method = del.GetType().GetMethod("Invoke");
		if (method == null)
		{
			return null;
		}
		ParameterInfo[] parameters = method.GetParameters();
		if (parameters == null || parameters.Length == 0)
		{
			return null;
		}
		return parameters[0].ParameterType;
	}
}
