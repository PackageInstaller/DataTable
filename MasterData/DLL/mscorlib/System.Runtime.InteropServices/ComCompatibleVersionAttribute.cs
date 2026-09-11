namespace System.Runtime.InteropServices;

[AttributeUsage(AttributeTargets.Assembly, Inherited = false)]
[ComVisible(true)]
public sealed class ComCompatibleVersionAttribute : Attribute
{
	internal int _major;

	internal int _minor;

	internal int _build;

	internal int _revision;

	public ComCompatibleVersionAttribute(int major, int minor, int build, int revision)
	{
		_major = major;
		_minor = minor;
		_build = build;
		_revision = revision;
	}
}
