using System;
using AdventureBehaviour;

namespace AIScript.Monster._10017XiChenQi;

public class Skill_SpinDash : SkillAdvancedBase
{
	protected const string atackStartEvt = "AttackStart";

	protected const string attackOverEvt = "AttackOver";

	protected const int buffId = 9900311;

	protected ComboAttack _comboAttack;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnFinish;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnCustomEvent(string eventName)
	{
		if (!(eventName == "AttackStart"))
		{
			if (eventName == "AttackOver")
			{
				_actor.buffComponent?.RemoveBuffByBuffId(9900311);
			}
		}
		else
		{
			_actor.buffComponent?.AddBuff(9900311, _actor);
		}
	}

	protected void OnFinish()
	{
		_skill?.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_comboAttack?.Clear();
		_comboAttack = null;
	}
}
