using System.Threading.Tasks;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

public abstract class BaseEventTriggerNode : BaseMapDataNode
{
	public string Desc;

	[Tooltip("默认激活的触发器，可以直接触发。")]
	public bool triggerInitSwitch;

	[Tooltip("剩余可触发次数。")]
	public int executeTime = 1;

	public float delayTimer;

	private bool triggerSwitch;

	private int initExecuteTime;

	protected bool isStart;

	public abstract string TriggerName { get; }

	public override bool DisplayNode => false;

	public override bool UsedOcTree => false;

	public bool TriggerSwitch => triggerSwitch;

	protected bool isLoop => executeTime == -1;

	public override void OnInited(object data = null)
	{
		base.OnInited(data);
		triggerSwitch = triggerInitSwitch;
		initExecuteTime = executeTime;
	}

	public override void OnStarted(object data = null)
	{
		base.OnStarted(data);
		if (SubscriptionTask)
		{
			Execute();
		}
	}

	public override void OnReceiveMapDataEvent(LevelMapDataEvent eventType, BaseEntity otherEntity = null)
	{
		base.OnReceiveMapDataEvent(eventType, otherEntity);
		if (eventType == LevelMapDataEvent.RestLevel)
		{
			OnRestLevel();
		}
	}

	protected override void OnTaskConditionChanged()
	{
		base.OnTaskConditionChanged();
		if (base.TaskConditionResult)
		{
			Execute();
		}
	}

	public override void OnDisposed()
	{
	}

	public void OnRestLevel()
	{
		if (triggerInitSwitch)
		{
			Active();
		}
		else
		{
			Disable();
		}
		executeTime = initExecuteTime;
	}

	public virtual async void Execute()
	{
		if (base.TaskConditionResult)
		{
			if (!triggerSwitch || executeTime == 0)
			{
				isStart = false;
				return;
			}
			_ = isLoop;
			await UniTask.WaitForSeconds(delayTimer);
			DoExecute();
		}
	}

	protected virtual void DoExecute()
	{
	}

	public virtual async Task ExecuteAsync()
	{
		if (!base.TaskConditionResult)
		{
			return;
		}
		if (!triggerSwitch || executeTime == 0)
		{
			isStart = false;
			return;
		}
		_ = isLoop;
		if (delayTimer > 0f)
		{
			await Task.Delay((int)delayTimer * 1000);
		}
		await DoExecuteAsync();
	}

	protected virtual async UniTask DoExecuteAsync()
	{
	}

	public virtual void Active()
	{
		triggerSwitch = true;
	}

	public virtual void Disable()
	{
		triggerSwitch = false;
	}

	protected virtual void UpdateEventTriggerName()
	{
		((Object)(object)this).name = (triggerInitSwitch ? "√" : "×") + " 事件触发器 - " + TriggerName + " - " + Desc;
	}

	public virtual void DeleteTrigger()
	{
		Object.DestroyImmediate(((Component)(object)this).gameObject);
	}

	public void TestTrigger()
	{
		Active();
		Execute();
	}

	private bool IsInEditMode()
	{
		if (!Application.isPlaying)
		{
			return false;
		}
		return executeTime == 0;
	}
}
