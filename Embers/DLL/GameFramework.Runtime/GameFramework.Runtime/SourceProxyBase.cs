using System;
using GameFramework.Runtime.Proxy;

namespace GameFramework.Runtime;

public abstract class SourceProxyBase : BindingProxyBase, ISourceProxy, IBindingProxy, IDisposable
{
	protected TypeCode typeCode = TypeCode.Empty;

	protected readonly object source;

	public abstract Type Type { get; }

	public virtual TypeCode TypeCode
	{
		get
		{
			if (typeCode == TypeCode.Empty)
			{
				typeCode = Type.GetTypeCode(Type);
			}
			return typeCode;
		}
	}

	public virtual object Source => source;

	public SourceProxyBase(object source)
	{
		this.source = source;
	}
}
