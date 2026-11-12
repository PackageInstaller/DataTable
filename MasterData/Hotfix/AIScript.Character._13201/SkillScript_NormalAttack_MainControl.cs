#define LOG_ERROR
using System;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._13201;

public class SkillScript_NormalAttack_MainControl : SkillAdvancedBase
{
	private static readonly List<string> actionTagList = new List<string> { "132_Attack_1", "132_Attack_2", "132_Attack_3", "132_Attack_4", "132_Attack_5" };

	private static readonly int damageTag_NormalAttack = CommonHelper.StringToHash("132_NormalAttack");

	private static readonly int EventHashCode_NormalAttackHit = CommonHelper.StringToHash("13201_Normal_Attack_Hit");

	private int _stage;

	private bool _isHit;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		UpdateRootMotionState();
		_stage = (int)(long)_actor.logicVariable.GetLogicTagValue("NormalAttackStage");
		_isHit = false;
	}

	public void OnStart()
	{
		string text = ((_stage < actionTagList.Count) ? actionTagList.get_Item(_stage) : null);
		if (string.IsNullOrEmpty(text))
		{
			NovaLogger.Error($"该普攻段数未配置ActionTag, 普攻段数:{_stage}");
			OnFinish();
			return;
		}
		LogicEntity attackTarget = _actor.attackTarget;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(text, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, attackTarget, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnAnticipationEnd()
	{
		int num = _stage + 1;
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", (num < actionTagList.Count) ? num : 0);
	}

	public void OnUpdate()
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
		if (adventureActorReceiveAttackEvent.from == _actor && adventureActorReceiveAttackEvent.to is MonsterAdventureActor && !_isHit && CommonUtils.CheckHitByTag(adventureActorReceiveAttackEvent.hitDamageTag, damageTag_NormalAttack))
		{
			_isHit = true;
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = this;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = EventHashCode_NormalAttackHit;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
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
		_stage = 0;
		_isHit = false;
	}
}
