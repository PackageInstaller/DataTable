namespace YooAsset;

internal class DownloadFileWrapper : FSDownloadFileOperation
{
	private enum ESteps
	{
		None,
		Download,
		Done
	}

	private readonly FSDownloadFileOperation _downloadFileOp;

	private ESteps _steps;

	internal DownloadFileWrapper(FSDownloadFileOperation downloadFileOp)
		: base(downloadFileOp.Bundle)
	{
		_downloadFileOp = downloadFileOp;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.Download;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done || _steps != ESteps.Download)
		{
			return;
		}
		if (IsWaitForAsyncComplete)
		{
			_downloadFileOp.WaitForAsyncComplete();
		}
		if (_downloadFileOp.Status != EOperationStatus.None)
		{
			_downloadFileOp.UpdateOperation();
			Progress = _downloadFileOp.Progress;
			DownloadedBytes = _downloadFileOp.DownloadedBytes;
			DownloadProgress = _downloadFileOp.DownloadProgress;
			if (_downloadFileOp.IsDone)
			{
				_steps = ESteps.Done;
				Status = _downloadFileOp.Status;
				Error = _downloadFileOp.Error;
				HttpCode = _downloadFileOp.HttpCode;
			}
		}
	}

	internal override void InternalWaitForAsyncComplete()
	{
		while (!ExecuteWhileDone())
		{
		}
		_steps = ESteps.Done;
	}

	public override void Release()
	{
		_downloadFileOp.Release();
	}

	public override void Reference()
	{
		_downloadFileOp.Reference();
	}
}
