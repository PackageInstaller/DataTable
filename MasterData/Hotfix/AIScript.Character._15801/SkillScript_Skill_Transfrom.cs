using System;
using AIScript.Utils;

namespace AIScript.Character._15801;

public class SkillScript_Skill_Transfrom : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515841, out var _))
		{
			_actor.buffComponent.AddBuff(15841011, _actor);
		}
	}

	public virtual void OnStart()
	{
		string text = (((PlayerAdventureActor)_actor).isAssist ? "158_Skill_Ultra_Support" : "158_Skill_Ultra");
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515809, out var _))
		{
			text = "158_Skill_Ultra";
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
	}
}
