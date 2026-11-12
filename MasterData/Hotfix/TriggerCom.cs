#define LOG_DEBUG
using TrueSync;
using UnityEngine;

public class TriggerCom : LogicEntity
{
	public string[] GroupTitles;

	public bool defaultActive = true;

	public TriggerManager.triggerState triggerAfterState;

	public float activeTime;

	private FP activeTimeFP;

	public bool conditionRsAnd;

	public TriggerConditionBase[] triggerConditions;

	private TriggerManager.triggerState state;

	private int triggerCount;

	private FP waitTime;

	[HideInInspector]
	public bool isInterActiveTrigger;

	[Space]
	public TriggerTask triggerTask;

	public int x { get; protected set; }

	public int y { get; protected set; }

	public string triggerName => gameObject.name;

	protected override void OnInit()
	{
		state = TriggerManager.triggerState.none;
	}

	protected override void OnActive()
	{
		EnableLogicUpdate();
	}

	protected override void OnDeactive()
	{
		for (int i = 0; i < triggerConditions.Length; i++)
		{
			triggerConditions[i].ToDestroy();
		}
	}

	public void InitializeXY(int x, int y)
	{
		this.x = x;
		this.y = y;
		if (triggerConditions != null)
		{
			for (int i = 0; i < triggerConditions.Length; i++)
			{
				triggerConditions[i].Initialize(x, y);
			}
		}
	}

	public void RestState()
	{
		state = TriggerManager.triggerState.none;
		if (triggerTask != null)
		{
			triggerTask.ActiveSelf = true;
		}
		if (triggerConditions != null)
		{
			for (int i = 0; i < triggerConditions.Length; i++)
			{
				triggerConditions[i].SyncPosition();
				triggerConditions[i].ActiveSelf = true;
			}
		}
	}

	public void Initialize(int x, int y, bool iInteractive = false)
	{
		if (!iInteractive && isInterActiveTrigger)
		{
			return;
		}
		TriggerConditionBase[] array = triggerConditions;
		if (array == null || array.Length <= 0)
		{
			OnCompelte();
			return;
		}
		ConditionsReset(isInit: true);
		activeTimeFP = FP.FromConfigFloat(activeTime);
		TriggerManager.triggerState triggerState = ((!defaultActive) ? TriggerManager.triggerState.deActive : TriggerManager.triggerState.active);
		SetTriggerState(triggerState);
		this.x = x;
		this.y = y;
		for (int i = 0; i < triggerConditions.Length; i++)
		{
			triggerConditions[i].Initialize(x, y);
		}
	}

	protected override void OnLogicUpdatePaused()
	{
	}

	protected override void OnLogicUpdateResumed()
	{
	}

	protected override void OnLogicUpdate()
	{
		if (waitTime > 0)
		{
			waitTime -= LogicDeltaTime;
			if (waitTime <= 0)
			{
				SetTriggerState(TriggerManager.triggerState.active);
			}
		}
	}

	public void OnTrigger()
	{
		triggerCount++;
		if (!conditionRsAnd || triggerCount >= triggerConditions.Length)
		{
			OnCompelte();
		}
	}

	private void OnCompelte()
	{
		NovaLogger.Debug("trigger_OnCompelte" + gameObject.name);
		ExcuteSingleTask();
		ConditionsReset();
		SetTriggerState(triggerAfterState);
		if (triggerAfterState == TriggerManager.triggerState.deActive && activeTimeFP > FP.Zero)
		{
			waitTime = activeTimeFP;
		}
	}

	private GameObject GetTriggerObj()
	{
		for (int i = 0; i < triggerConditions.Length; i++)
		{
			if (triggerConditions[i].triggerOwner != null)
			{
				return triggerConditions[i].triggerOwner;
			}
		}
		return null;
	}

	private void ExcuteSingleTask()
	{
		if (triggerTask != null)
		{
			triggerTask.OnTriggerTask(GetTriggerObj(), this);
		}
	}

	private void ConditionsReset(bool isInit = false)
	{
		triggerCount = 0;
		for (int i = 0; i < triggerConditions.Length; i++)
		{
			if (isInit)
			{
				triggerConditions[i].triggerAction = OnTrigger;
			}
			else
			{
				triggerConditions[i].StateReset();
			}
		}
	}

	public bool SetTriggerState(TriggerManager.triggerState _state)
	{
		if (state == TriggerManager.triggerState.destroy)
		{
			return false;
		}
		if (state == _state)
		{
			return false;
		}
		for (int i = 0; i < triggerConditions.Length; i++)
		{
			switch (_state)
			{
			case TriggerManager.triggerState.active:
				triggerConditions[i].ToActive();
				break;
			case TriggerManager.triggerState.deActive:
				ConditionsReset();
				triggerConditions[i].ToDeActive();
				break;
			case TriggerManager.triggerState.pause:
				triggerConditions[i].OnPause();
				break;
			case TriggerManager.triggerState.destroy:
				triggerConditions[i].ToDestroy();
				break;
			}
		}
		state = _state;
		return true;
	}

	public bool CheckGroup(string groupTitle)
	{
		if (GroupTitles == null)
		{
			return false;
		}
		for (int i = 0; i < GroupTitles.Length; i++)
		{
			if (GroupTitles[i] == groupTitle)
			{
				return true;
			}
		}
		return false;
	}

	public TSVector2 GetSpecifyMonsterPos()
	{
		for (int i = 0; i < triggerConditions.Length; i++)
		{
			if (triggerConditions[i] is TriggerSpecifyMonsterDeath triggerSpecifyMonsterDeath)
			{
				return triggerSpecifyMonsterDeath.GetPos();
			}
		}
		return TSVector2.zero;
	}

	public void AddTask()
	{
		triggerTask = GetComponentInChildren<TriggerTask>();
		if (triggerTask == null)
		{
			GameObject gameObject = new GameObject("triggerTask");
			triggerTask = gameObject.AddComponent<TriggerTask>();
			gameObject.transform.SetParent(transform);
		}
	}
}
