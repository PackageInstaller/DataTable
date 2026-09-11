using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class ServicePointManagerElement : ConfigurationElement
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			Unity.ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public ServicePointManagerElement()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
