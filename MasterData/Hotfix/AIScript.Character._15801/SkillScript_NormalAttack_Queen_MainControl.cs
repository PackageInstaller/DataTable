using System;

namespace AIScript.Character._15801;

public class SkillScript_NormalAttack_Queen_MainControl : SkillScript_Summoned
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0f);
		}
	}

	public void OnStart()
	{
		string text = "15801_Queen_Attack_Shoot";
		if (HavePersonalPerk(515801, out var _))
		{
			text = "15801_Queen_Attack_Shoot_Strengthen";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "15801_Queen_Shoot_Start"))
		{
			if (_actor.attackTarget != null)
			{
				_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0f);
			}
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_QueenBeginNormalAttack;
			_summoner?.DispatchEvent(adventureActorCustomEvent);
		}
	}

	public void OnUpdate()
	{
		LockDirection();
		if (_actor.attackTarget == null || _actor.DistanceWithRadius(_actor.attackTarget) > Config_MainControl.attackRange_Queen)
		{
			comboAttack.CancelAttack();
		}
	}

	public void OnFinish()
	{
		_skill.Clear();
	}

	public void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
