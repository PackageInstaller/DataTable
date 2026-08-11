using System;
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;

namespace Ase;

[Serializable]
public abstract class BuffConditionBase : IReference, IObserverHandler
{
	protected string label0;

	protected string label1;

	protected string label2;

	protected string label3;

	protected string label4;

	protected string label5;

	protected string label6;

	protected string label7;

	protected string label8;

	protected string label9;

	protected string label10;

	public string Title = "Buff条件数据";

	public string Desc = "buff 描述测试 test 0.1";

	protected BaseEntity entityTarget;

	protected BaseEntity entityFrom;

	private BattleObserverEventEnum eventType;

	protected BuffRuntimeDataBase runtimeData;

	public abstract BuffConditionType BuffConditionType { get; }

	protected abstract int paramsMinCount { get; }

	protected virtual BattleObserverEventEnum EventType
	{
		get
		{
			return eventType;
		}
		set
		{
			eventType = value;
		}
	}

	protected bool IsSyncBattle { get; private set; }

	public BuffRuntimeDataBase RuntimeData => runtimeData;

	public static BuffConditionBase Create(BaseEntity unitFrom, BaseEntity unitTarget, BuffConditionType conditionType, List<string> parameters)
	{
		if (parameters == null)
		{
			return null;
		}
		BuffConditionBase buffCondition = BuffSystem.GetBuffCondition(conditionType);
		if (buffCondition == null)
		{
			return null;
		}
		buffCondition.Init(unitFrom, unitTarget, parameters);
		buffCondition.Start();
		return buffCondition;
	}

	public static BuffConditionBase Create(BuffConditionType conditionType, List<string> parameters)
	{
		if (parameters == null)
		{
			return null;
		}
		BuffConditionBase buffCondition = BuffSystem.GetBuffCondition(conditionType);
		if (buffCondition == null)
		{
			return null;
		}
		buffCondition.Init(parameters);
		return buffCondition;
	}

	public bool CheckConditionEvent(BattleObserverEventEnum eventType)
	{
		return EventType == eventType;
	}

	public void Init(BaseEntity from, BaseEntity target, List<string> paramList)
	{
		entityFrom = from;
		entityTarget = target;
		if (paramList != null && (paramList.Count >= paramsMinCount || paramsMinCount == -1))
		{
			OnInit(paramList);
			ChekBuffConditionSafeAction();
		}
	}

	public void Init(List<string> paramList)
	{
		OnInit(paramList);
	}

	protected abstract void OnInit(List<string> paramList);

	protected void Start()
	{
		if (eventType != BattleObserverEventEnum.None)
		{
			entityTarget.GetSystem<BattleObserverSystem>().Attach(eventType, this);
		}
	}

	public void OnNotify(IObserverParams param)
	{
		OnMessage(param);
	}

	protected virtual void OnMessage(IObserverParams param)
	{
	}

	private void ChekBuffConditionSafeAction()
	{
		if ((entityTarget.GetSystem<BattleSystem>()?.BattleMode ?? BattleWorldMode.SyncBattle) == BattleWorldMode.SyncBattle)
		{
			IsSyncBattle = true;
			OnCheckSyncBattleSafeAction();
		}
		else
		{
			IsSyncBattle = false;
		}
	}

	protected virtual void OnCheckSyncBattleSafeAction()
	{
	}

	public bool Check(Buff buff = null)
	{
		return OnCheck(buff);
	}

	public abstract bool OnCheck(Buff buff = null);

	protected virtual void OnRecord(Buff buff)
	{
		if (buff != null)
		{
			AddRecordInfo(entityTarget.Id, buff.BuffId, $"条件[{(int)BuffConditionType}] 通过");
		}
	}

	public virtual void Update(float deltaTime)
	{
	}

	public void Reset()
	{
		OnReset();
	}

	protected virtual void OnReset()
	{
	}

	public void AddRecordInfo(int entityId, int buffId, string record)
	{
	}

	protected void LogWarning(string msg)
	{
	}

	public void Dispose()
	{
		entityTarget.GetSystem<BattleObserverSystem>().Detach(EventType, this);
		if (runtimeData != null)
		{
			ReferencePool.Release(runtimeData);
			runtimeData = null;
		}
		OnDispose();
	}

	protected virtual void OnDispose()
	{
	}

	public string GetDataString()
	{
		return $"{(int)BuffConditionType},{OnGetDataString()}";
	}

	protected abstract string OnGetDataString();

	public override string ToString()
	{
		return Title + " \t\t 数据 :  " + GetDataString();
	}

	public void Clear()
	{
	}
}
