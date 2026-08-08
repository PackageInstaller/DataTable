using System.Runtime.InteropServices;

namespace System.Runtime.Serialization;

[ComVisible(true)]
[AttributeUsage(AttributeTargets.Field, Inherited = false)]
public sealed class OptionalFieldAttribute : Attribute
{
	private int versionAdded = 1;

	public int VersionAdded
	{
		set
		{
			if (value < 1)
			{
				throw new ArgumentException(Environment.GetResourceString("Version value must be positive."));
			}
			versionAdded = value;
		}
	}
}
