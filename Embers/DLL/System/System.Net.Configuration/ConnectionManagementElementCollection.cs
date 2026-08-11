using System.Configuration;
using System.Reflection;
using Unity;

namespace System.Net.Configuration;

[DefaultMember("Item")]
[ConfigurationCollection(typeof(ConnectionManagementElement))]
public sealed class ConnectionManagementElementCollection : ConfigurationElementCollection
{
	public ConnectionManagementElementCollection()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
