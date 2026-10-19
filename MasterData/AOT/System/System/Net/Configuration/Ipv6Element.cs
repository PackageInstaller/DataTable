using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class Ipv6Element : ConfigurationElement
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public Ipv6Element()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
