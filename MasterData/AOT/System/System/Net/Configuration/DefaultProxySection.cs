using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class DefaultProxySection : ConfigurationSection
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public DefaultProxySection()
	{
		ThrowStub.ThrowNotSupportedException();
	}

	protected override void Reset(ConfigurationElement parentElement)
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
