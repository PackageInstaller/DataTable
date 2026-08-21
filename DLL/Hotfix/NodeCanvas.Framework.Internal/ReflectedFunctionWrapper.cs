using System;
using System.Linq;
using System.Reflection;
using ParadoxNotion;
using ParadoxNotion.Serialization;

namespace NodeCanvas.Framework.Internal;

public abstract class ReflectedFunctionWrapper : ReflectedWrapper
{
	public new static ReflectedFunctionWrapper Create(MethodInfo method, IBlackboard bb)
	{
		if (method == null)
		{
			return null;
		}
		Type type = null;
		ParameterInfo[] parameters = method.GetParameters();
		if (parameters.Length == 0)
		{
			type = typeof(ReflectedFunction<>);
		}
		if (parameters.Length == 1)
		{
			type = typeof(ReflectedFunction<, >);
		}
		if (parameters.Length == 2)
		{
			type = typeof(ReflectedFunction<, , >);
		}
		if (parameters.Length == 3)
		{
			type = typeof(ReflectedFunction<, , , >);
		}
		if (parameters.Length == 4)
		{
			type = typeof(ReflectedFunction<, , , , >);
		}
		if (parameters.Length == 5)
		{
			type = typeof(ReflectedFunction<, , , , , >);
		}
		if (parameters.Length == 6)
		{
			type = typeof(ReflectedFunction<, , , , , , >);
		}
		Type[] array = new Type[parameters.Length + 1];
		array[0] = method.ReturnType;
		for (int i = 0; i < parameters.Length; i++)
		{
			ParameterInfo parameterInfo = parameters[i];
			Type type2 = (parameterInfo.ParameterType.IsByRef ? parameterInfo.ParameterType.GetElementType() : parameterInfo.ParameterType);
			array[i + 1] = type2;
		}
		ReflectedFunctionWrapper reflectedFunctionWrapper = (ReflectedFunctionWrapper)Activator.CreateInstance(type.RTMakeGenericType(array.ToArray()));
		reflectedFunctionWrapper._targetMethod = new SerializedMethodInfo(method);
		BBParameter.SetBBFields(reflectedFunctionWrapper, bb);
		BBParameter[] variables = reflectedFunctionWrapper.GetVariables();
		for (int j = 0; j < parameters.Length; j++)
		{
			ParameterInfo parameterInfo2 = parameters[j];
			if (parameterInfo2.IsOptional)
			{
				variables[j + 1].value = parameterInfo2.DefaultValue;
			}
		}
		return reflectedFunctionWrapper;
	}

	public abstract object Call();
}
