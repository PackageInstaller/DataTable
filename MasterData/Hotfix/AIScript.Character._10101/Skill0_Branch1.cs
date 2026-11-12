#define LOG_DEBUG
using System;
using AdventureBehaviour;

namespace AIScript.Character._10101;

public class Skill0_Branch1 : Skill0
{
	public override void OnStart()
	{
		NovaLogger.Debug("_10101 Skill0_Branch1 OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.Dodge | SkillPhaseFeatureFlag.Ultimate, null, SkillPhaseFeatureFlag.Dodge | SkillPhaseFeatureFlag.Ultimate, null);
			ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[2]
			{
				ComboInputBuffer.ActionKey.Z,
				ComboInputBuffer.ActionKey.B
			};
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			int skillId = ((_skill != null) ? _skill.skillId : 0);
			System.Action onAnticipationEnd = OnAnticipationEnd;
			System.Action onRecoveryBegin = OnRecoveryBegin;
			System.Action onComboFinish = OnFinish;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, onAnticipationEnd, onRecoveryBegin, null, onComboFinish);
		}
	}
}
