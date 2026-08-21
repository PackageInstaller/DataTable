using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class DefaultProxySection : ConfigurationSection
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			Unity.ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public DefaultProxySection()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}

	protected override void Reset(ConfigurationElement parentElement)
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
