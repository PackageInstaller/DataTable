using System;
using AIScript.Utils;

namespace AIScript.Character._13001;

public class SkillScript_Summoned_SkillBase : SkillAdvancedBase
{
	protected PlayerAdventureActor _summoner;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
	}

	public void OnStart()
	{
		string actionTag = GetActionTag();
		if (!string.IsNullOrEmpty(actionTag))
		{
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		}
	}

	protected virtual string GetActionTag()
	{
		return string.Empty;
	}

	protected bool HavePersonalPerk(int perkId, out int perkLevel)
	{
		perkLevel = 0;
		if (_summoner == null)
		{
			return false;
		}
		return CommonUtils.HavePersonalPerk(_summoner.dataID, perkId, out perkLevel);
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
		if (HavePersonalPerk(513004, out var _))
		{
			_actor.buffComponent?.AddBuff(13004012, _actor);
		}
		comboAttack?.Clear();
		_summoner = null;
	}
}
