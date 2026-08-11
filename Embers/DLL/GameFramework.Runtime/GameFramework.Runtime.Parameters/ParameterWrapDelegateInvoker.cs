using System;
using System.Collections.Generic;
using System.Reflection;

namespace GameFramework.Runtime.Parameters;

public class ParameterWrapDelegateInvoker : ParameterWrapBase, IInvoker
{
	private readonly Delegate handler;

	public ParameterWrapDelegateInvoker(Delegate handler, ICommandParameter commandParameter)
		: base(commandParameter)
	{
		if ((object)handler == null)
		{
			throw new ArgumentNullException("handler");
		}
		this.handler = handler;
		if (!IsValid(handler))
		{
			throw new ArgumentException("Bind method failed.the parameter types do not match.");
		}
	}

	public object Invoke(params object[] args)
	{
		return handler.DynamicInvoke(GetParameterValue());
	}

	protected virtual bool IsValid(Delegate handler)
	{
		MethodInfo method = handler.Method;
		if (!method.ReturnType.Equals(typeof(void)))
		{
			return false;
		}
		List<Type> parameterTypes = method.GetParameterTypes();
		if (parameterTypes.Count != 1)
		{
			return false;
		}
		return parameterTypes[0].IsAssignableFrom(GetParameterValueType());
	}
}
