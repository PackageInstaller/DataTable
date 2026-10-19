using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class HttpWebRequestElement : ConfigurationElement
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public HttpWebRequestElement()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
