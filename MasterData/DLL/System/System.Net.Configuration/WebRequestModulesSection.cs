using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class WebRequestModulesSection : ConfigurationSection
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			Unity.ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public WebRequestModulesSection()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
