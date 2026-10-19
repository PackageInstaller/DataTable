using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class NetSectionGroup : ConfigurationSectionGroup
{
	public NetSectionGroup()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
