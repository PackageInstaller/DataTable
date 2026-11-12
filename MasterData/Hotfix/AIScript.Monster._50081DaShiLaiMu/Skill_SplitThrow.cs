using System;
using AdventureBehaviour;

namespace AIScript.Monster._50081DaShiLaiMu;

public class Skill_SplitThrow : SkillAdvancedBase
{
	private ComboAttack _comboAttack;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_comboAttack?.Clear();
	}

	public void OnStart()
	{
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1];
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		Action onInterrupt = Finish;
		Action onComboFinish = Finish;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, activedPlayerActor, default, null, null, null, onComboFinish, onInterrupt);
	}

	private void Finish()
	{
		_skill.Clear();
	}
}
