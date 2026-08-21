using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class SocketElement : ConfigurationElement
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			Unity.ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public SocketElement()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
