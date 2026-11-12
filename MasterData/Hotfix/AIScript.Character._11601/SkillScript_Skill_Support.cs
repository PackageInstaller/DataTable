using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11601;

public class SkillScript_Skill_Support : SkillAdvancedBase
{
	private CoroutineNode _perkLogicCor_P21;

	private CoroutineNode _perkLogicCor_P25;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511625, out var _))
		{
			_actor.buffComponent.RemoveBuffByBuffId(11625011);
			if (_perkLogicCor_P25 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P25);
			}
			_perkLogicCor_P25 = _actor.StartLogicCoroutine(PerkLogic_P25());
		}
	}

	public void OnStart()
	{
		_actor.logicVariable.SetLogicTagValue("TriggerExplosionTimes_P24", 0);
		DefaultLookAt();
		string text = "B2_Skill";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511622, out var _))
		{
			text = "B2_Skill_Perk22";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (!string.Equals(eventName, "SupSkill_SeedRain"))
		{
			return;
		}
		TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Forward * Config_Support.generateDistance_NoTarget_Skill;
		if (_actor.attackTarget != null)
		{
			position = _actor.attackTarget.tsTransform.Position;
		}
		string fxAlias = "AreaEffect_11601_Skill_Sup_Seed";
		int additionalAttrId = 0;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511621, out var perkLevel) && _actor.logicVariable.GetLogicTagToggle("TriggerPerk_P21"))
		{
			fxAlias = "AreaEffect_11601_Skill_Sup_Seed";
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 511622, out perkLevel))
			{
				fxAlias = "AreaEffect_11601_Skill_Sup_Seed_Perk22";
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 511627, out perkLevel))
				{
					fxAlias = "AreaEffect_11601_Skill_Sup_Seed_Perk22_Perk27";
				}
			}
			else if (CommonUtils.HavePersonalPerk(_actor.dataID, 511627, out perkLevel))
			{
				fxAlias = "AreaEffect_11601_Skill_Sup_Seed_Perk27";
			}
			additionalAttrId = 11621001;
		}
		else if (CommonUtils.HavePersonalPerk(_actor.dataID, 511622, out perkLevel))
		{
			fxAlias = "AreaEffect_11601_Skill_Sup_Seed_Perk22";
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 511627, out perkLevel))
			{
				fxAlias = "AreaEffect_11601_Skill_Sup_Seed_Perk22_Perk27";
			}
		}
		else if (CommonUtils.HavePersonalPerk(_actor.dataID, 511627, out perkLevel))
		{
			fxAlias = "AreaEffect_11601_Skill_Sup_Seed_Perk27";
		}
		ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position, default, (AreaEffectEntity areaEffect) =>
		{
			if (additionalAttrId > 0)
			{
				areaEffect.AddAdditionalAttr(additionalAttrId);
			}
		});
	}

	private IEnumerator PerkLogic_P21()
	{
		if (Config_Support.useSkillInterval_P21 > 0)
		{
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.useSkillInterval_P21));
		}
		OnStart();
	}

	private IEnumerator PerkLogic_P25()
	{
		FP interval = Config_Support.addBuffInterval_P25;
		while (true)
		{
			interval -= _actor.LogicDeltaTime;
			if (interval <= 0)
			{
				interval += Config_Support.addBuffInterval_P25;
				_actor.buffComponent.AddBuff(11625011, _actor);
			}
			yield return null;
		}
	}

	protected void OnFinish()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511621, out var _))
		{
			if (!_actor.logicVariable.GetLogicTagToggle("TriggerPerk_P21"))
			{
				_actor.logicVariable.ToggleLogicTag("TriggerPerk_P21", value: true);
				if (_perkLogicCor_P21 != null)
				{
					_actor.StopLogicCoroutine(_perkLogicCor_P21);
				}
				_perkLogicCor_P21 = _actor.StartLogicCoroutine(PerkLogic_P21());
			}
			else
			{
				_skill.Clear();
			}
		}
		else
		{
			_skill.Clear();
		}
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.logicVariable.ToggleLogicTag("TriggerPerk_P21", value: false);
		if (_perkLogicCor_P21 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P21);
		}
		_perkLogicCor_P21 = null;
		if (_perkLogicCor_P25 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P25);
		}
		_perkLogicCor_P25 = null;
	}
}
