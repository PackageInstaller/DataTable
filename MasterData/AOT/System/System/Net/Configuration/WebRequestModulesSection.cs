using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class WebRequestModulesSection : ConfigurationSection
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public WebRequestModulesSection()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
