using Cysharp.Threading.Tasks;

namespace ACT.LogicQueue;

public struct LogicActionResult(LogicAction action, UniTask task)
{
	private int m_Id = action.Id;

	private LogicAction m_Action = action;

	private UniTask m_Task = task;

	public UniTask Task => m_Task;

	public bool IsValid
	{
		get
		{
			if (m_Action != null)
			{
				return m_Id == m_Action.Id;
			}
			return false;
		}
	}

	public LogicActionState State
	{
		get
		{
			if (!IsValid)
			{
				return LogicActionState.None;
			}
			return m_Action.State;
		}
	}

	public bool IsDone
	{
		get
		{
			if (IsValid)
			{
				return m_Action.IsDone;
			}
			return false;
		}
	}
}
