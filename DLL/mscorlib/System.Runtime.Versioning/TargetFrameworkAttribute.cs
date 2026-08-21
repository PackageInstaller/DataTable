namespace System.Runtime.Versioning;

[AttributeUsage(AttributeTargets.Assembly, AllowMultiple = false, Inherited = false)]
public sealed class TargetFrameworkAttribute : Attribute
{
	private string _frameworkName;

	private string _frameworkDisplayName;

	public string FrameworkDisplayName
	{
		set
		{
			_frameworkDisplayName = value;
		}
	}

	public TargetFrameworkAttribute(string frameworkName)
	{
		if (frameworkName == null)
		{
			throw new ArgumentNullException("frameworkName");
		}
		_frameworkName = frameworkName;
	}
}
