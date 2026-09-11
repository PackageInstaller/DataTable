using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class ConnectionManagementSection : ConfigurationSection
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			Unity.ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public ConnectionManagementSection()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
