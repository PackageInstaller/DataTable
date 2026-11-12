using System;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._15501;

public class SkillScript_MainControl : SkillAdvancedBase
{
	private string key_Base = "155_Main_Skill";

	private string evt_skill = "Summon_Orbit";

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

	private int skillEvt = CommonHelper.StringToHash("skillEvt");

	private FP searchRange = 20;

	private int reduceCD;

	private int limitOrbitCount = 3;

	private bool canCastOrbit;

	private LogicEntity target;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		canCastOrbit = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (target == null || !canCastOrbit)
		{
			_actor.GetLogicComponent<PlayerSkillCd>().ModifyResumeTimePercent(reduceCD, ActionKey.B);
		}
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	private void DoMainLogic()
	{
		string actionTag = key_Base;
		LogicEntity attackTarget = _actor.attackTarget;
		Action<string> action = onCustomEvent;
		System.Action action2 = onRecoveryBegin;
		System.Action onComboFinish = SkillFinish;
		System.Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, attackTarget, null, default, null, action2, onComboFinish, onInterrupt, action);
	}

	private void onRecoveryBegin()
	{
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_skill))
		{
			if (_actor.attackTarget == null)
			{
				_actor.attackTarget = CommonUtils.SearchNearTargetByCircle(_actor, searchRange);
			}
			target = _actor.attackTarget;
			int num = _actor.logicVariable.GetLogicTagValue("obritCount").AsInt();
			canCastOrbit = num < limitOrbitCount;
			if (canCastOrbit)
			{
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.sender = _actor;
				adventureActorCustomEvent.eventHashCode = summonEvt;
				_actor.DispatchEvent(adventureActorCustomEvent);
				adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.sender = _actor;
				adventureActorCustomEvent.eventHashCode = skillEvt;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
			}
		}
	}
}
