using System.Threading;

namespace YooAsset;

internal sealed class VerifyTempFileOperation : AsyncOperationBase
{
	private enum ESteps
	{
		None,
		VerifyFile,
		Waiting,
		Done
	}

	private readonly TempFileElement _element;

	private ESteps _steps;

	public EFileVerifyResult VerifyResult { get; private set; }

	internal VerifyTempFileOperation(TempFileElement element)
	{
		_element = element;
	}

	internal override void InternalStart()
	{
		_steps = ESteps.VerifyFile;
	}

	internal override void InternalUpdate()
	{
		if (_steps == ESteps.None || _steps == ESteps.Done)
		{
			return;
		}
		if (_steps == ESteps.VerifyFile && ThreadPool.QueueUserWorkItem(VerifyInThread, _element))
		{
			_steps = ESteps.Waiting;
		}
		if (_steps != ESteps.Waiting)
		{
			return;
		}
		int result = _element.Result;
		if (result != 0)
		{
			VerifyResult = (EFileVerifyResult)result;
			if (VerifyResult == EFileVerifyResult.Succeed)
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Succeed;
			}
			else
			{
				_steps = ESteps.Done;
				Status = EOperationStatus.Failed;
				Error = $"Failed to verify file : {_element.TempFilePath} ! ErrorCode : {VerifyResult}";
			}
		}
	}

	internal override void InternalWaitForAsyncComplete()
	{
		do
		{
			InternalUpdate();
		}
		while (!IsDone);
	}

	private void VerifyInThread(object obj)
	{
		TempFileElement tempFileElement = (TempFileElement)obj;
		int result = (int)FileVerifyHelper.FileVerify(tempFileElement.TempFilePath, tempFileElement.TempFileSize, tempFileElement.TempFileCRC, EFileVerifyLevel.High);
		tempFileElement.Result = result;
	}
}
