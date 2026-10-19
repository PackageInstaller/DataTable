namespace YooAsset;

public abstract class GameAsyncOperation : AsyncOperationBase
{
	internal override void InternalStart()
	{
		OnStart();
	}

	internal override void InternalUpdate()
	{
		OnUpdate();
	}

	internal override void InternalAbort()
	{
		OnAbort();
	}

	internal override void InternalWaitForAsyncComplete()
	{
		OnWaitForAsyncComplete();
	}

	protected abstract void OnStart();

	protected abstract void OnUpdate();

	protected abstract void OnAbort();

	protected virtual void OnWaitForAsyncComplete()
	{
	}

	protected bool IsBusy()
	{
		return OperationSystem.IsBusy;
	}

	protected void Abort()
	{
		AbortOperation();
	}
}
