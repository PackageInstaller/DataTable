using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12501;

public class ActionScript : ActorActionBase
{
	private CoroutineNode _berserkCor;

	private int _buffId_BerserkTiming;

	private int _timingBuffCount_EnterBerserk;

	private FP _reduceTimingBuffInterval;

	private FP _delayNormalAttackStageDelay;

	protected bool InBerserkState
	{
		get
		{
			if (((PlayerAdventureActor)_actor).status == ActorStatus.Special)
			{
				return ((PlayerAdventureActor)_actor).specialStatusTime > 0;
			}
			return false;
		}
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		_delayNormalAttackStageDelay = Config.delay_ResetNormalAttackStage;
		_buffId_BerserkTiming = 12500002;
		_timingBuffCount_EnterBerserk = 20;
		if (InBerserkState)
		{
			_actor.ReplaceAnimationGroup();
			EnterBerserk(((PlayerAdventureActor)_actor).specialStatusTime.AsInt());
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = evt as AdventureActorCustomEvent;
		if (!(adventureActorCustomEvent.actor != _actor) && adventureActorCustomEvent.eventHashCode == Config.eventHashCode_EnterBerserk)
		{
			EnterBerserk(_timingBuffCount_EnterBerserk);
		}
	}

	protected void EnterBerserk(int timingBuffCount)
	{
		for (int i = 0; i < timingBuffCount; i++)
		{
			_actor.buffComponent?.AddBuff(_buffId_BerserkTiming, _actor);
		}
		_reduceTimingBuffInterval = Config.interval_ReduceTimingBuffCount;
		if (_berserkCor != null)
		{
			if (!InBerserkState)
			{
				_actor.StopLogicCoroutine(_berserkCor);
				_berserkCor = _actor.StartLogicCoroutine(BerserkState(), runImmediately: true);
			}
		}
		else
		{
			_berserkCor = _actor.StartLogicCoroutine(BerserkState(), runImmediately: true);
		}
	}

	private IEnumerator BerserkState()
	{
		((PlayerAdventureActor)_actor).status = ActorStatus.Special;
		((PlayerAdventureActor)_actor).specialStatusTime = _actor.buffComponent.GetBuffNumByID(_buffId_BerserkTiming);
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
		_actor.buffComponent?.AddBuff(12594001, _actor);
		OnEnterBerserk();
		while (((PlayerAdventureActor)_actor).specialStatusTime > 0)
		{
			if (!_actor.logicVariable.GetLogicTagToggle("LockBerserkDuration"))
			{
				if (_reduceTimingBuffInterval > 0)
				{
					_reduceTimingBuffInterval -= _actor.LogicDeltaTime;
				}
				else
				{
					_actor.buffComponent?.RemoveBuffByBuffId(_buffId_BerserkTiming, 1);
					((PlayerAdventureActor)_actor).specialStatusTime = _actor.buffComponent.GetBuffNumByID(_buffId_BerserkTiming);
					_reduceTimingBuffInterval = Config.interval_ReduceTimingBuffCount;
				}
			}
			yield return null;
		}
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
		_actor.buffComponent?.RemoveBuffByBuffId(12594001);
		OnExitBerserk();
		((PlayerAdventureActor)_actor).status = ActorStatus.Default;
		((PlayerAdventureActor)_actor).specialStatusTime = 0;
		while (!ILRuntimeAPI.CreateSkill(12500002, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, OnExitBerserkSkillFinish))
		{
			yield return null;
		}
		_berserkCor = null;
	}

	protected void AddBerserkTime(int timingBuffCount)
	{
		if (InBerserkState && _berserkCor != null)
		{
			for (int i = 0; i < timingBuffCount; i++)
			{
				_actor.buffComponent?.AddBuff(_buffId_BerserkTiming, _actor);
			}
		}
	}

	public virtual void OnUpdate()
	{
		if (_actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Normal))
		{
			_delayNormalAttackStageDelay = Config.delay_ResetNormalAttackStage;
		}
		else if (_delayNormalAttackStageDelay > 0)
		{
			_delayNormalAttackStageDelay -= _actor.LogicDeltaTime;
		}
		else
		{
			_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
		}
	}

	protected virtual void OnExitBerserkSkillFinish(bool success)
	{
	}

	protected void ForceExitBerserkState()
	{
		(_actor as PlayerAdventureActor).status = ActorStatus.Default;
		(_actor as PlayerAdventureActor).specialStatusTime = 0;
		if (_berserkCor != null)
		{
			_actor.StopLogicCoroutine(_berserkCor);
		}
		_berserkCor = null;
		OnExitBerserk();
	}

	protected virtual void OnEnterBerserk()
	{
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
		{
			_actor.buffComponent.AddBuff(12596411, _actor);
		}
	}

	protected virtual void OnExitBerserk()
	{
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512541, out var _))
		{
			_actor.buffComponent?.RemoveBuffByBuffId(12541011);
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
		{
			_actor.buffComponent.RemoveBuffByBuffId(12596411);
		}
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		if (_berserkCor != null)
		{
			_actor.StopLogicCoroutine(_berserkCor);
		}
		_berserkCor = null;
	}
}
