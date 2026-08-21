using System;
using System.Reflection;

namespace GameFramework.Runtime;

public class ProxyMethodInfo : IProxyMethodInfo, IProxyMemberInfo
{
	protected bool isValueType = false;

	protected MethodInfo methodInfo;

	public virtual Type DeclaringType => methodInfo.DeclaringType;

	public virtual string Name => methodInfo.Name;

	public virtual bool IsStatic => methodInfo.IsStatic;

	public virtual Type ReturnType => methodInfo.ReturnType;

	public virtual ParameterInfo[] Parameters => methodInfo.GetParameters();

	public virtual ParameterInfo ReturnParameter => methodInfo.ReturnParameter;

	public ProxyMethodInfo(MethodInfo methodInfo)
	{
		if (methodInfo == null)
		{
			throw new ArgumentNullException("methodInfo");
		}
		this.methodInfo = methodInfo;
		isValueType = methodInfo.DeclaringType.IsValueType;
	}

	public virtual object Invoke(object target, params object[] args)
	{
		return methodInfo.Invoke(target, args);
	}
}
