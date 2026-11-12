using System;
using AdventureBehaviour;

namespace AIScript.Character._99701;

public class Skill0_Branch1 : Skill0
{
	public override void OnStart()
	{
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.Dodge | SkillPhaseFeatureFlag.Ultimate, null, SkillPhaseFeatureFlag.Dodge | SkillPhaseFeatureFlag.Ultimate, null);
			ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };
			if (_actor.buffComponent.CheckBuffByBuffID(99701))
			{
				array = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };
			}
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			ComboInputBuffer.ActionKey[] actionKeys = array;
			int skillId = ((_skill != null) ? _skill.skillId : 0);
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			System.Action onAnticipationEnd = OnAnticipationEnd;
			System.Action onRecoveryBegin = OnRecoveryBegin;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, onAnticipationEnd, onRecoveryBegin, null, onComboFinish, onInterrupt);
		}
	}
}
