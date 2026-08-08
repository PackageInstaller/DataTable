using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class SettingsSection : ConfigurationSection
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			Unity.ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public SettingsSection()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
