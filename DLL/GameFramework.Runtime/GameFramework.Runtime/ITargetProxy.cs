using System;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public interface ITargetProxy : IBindingProxy, IDisposable
{
	Type Type { get; }

	TypeCode TypeCode { get; }

	object Target { get; }

	BindingMode DefaultMode { get; }
}
