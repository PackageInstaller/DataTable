using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class WebProxyScriptElement : ConfigurationElement
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			Unity.ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public WebProxyScriptElement()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
