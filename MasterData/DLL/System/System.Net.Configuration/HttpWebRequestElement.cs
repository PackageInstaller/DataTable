using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class HttpWebRequestElement : ConfigurationElement
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			Unity.ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public HttpWebRequestElement()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
