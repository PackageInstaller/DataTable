using UnityEngine.ResourceManagement.AsyncOperations;

namespace UnityEngine.Localization;

internal abstract class WaitForCurrentOperationAsyncOperationBase<TObject> : AsyncOperationBase<TObject>
{
	private bool m_Waiting;

	protected AsyncOperationHandle CurrentOperation { get; set; }

	public AsyncOperationHandle Dependency { get; set; }

	protected override bool InvokeWaitForCompletion()
	{
		if (!IsRunning || m_Waiting)
		{
			return true;
		}
		try
		{
			m_Waiting = true;
			if (!HasExecuted && Dependency.IsValid())
			{
				Dependency.WaitForCompletion();
				return false;
			}
			if (!CurrentOperation.IsValid())
			{
				Complete(default, success: false, "Expected to have a current operation to wait on. Can not complete.");
				return true;
			}
			CurrentOperation.WaitForCompletion();
			return false;
		}
		finally
		{
			m_Waiting = false;
		}
	}

	protected override void Destroy()
	{
		base.Destroy();
		Dependency = default;
		CurrentOperation = default;
		HasExecuted = false;
	}
}
