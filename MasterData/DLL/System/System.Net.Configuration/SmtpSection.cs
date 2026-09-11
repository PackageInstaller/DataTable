using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class SmtpSection : ConfigurationSection
{
	public string From
	{
		get
		{
			Unity.ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			Unity.ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public SmtpSection()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
