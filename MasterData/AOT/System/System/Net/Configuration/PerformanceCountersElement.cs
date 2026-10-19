using System.Configuration;
using Unity;

namespace System.Net.Configuration;

public sealed class PerformanceCountersElement : ConfigurationElement
{
	protected override ConfigurationPropertyCollection Properties
	{
		get
		{
			ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public PerformanceCountersElement()
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
