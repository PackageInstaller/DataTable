using System;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._15601;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	public virtual void OnStart()
	{
		string text = Config.comboTagList_NormalAttack.get_Item(TSRandom.Range(0, Config.comboTagList_NormalAttack.Count));
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515603, out var _))
		{
			int parameterId = 15603011;
			if (((PlayerAdventureActor)_actor).playerSkillCd.GetSkillCD(ActionKey.B).currentResumeTime > 0)
			{
				parameterId = 15603012;
			}
			if (TSRandom.Range(FP.Zero, 100) <= CommonUtils.GetScriptValue(_actor, parameterId))
			{
				text = "Atk_Shot_P3";
			}
		}
		string actionTag = text;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
	}
}
