using System.ComponentModel;

namespace System.IO;

[AttributeUsage(AttributeTargets.All)]
public class IODescriptionAttribute : DescriptionAttribute
{
	public override string Description => base.DescriptionValue;

	public IODescriptionAttribute(string description)
		: base(description)
	{
	}
}
