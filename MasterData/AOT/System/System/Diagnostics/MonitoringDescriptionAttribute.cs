using System.ComponentModel;

namespace System.Diagnostics;

[AttributeUsage(AttributeTargets.All)]
public class MonitoringDescriptionAttribute : DescriptionAttribute
{
	public override string Description => base.Description;

	public MonitoringDescriptionAttribute(string description)
		: base(description)
	{
	}
}
