using System.Configuration;
using System.Reflection;
using Unity;

namespace System.Net.Configuration;

[DefaultMember("Item")]
[ConfigurationCollection(typeof(WebRequestModuleElement))]
public sealed class WebRequestModuleElementCollection : ConfigurationElementCollection
{
	public WebRequestModuleElementCollection()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
