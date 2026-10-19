using System;

namespace Sirenix.Utilities;

[AttributeUsage(AttributeTargets.Assembly, AllowMultiple = false, Inherited = false)]
public class SirenixBuildNameAttribute : Attribute
{
	public string BuildName { get; private set; }

	public SirenixBuildNameAttribute(string buildName)
	{
		BuildName = buildName;
	}
}
