using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50111buffjingling;

public class Action_Light : AIBase
{
	protected enum SkillId
	{
		AddBuff = 5011151,
		RoundFriend = 5011198,
		ToRandomPoint = 5011199,
		RunAway = 5011197
	}

	protected readonly Dictionary<SkillId, List<FP>> skillInfoDic = new Dictionary<SkillId, List<FP>>
	{
		{
			SkillId.AddBuff,
			new List<FP> { 15, 0, 99, 1 }
		},
		{
			SkillId.RoundFriend,
			new List<FP> { 10, 0, 99, 1 }
		},
		{
			SkillId.ToRandomPoint,
			new List<FP> { 10, 0, 99, 1 }
		}
	};

	protected FP hpPercentage_Stage = 0.2;

	protected bool isPlayRunAway;

	protected SkillPool _skillPool;

	protected TraceTarget _traceTarget;

	protected CoroutineNode _checkSkillCor;

	protected bool _checkSkill;

	protected SkillVariable _curSkillVariable;

	public void OnEnable()
	{
		InitSkill();
		isPlayRunAway = false;
		_actor.logicVariable.ToggleLogicTag("CheckSkill_jingling", value: true);
	}

	public void OnStart()
	{
		_checkSkill = true;
	}

	protected void InitSkill()
	{
		if (_skillPool == null)
		{
			_skillPool = new SkillPool();
		}
		List<SkillVariable> list = new List<SkillVariable>();
		foreach (SkillId key in skillInfoDic.Keys)
		{
			List<FP> list2 = skillInfoDic.get_Item(key);
			SkillVariable item = new SkillVariable((int)key, list2.get_Item(0), list2.get_Item(1), list2.get_Item(2), list2.get_Item(3), immBondage: false, _actor.LogicTime);
			list.Add(item);
		}
		_skillPool.Init(_actor, list, 0.1);
	}

	public void OnStop()
	{
		_checkSkill = false;
	}

	public void OnDisable()
	{
		_traceTarget?.Clear();
		_actor.logicVariable.ToggleLogicTag("CheckSkill_jingling", value: false);
		_skillPool = null;
	}

	public void OnUpdate()
	{
		if (_actor.actorHealthInfo.hpPercentage < hpPercentage_Stage && !isPlayRunAway)
		{
			isPlayRunAway = true;
			_actor.actorSkillManage.DestoryAllSkill();
			_actor.logicVariable.ToggleLogicTag("CheckSkill_jingling", value: false);
			ILRuntimeAPI.CreateSkill(5011197, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false);
		}
		if (!_actor.logicVariable.GetLogicTagToggle("CheckSkill_jingling") || !_checkSkill)
		{
			return;
		}
		_curSkillVariable = _skillPool.CheckQualifiedSkill(_actor.LogicTime);
		if (_curSkillVariable == null)
		{
			return;
		}
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (activedPlayerActor != null)
		{
			_checkSkill = false;
			if (_traceTarget == null)
			{
				_traceTarget = new TraceTarget();
			}
			_traceTarget.BeginTrace(_actor, activedPlayerActor, _curSkillVariable.releaseDistance, -1, _curSkillVariable.trackTime, OnTraceFinish, OnTraceCancel);
		}
	}

	protected void OnTraceFinish()
	{
		if (_actor.actorHealthInfo.isAlive)
		{
			_curSkillVariable.ResetExpireTime(_actor.LogicTime);
			ILRuntimeAPI.CreateSkill(_curSkillVariable.id, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, OnSkillFinish);
		}
	}

	protected void OnTraceCancel(bool targetDied, bool isInterrupt, bool isTimeout, bool isDistanceOut)
	{
		_checkSkill = true;
	}

	protected void OnSkillFinish(bool success)
	{
		_checkSkill = true;
	}
}
