using System;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public class LiteralSourceProxy : SourceProxyBase, ISourceProxy, IBindingProxy, IDisposable, IObtainable
{
	public override Type Type => (source != null) ? source.GetType() : typeof(object);

	public LiteralSourceProxy(object source)
		: base(source)
	{
	}

	public virtual object GetValue()
	{
		return source;
	}

	public virtual TValue GetValue<TValue>()
	{
		return (TValue)Convert.ChangeType(source, typeof(TValue));
	}
}
