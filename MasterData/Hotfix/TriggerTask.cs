using UnityEngine;

public class TriggerTask : LogicEntity
{
	public enum RunType
	{
		[InspectorName("顺序执行")]
		sequence,
		[InspectorName("并行执行")]
		parallel
	}

	public int templeteId;

	public RunType _runType;

	[Space]
	public TaskCellBase[] taskCells;

	[HideInInspector]
	public GameObject triggerOwner;

	private TriggerCom _triggeCom;

	private int _triggerCount;

	private int _taskCount;

	public TriggerCom triggeCom => _triggeCom;

	protected override void OnInit()
	{
		_taskCount = taskCells.Length;
		if (_taskCount < 1)
		{
			taskCells = GetComponents<TaskCellBase>();
			_taskCount = taskCells.Length;
		}
		if (_taskCount < 1)
		{
			return;
		}
		_taskCount = 0;
		for (int i = 0; i < taskCells.Length; i++)
		{
			if (taskCells[i] != null)
			{
				AddLogicComponent(taskCells[i]);
				_taskCount++;
			}
		}
	}

	protected override void OnActive()
	{
		_triggerCount = 0;
		EnableLogicUpdate();
	}

	protected override void OnLogicUpdate()
	{
	}

	protected override void OnDeactive()
	{
	}

	public void OnTriggerTask(GameObject owner, TriggerCom tri)
	{
		if (!ActiveSelf)
		{
			return;
		}
		if (tri != null)
		{
			_triggeCom = tri;
		}
		if (TaskRuning())
		{
			return;
		}
		_triggerCount = 0;
		if (_triggerCount >= _taskCount)
		{
			return;
		}
		if (owner != null)
		{
			triggerOwner = owner;
		}
		if (_runType == RunType.sequence)
		{
			for (int i = _triggerCount; i < _taskCount; i++)
			{
				_triggerCount++;
				if (taskCells[i].ToExecute())
				{
					break;
				}
			}
		}
		else
		{
			_triggerCount = _taskCount;
			for (int j = 0; j < _taskCount; j++)
			{
				taskCells[j].ToExecute();
			}
		}
	}

	public void OnTriggerNextTask()
	{
		if (!ActiveSelf || _triggerCount >= _taskCount || _runType != RunType.sequence)
		{
			return;
		}
		for (int i = _triggerCount; i < _taskCount; i++)
		{
			_triggerCount++;
			if (taskCells[i].ToExecute())
			{
				break;
			}
		}
	}

	private bool TaskRuning()
	{
		if (_taskCount < 1)
		{
			return false;
		}
		if (_triggerCount >= 1 && _triggerCount < _taskCount)
		{
			return true;
		}
		if (_triggerCount == _taskCount)
		{
			return taskCells[_triggerCount - 1].CurrentState != TaskCellBase.TaskStatus.finished;
		}
		return false;
	}
}
