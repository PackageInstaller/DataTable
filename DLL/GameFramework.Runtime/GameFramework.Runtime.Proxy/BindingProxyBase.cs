using System;

namespace GameFramework.Runtime.Proxy;

public abstract class BindingProxyBase : IBindingProxy, IDisposable
{
	protected virtual void Dispose(bool disposing)
	{
	}

	~BindingProxyBase()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}
}
