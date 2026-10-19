namespace YooAsset;

internal sealed class FSLoadBundleCompleteOperation : FSLoadBundleOperation
{
	private readonly string _error;

	internal FSLoadBundleCompleteOperation(string error)
	{
		_error = error;
	}

	internal override void InternalStart()
	{
		Status = EOperationStatus.Failed;
		Error = _error;
	}

	internal override void InternalUpdate()
	{
	}
}
