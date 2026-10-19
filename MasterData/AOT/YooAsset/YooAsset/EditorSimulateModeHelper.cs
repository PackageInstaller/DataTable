namespace YooAsset;

public class EditorSimulateModeHelper
{
	public static PackageInvokeBuildResult SimulateBuild(string packageName)
	{
		return PakcageInvokeBuilder.InvokeBuilder(new PackageInvokeBuildParam(packageName)
		{
			BuildPipelineName = "EditorSimulateBuildPipeline",
			InvokeAssmeblyName = "YooAsset.Editor",
			InvokeClassFullName = "YooAsset.Editor.AssetBundleSimulateBuilder",
			InvokeMethodName = "SimulateBuild"
		});
	}
}
