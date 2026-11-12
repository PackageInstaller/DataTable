using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.Soldier._135._135BigHeadGhost;

public class Action_Summoned : AIBase
{
	private const int skillId_Attack = 100013504;

	private const int skillId_Attack_Extra = 100013505;

	private const int skillId_Whirlwind = 100013506;

	private static readonly FP durationTime = 10;

	private static readonly FP attackInterval = 1;

	private static readonly FP arriveDistance = 2;

	private static readonly int broadcastEvt_Whirlwind = CommonHelper.StringToHash("135_MainSkill_CasWhirlwind");

	private static readonly int broadcastEvt_ExtendLife = CommonHelper.StringToHash("135_MainSkill_ExtendLife");

	private readonly TraceTarget _traceTarget = new TraceTarget();

	private LogicEntity _target;

	private FP _durationTime;

	private FP _attackInterval;

	private bool _arrived;

	private bool _useExtraAttack;

	public void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
	}

	public void OnStart()
	{
		_actor.EnableUnparalleled();
		_actor.EnableCloseBlock();
		_actor.EnableSearchedImmunity();
		_durationTime = durationTime;
		_attackInterval = 0;
		_arrived = false;
		_useExtraAttack = false;
		RefreshTarget();
	}

	public void OnUpdate()
	{
		_durationTime -= _actor.LogicDeltaTime;
		if (_durationTime <= 0)
		{
			_actor.DestroySelf();
			return;
		}
		RefreshTarget();
		if (_target == null)
		{
			_arrived = false;
		}
		else if (TSVector2.Distance(_actor.tsTransform.Position, _target.tsTransform.Position) <= arriveDistance)
		{
			if (!_arrived)
			{
				_arrived = true;
				_traceTarget.CancelTrace();
				_attackInterval = 0;
			}
			if (_attackInterval > 0)
			{
				_attackInterval -= _actor.LogicDeltaTime;
				return;
			}
			int skillId = (_useExtraAttack ? 100013505 : 100013504);
			if (!_actor.actorSkillManage.HaveSkill(100013504) && !_actor.actorSkillManage.HaveSkill(100013505))
			{
				ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.DynamicActor);
				_useExtraAttack = !_useExtraAttack;
				_attackInterval = attackInterval;
			}
		}
		else
		{
			_arrived = false;
			if (!_traceTarget.Tracing)
			{
				_traceTarget.BeginTrace(_actor, _target, arriveDistance, -1, -1, null, null);
			}
		}
	}

	public void OnStop()
	{
		_actor.DisableUnparalleled();
		_actor.DisableCloseBlock();
		_actor.DisableSearchedImmunity();
		_traceTarget.CancelTrace();
		_traceTarget.Clear();
		_target = null;
		_durationTime = 0;
	}

	private void RefreshTarget()
	{
		LogicEntity logicEntity = GetPriorityConfrontTarget();
		if (logicEntity == null)
		{
			FP fP = FP.MaxValue;
			TSVector2 position = _actor.tsTransform.Position;
			List<AdventureActor> confrontFactionActors = ILRuntimeAPI.GetConfrontFactionActors(_actor);
			for (int i = 0; i < confrontFactionActors.Count; i++)
			{
				AdventureActor adventureActor = confrontFactionActors.get_Item(i);
				if (adventureActor == null || adventureActor == _actor)
				{
					continue;
				}
				ActorHealthInfo actorHealthInfo = adventureActor.actorHealthInfo;
				if (actorHealthInfo != null && actorHealthInfo.isAlive && !adventureActor.IsSearchedImmunity())
				{
					FP fP2 = TSVector2.DistanceSquared(position, adventureActor.tsTransform.Position);
					if (fP2 < fP)
					{
						fP = fP2;
						logicEntity = adventureActor;
					}
				}
			}
		}
		if (!(logicEntity == _target))
		{
			_target = logicEntity;
			_actor.attackTarget = _target;
			_traceTarget.CancelTrace();
			_arrived = false;
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (!(evt is AdventureActorCustomEvent adventureActorCustomEvent) || _actor.isDead || _actor.inDying)
		{
			return;
		}
		if (adventureActorCustomEvent.eventHashCode == broadcastEvt_Whirlwind)
		{
			_traceTarget.CancelTrace();
			_arrived = false;
			_actor.actorSkillManage.ClearSkillById(100013504);
			_actor.actorSkillManage.ClearSkillById(100013505);
			_attackInterval = attackInterval;
			if (!ILRuntimeAPI.CreateSkill(100013506, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false))
			{
				Debug.LogError($"[135_Whirlwind] CreateSkill 失败 actorId={_actor.Id} skillId={100013506} " + $"—— 检查：①技能表是否有 {100013506} 配置；②普攻技能 phase execute config 是否允许被 CertainSkillId 打断/未白名单 {100013506}；③FCPath 是否注册。");
			}
		}
		else if (adventureActorCustomEvent.eventHashCode == broadcastEvt_ExtendLife)
		{
			_durationTime += adventureActorCustomEvent.fpParam;
		}
	}

	private LogicEntity GetPriorityConfrontTarget()
	{
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return null;
		}
		if (soldierLevelController.GetPartnerLv(HotfixEnum.ChessPartnerType.GaoGeDaXinWen) < 1)
		{
			return null;
		}
		SoldierActor soldierActor = FindSummoner(soldierLevelController);
		if (soldierActor != null && soldierActor.attackTarget is AdventureActor { actorHealthInfo: { isAlive: not false } } adventureActor && !adventureActor.IsSearchedImmunity())
		{
			return adventureActor;
		}
		return null;
	}

	private SoldierActor FindSummoner(SoldierLevelController levelController)
	{
		List<SoldierLevelController.SoldierSummonData> soldierSummonInfos = levelController.GetSoldierSummonInfos();
		if (soldierSummonInfos == null)
		{
			return null;
		}
		for (int i = 0; i < soldierSummonInfos.Count; i++)
		{
			if (soldierSummonInfos.get_Item(i).entityId == _actor.Id)
			{
				return soldierSummonInfos.get_Item(i).summoner;
			}
		}
		return null;
	}
}
