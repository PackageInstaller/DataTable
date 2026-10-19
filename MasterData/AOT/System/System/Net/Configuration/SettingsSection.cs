using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class SettingsSection : ConfigurationSection
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public SettingsSection()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
