using System;

namespace Sirenix.Utilities;

[AttributeUsage(AttributeTargets.Assembly, AllowMultiple = false, Inherited = false)]
public class SirenixBuildVersionAttribute : Attribute
{
	public string Version { get; private set; }

	public SirenixBuildVersionAttribute(string version)
	{
		Version = version;
	}
}
