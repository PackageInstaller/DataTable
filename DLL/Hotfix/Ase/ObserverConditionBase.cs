#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;

namespace Ase;

public abstract class ObserverConditionBase
{
	protected BaseEntity formEntity;

	protected ObserverConditionParams relationParam;

	protected ObserverConditionParams[] conditionParams;

	[Obsolete]
	public void Init(BaseEntity formEntity)
	{
		this.formEntity = formEntity;
		OnInit();
	}

	public void Init(BaseEntity formEntity, BattleObserverEventEnum eventEnum, string[] args)
	{
		this.formEntity = formEntity;
		if (args == null || args.Length == 0)
		{
			return;
		}
		relationParam = new ObserverConditionParams(args[0].ToString());
		if (args.Length != 1)
		{
			conditionParams = new ObserverConditionParams[args.Length - 1];
			for (int i = 0; i < args.Length - 1; i++)
			{
				conditionParams[i] = new ObserverConditionParams(args[i + 1].ToString());
			}
			OnInit();
		}
	}

	public void Init(BaseEntity formEntity, BattleObserverEventEnum eventEnum, List<string> args)
	{
		this.formEntity = formEntity;
		if (args == null || args.Count == 0)
		{
			Log.Error("条件参数为空:" + eventEnum);
			return;
		}
		relationParam = new ObserverConditionParams(args[0]);
		if (args.Count != 1)
		{
			conditionParams = new ObserverConditionParams[args.Count - 1];
			for (int i = 0; i < args.Count - 1; i++)
			{
				conditionParams[i] = new ObserverConditionParams(args[i + 1]);
			}
			OnInit();
		}
	}

	protected virtual void OnInit()
	{
	}

	[Obsolete]
	public virtual bool CheckCondition(IObserverParams param, object[] args)
	{
		if (args == null || args.Length == 0)
		{
			return false;
		}
		ObserverConditionParams observerConditionParams = new ObserverConditionParams(args[0].ToString());
		if (!CompareRelation(param.Trigger, observerConditionParams))
		{
			return false;
		}
		if (args.Length == 1)
		{
			return true;
		}
		ObserverConditionParams[] array = new ObserverConditionParams[args.Length - 1];
		for (int i = 0; i < args.Length - 1; i++)
		{
			array[i] = new ObserverConditionParams(args[i + 1].ToString());
		}
		return IsCondition(param, array);
	}

	public virtual bool CheckCondition(IObserverParams param)
	{
		if (!CompareRelation(param.Trigger, relationParam))
		{
			return false;
		}
		if (conditionParams == null || conditionParams.Length == 0)
		{
			return true;
		}
		return IsCondition(param, conditionParams);
	}

	[Obsolete]
	public virtual bool CheckCondition(IObserverParams param, List<string> args)
	{
		if (args == null || args.Count == 0)
		{
			return false;
		}
		ObserverConditionParams observerConditionParams = new ObserverConditionParams(args[0]);
		if (!CompareRelation(param.Trigger, observerConditionParams))
		{
			return false;
		}
		if (args.Count == 1)
		{
			return true;
		}
		ObserverConditionParams[] array = new ObserverConditionParams[args.Count - 1];
		for (int i = 0; i < args.Count - 1; i++)
		{
			array[i] = new ObserverConditionParams(args[i + 1].ToString());
		}
		return IsCondition(param, array);
	}

	protected abstract bool IsCondition(IObserverParams param, ObserverConditionParams[] conditionParams);

	protected bool CompareRelation(BaseEntity trigger, ObserverConditionParams conditionParams)
	{
		if (trigger == null)
		{
			return false;
		}
		if (conditionParams == null)
		{
			return false;
		}
		if (conditionParams.IsAny)
		{
			return true;
		}
		return ConditionUtility.ConditionRelationTypeEnum(AIUtility.GetRelation(trigger, formEntity), conditionParams.ParamString) == conditionParams.Compare;
	}
}
