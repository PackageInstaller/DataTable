using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class WebProxyScriptElement : ConfigurationElement
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public WebProxyScriptElement()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
