using System;
using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense._11001;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string key = "Skill";

	private string evt_summon = "Summon";

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

	private int castSkillEvt = CommonHelper.StringToHash("castSkillEvt");

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		targetEntity = null;
		aimTarget.Cancel();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		aimTarget.Cancel();
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
		if (_actor.attackTarget != null)
		{
			if (targetEntity != _actor.attackTarget)
			{
				targetEntity = _actor.attackTarget;
				aimTarget.Cancel();
				aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
			}
		}
		else
		{
			aimTarget.Cancel();
		}
	}

	private void DoMainLogic()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.eventHashCode = castSkillEvt;
		_actor.DispatchEvent(adventureActorCustomEvent);
		string actionTag = key;
		Action<string> action = onCustomEvent;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	protected void onCustomEvent(string eventName)
	{
		if (eventName.Equals(evt_summon))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.eventHashCode = summonEvt;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}
}
