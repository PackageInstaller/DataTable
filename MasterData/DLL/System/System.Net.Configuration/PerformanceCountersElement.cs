using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class PerformanceCountersElement : ConfigurationElement
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			Unity.ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public PerformanceCountersElement()
	{
		Unity.ThrowStub.ThrowNotSupportedException();
	}
}
