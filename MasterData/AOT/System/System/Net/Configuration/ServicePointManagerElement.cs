using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class ServicePointManagerElement : ConfigurationElement
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public ServicePointManagerElement()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
