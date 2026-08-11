using System;
using System.Reflection;

namespace GameFramework.Runtime;

public interface IProxyMethodInfo : IProxyMemberInfo
{
	Type ReturnType { get; }

	ParameterInfo[] Parameters { get; }

	ParameterInfo ReturnParameter { get; }

	object Invoke(object target, params object[] args);
}
