namespace System.Runtime.InteropServices;

[ComVisible(false)]
[AttributeUsage(AttributeTargets.Assembly | AttributeTargets.Method, AllowMultiple = false)]
public sealed class DefaultDllImportSearchPathsAttribute : Attribute
{
	internal DllImportSearchPath _paths;

	public DefaultDllImportSearchPathsAttribute(DllImportSearchPath paths)
	{
		_paths = paths;
	}
}
