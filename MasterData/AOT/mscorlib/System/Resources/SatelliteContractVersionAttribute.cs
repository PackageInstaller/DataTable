using System.Runtime.CompilerServices;

namespace System.Resources;

[AttributeUsage(AttributeTargets.Assembly, AllowMultiple = false)]
public sealed class SatelliteContractVersionAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string Version__BackingField;

	public SatelliteContractVersionAttribute(string version)
	{
		if (version == null)
		{
			throw new ArgumentNullException("version");
		}
		Version__BackingField = version;
	}
}
