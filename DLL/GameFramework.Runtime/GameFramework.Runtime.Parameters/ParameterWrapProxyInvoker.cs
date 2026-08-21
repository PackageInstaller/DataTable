using System;
using System.Reflection;

namespace GameFramework.Runtime.Parameters;

public class ParameterWrapProxyInvoker : ParameterWrapBase, IInvoker
{
	private readonly IProxyInvoker invoker;

	public ParameterWrapProxyInvoker(IProxyInvoker invoker, ICommandParameter commandParameter)
		: base(commandParameter)
	{
		if (invoker == null)
		{
			throw new ArgumentNullException("invoker");
		}
		this.invoker = invoker;
		if (!IsValid(invoker))
		{
			throw new ArgumentException("Bind method failed.the parameter types do not match.");
		}
	}

	public object Invoke(params object[] args)
	{
		return invoker.Invoke(GetParameterValue());
	}

	protected bool IsValid(IProxyInvoker invoker)
	{
		IProxyMethodInfo proxyMethodInfo = invoker.ProxyMethodInfo;
		if (!proxyMethodInfo.ReturnType.Equals(typeof(void)))
		{
			return false;
		}
		ParameterInfo[] parameters = proxyMethodInfo.Parameters;
		if (parameters == null || parameters.Length != 1)
		{
			return false;
		}
		return parameters[0].ParameterType.IsAssignableFrom(GetParameterValueType());
	}
}
