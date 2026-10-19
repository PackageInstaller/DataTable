namespace System.Runtime.InteropServices;

[AttributeUsage(AttributeTargets.Assembly | AttributeTargets.Method, AllowMultiple = false)]
[ComVisible(false)]
public sealed class DefaultDllImportSearchPathsAttribute : Attribute
{
	internal DllImportSearchPath _paths;

	public DefaultDllImportSearchPathsAttribute(DllImportSearchPath paths)
	{
		_paths = paths;
	}
}
