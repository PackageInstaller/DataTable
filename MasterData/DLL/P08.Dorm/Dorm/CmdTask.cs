using System;
using System.Collections;
using Dorm.Character;

namespace Dorm;

[Serializable]
public abstract class CmdTask
{
	public readonly int originalPriority;

	public int InterruptLevel { get; protected set; }

	public bool IsStarted { get; private set; }

	public CmdTask(DormEntityManager.EntityCmdPriority priority)
	{
		InterruptLevel = (originalPriority = (int)priority);
	}

	protected virtual void OnStopByExecutor(EntityCmdExecutor executor)
	{
		DormEntityAction.Notify("ON_DORM_CHARACTER_CMD_ABORTED", executor.entity.id);
	}

	protected virtual void OnExecuteFinished(EntityCmdExecutor executor)
	{
	}

	protected abstract IEnumerator StartTask(EntityCmdExecutor executor);

	protected void ResetPriority()
	{
		InterruptLevel = originalPriority;
	}

	public void SetPriotity(DormEntityManager.EntityCmdPriority priority)
	{
		InterruptLevel = (int)priority;
	}

	internal IEnumerator Start(EntityCmdExecutor executor)
	{
		if (!IsStarted)
		{
			IsStarted = true;
			return StartTask(executor);
		}
		return null;
	}

	internal void Abort(EntityCmdExecutor executor)
	{
		if (IsStarted)
		{
			IsStarted = false;
			OnStopByExecutor(executor);
		}
	}

	internal void Finish(EntityCmdExecutor executor)
	{
		if (IsStarted)
		{
			IsStarted = false;
			OnExecuteFinished(executor);
		}
	}
}
