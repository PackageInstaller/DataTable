namespace YooAsset;

public class PackageInvokeBuildParam
{
	public readonly string PackageName;

	public string BuildPipelineName;

	public object BuildUserData;

	public string InvokeAssmeblyName;

	public string InvokeClassFullName;

	public string InvokeMethodName;

	public PackageInvokeBuildParam(string packageName)
	{
		PackageName = packageName;
	}
}
