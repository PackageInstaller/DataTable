using System;

namespace Sirenix.Serialization;

public class WeakDelegateFormatter : DelegateFormatter<Delegate>
{
	public WeakDelegateFormatter(Type delegateType)
		: base(delegateType)
	{
	}
}
