using System;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public interface ISourceProxy : IBindingProxy, IDisposable
{
	Type Type { get; }

	TypeCode TypeCode { get; }

	object Source { get; }
}
