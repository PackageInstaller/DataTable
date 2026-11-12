using System;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._13201;

public class SkillScript_Skill_Base_MainControl : SkillAdvancedBase
{
	private static readonly int damageTag_Skill = CommonHelper.StringToHash("132_Main_Skill_Hurt");

	private static readonly int EventHashCode_SkillEnterRecovery = CommonHelper.StringToHash("13201_MainControl_Skill_EnterRecovery");

	private static readonly int EventHashCode_SkillHit = CommonHelper.StringToHash("13201_Skill_Hit");

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		UpdateRootMotionState();
		if (SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection() == TSVector2.zero)
		{
			if (!(_actor.attackTarget != null))
			{
				_ = _actor.tsTransform.Forward;
			}
			else
			{
				_ = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			}
		}
		DefaultLookAt();
	}

	public void OnStart()
	{
		string actionTag = GetActionTag();
		if (string.IsNullOrEmpty(actionTag))
		{
			OnFinish();
			return;
		}
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt);
		OnComboBegin();
	}

	protected virtual string GetActionTag()
	{
		return string.Empty;
	}

	protected virtual void OnComboBegin()
	{
	}

	protected virtual void OnAnticipationEnd()
	{
	}

	public virtual void OnUpdate()
	{
		UpdateRootMotionState();
		LockDirection();
	}

	private void UpdateRootMotionState()
	{
		if (SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection() != TSVector2.zero)
		{
			_actor.movementFSM.runtimeIgonreRootMotion = true;
		}
		else
		{
			_actor.movementFSM.runtimeIgonreRootMotion = false;
		}
	}

	protected override void OnReceiveAttack(IEvent evt)
	{
		base.OnReceiveAttack(evt);
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = evt as AdventureActorReceiveAttackEvent;
		if (adventureActorReceiveAttackEvent.from == _actor && adventureActorReceiveAttackEvent.to is MonsterAdventureActor && CommonUtils.CheckHitByTag(adventureActorReceiveAttackEvent.hitDamageTag, damageTag_Skill))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = this;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = EventHashCode_SkillHit;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private void OnRecoveryBegin()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = this;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = EventHashCode_SkillEnterRecovery;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}

	protected bool HavePersonalPerk(int perkId)
	{
		int perkLevel;
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out perkLevel);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.movementFSM.runtimeIgonreRootMotion = false;
		_actor.logicVariable.SetLogicTagValue("LastSkillFinishTime_MainControl", _actor.LogicTime);
	}
}
