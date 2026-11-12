using System;

namespace AIScript.Character._16001;

public class SkillScript_Skill_BubbleGun_MainControl : SkillScript_Skill_Base_MainControl
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("160_Main_Skill_Switch", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Event_160_Switch"))
		{
			((PlayerAdventureActor)_actor).status = ActorStatus.Special;
			_actor.buffComponent.RemoveBuffByBuffId(16000021);
			_actor.buffComponent.AddBuff(16000022, _actor);
			_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
			_playerSkillCd.BindSkillIdToButton(ActionKey.B, 16031001, resetSection: true);
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
	}
}
