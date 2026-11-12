using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Character._13401;

public class SkillScript_NormalAttack_MainControl : SkillScript_NormalAttack
{
	private bool _isSpecialStrength_P4;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void UpdateStrengthState()
	{
		base.UpdateStrengthState();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513404, out var _))
		{
			_isSpecialStrength_P4 = IsStrength && ((PlayerAdventureActor)_actor).GetLocalData("SpecialStrengthNormalAttack") == bool.TrueString;
		}
		else
		{
			_isSpecialStrength_P4 = false;
		}
	}

	protected override List<string> GetComboTagList()
	{
		int perkLevel;
		if (_isSpecialStrength_P4)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513402, out perkLevel))
			{
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 513406, out perkLevel))
				{
					return Config_MainControl.comboTagList_NormalAttack_SpecialStrength_P2_P4_P6;
				}
				return Config_MainControl.comboTagList_NormalAttack_SpecialStrength_P2_P4;
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513406, out perkLevel))
			{
				return Config_MainControl.comboTagList_NormalAttack_SpecialStrength_P4_P6;
			}
			return Config_MainControl.comboTagList_NormalAttack_SpecialStrength_P4;
		}
		if (IsStrength)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513402, out perkLevel))
			{
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 513406, out perkLevel))
				{
					return Config_MainControl.comboTagList_NormalAttack_Strength_P2_P6;
				}
				return Config_MainControl.comboTagList_NormalAttack_Strength_P2;
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513406, out perkLevel))
			{
				return Config_MainControl.comboTagList_NormalAttack_Strength_P6;
			}
		}
		return base.GetComboTagList();
	}

	protected override int GetStage()
	{
		if (_isSpecialStrength_P4)
		{
			CommonUtils.TryParseStringParamToInt(((PlayerAdventureActor)_actor).GetLocalData("SpecialStrengthNormalAttackStage"), out var intValue);
			return intValue;
		}
		return base.GetStage();
	}

	protected override int GetConsumeAmmo()
	{
		if (_isSpecialStrength_P4)
		{
			return 3;
		}
		return base.GetConsumeAmmo();
	}

	protected override void RecordStage(int nextStage)
	{
		if (_isSpecialStrength_P4)
		{
			((PlayerAdventureActor)_actor).SetLocalData("SpecialStrengthNormalAttackStage", nextStage.ToString());
		}
		else
		{
			base.RecordStage(nextStage);
		}
	}

	protected override void OnBeforeStrengthNormalAttackHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeStrengthNormalAttackHit(beforeHitEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513407, out var perkLevel))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(13407011);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(13407001, _actor, buffNumByID);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513410, out perkLevel) && _actor.buffComponent.CheckBuffByBuffID(13410011))
		{
			AdventureActor.AddFromAttr(13410001, _actor);
		}
	}

	protected override void OnStrengthNormalAttackFinish()
	{
		base.OnStrengthNormalAttackFinish();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513407, out var perkLevel))
		{
			_actor.buffComponent.AddBuff(13407011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513410, out perkLevel))
		{
			_actor.buffComponent.RemoveBuffByBuffId(13410011);
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (_isSpecialStrength_P4)
		{
			((PlayerAdventureActor)_actor).SetLocalData("SpecialStrengthNormalAttack", bool.FalseString);
		}
		_isSpecialStrength_P4 = false;
	}
}
