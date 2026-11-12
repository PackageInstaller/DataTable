using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14301;

public class SkillScript_Skill_Support : SkillAdvancedBase
{
	private List<TSVector2> _hitPositionOffest_Stage2;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514327, out var _))
		{
			_actor.buffComponent?.AddBuff(14327011, _actor);
		}
		DefaultLookAt();
	}

	public void OnStart()
	{
		string text = "Skill_Sup_LianHuan_1";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514323, out var _))
		{
			text = "Skill_Sup_LianHuan_1_P23";
		}
		string actionTag = text;
		Action onActivationEnd = OnStageOneActivationEnd;
		Action<string> onCustomEvent = OnStageOneCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd);
	}

	private void OnStageOneActivationEnd()
	{
		string text = "Skill_Sup_LianHuan_2";
		_hitPositionOffest_Stage2 = Config_Support.hitPositionOffest_Skill_Stage2;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514324, out var _))
		{
			text = "Skill_Sup_LianHuan_2_P24";
			_hitPositionOffest_Stage2 = Config_Support.hitPositionOffest_Skill_Stage2_P24;
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnStageTwoCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnStageOneCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "143_P21_DiLie") && CommonUtils.HavePersonalPerk(_actor.dataID, 514322, out var _))
		{
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_Support.generatefissureAreaEffectOffset_P22.x + _actor.tsTransform.Forward * Config_Support.generatefissureAreaEffectOffset_P22.y;
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_143_P22_DiLie", position, _actor.tsTransform.Forward.GetAngle());
		}
	}

	private void OnStageTwoCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "143_P21_LongJuanFeng") && CommonUtils.HavePersonalPerk(_actor.dataID, 514321, out var _) && _hitPositionOffest_Stage2 != null && _hitPositionOffest_Stage2.Count > 0)
		{
			for (int i = 0; i < _hitPositionOffest_Stage2.Count; i++)
			{
				TSVector2 tSVector = _hitPositionOffest_Stage2.get_Item(i);
				TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * tSVector.x + _actor.tsTransform.Forward * tSVector.y;
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_143_P21_LongJuanFeng", position, _actor.tsTransform.Forward.GetAngle());
			}
		}
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
	}
}
