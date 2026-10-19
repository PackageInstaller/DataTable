namespace YooAsset;

internal sealed class FSClearCacheFilesCompleteOperation : FSClearCacheFilesOperation
{
	private readonly string _error;

	internal FSClearCacheFilesCompleteOperation()
	{
		_error = null;
	}

	internal FSClearCacheFilesCompleteOperation(string error)
	{
		_error = error;
	}

	internal override void InternalStart()
	{
		if (string.IsNullOrEmpty(_error))
		{
			Status = EOperationStatus.Succeed;
			return;
		}
		Status = EOperationStatus.Failed;
		Error = _error;
	}

	internal override void InternalUpdate()
	{
	}
}
