using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class ProxyElement : ConfigurationElement
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public ProxyElement()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
