using System;

namespace AIScript.Monster.Soldier._107;

public class MainSkill : SkillAdvancedBase
{
	private string actionKey = "Skill";

	private int buff_id = 250101302;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		_actor.buffComponent.AddBuff(buff_id, _actor);
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		string actionTag = actionKey;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	public void OnUpdate()
	{
	}

	private void OnCustomEvent(string evt)
	{
	}
}
