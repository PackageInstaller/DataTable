using System.Configuration;
using System.Reflection;
using Unity;

namespace System.Net.Configuration;

[DefaultMember("Item")]
[ConfigurationCollection(typeof(BypassElement))]
public sealed class BypassElementCollection : ConfigurationElementCollection
{
	public BypassElementCollection()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
