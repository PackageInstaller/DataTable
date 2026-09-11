using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class ProxyElement : ConfigurationElement
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			Unity.ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public ProxyElement()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
