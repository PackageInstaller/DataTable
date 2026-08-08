using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class Ipv6Element : ConfigurationElement
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			Unity.ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public Ipv6Element()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
