namespace YooAsset;

internal class RawBundleLoadSceneOperation : FSLoadSceneOperation
{
	internal override void InternalStart()
	{
		Error = "RawBundleLoadSceneOperation not support load scene !";
		Status = EOperationStatus.Failed;
	}

	internal override void InternalUpdate()
	{
	}

	public override void UnSuspendLoad()
	{
	}
}
