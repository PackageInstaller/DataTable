using System;
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._14401;

public class SkillScript_Skill_Normal_MainControl : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt(useInputDirectionFirst: true, useSemiAutoBattleMode: true);
		_actor.EnableCloseBlock();
		CommonUtils.EnableCrossObstacleMode(_actor);
		_actor.buffComponent.AddBuff(14493001, _actor);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514401, out var perkLevel))
		{
			_actor.buffComponent.AddBuff(14401011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514402, out perkLevel))
		{
			_actor.buffComponent.AddBuff(14401011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514408, out perkLevel))
		{
			_actor.buffComponent.AddBuff(14408011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514412, out perkLevel))
		{
			_actor.buffComponent.AddBuff(14412011, _actor);
		}
	}

	public void OnStart()
	{
		CommonUtils.CheckAndSetCrossObstacleMode(_actor, Config_MainControl.realMoveDistance_Skill, Config_MainControl.crossAdditionDistance_Skill, Config_MainControl.crossKeepAwayNavmeshEdgeDistance_Skill, forceUseForwardDirection: true);
		string comboTag = GetComboTag();
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514404, out var _))
		{
			if (!Config.replaceMonsterIdDic_Summon_ForSkin.TryGetValue(_actor.skinID, out var value))
			{
				value = 14401111;
			}
			ILRuntimeAPI.SummonMonster(_actor, 0, value, _actor.tsTransform.Position, _actor.tsTransform.Forward, Config.summonCfg_Summon, null, (MonsterAdventureActor summoned) =>
			{
				summoned.logicVariable.SetLogicTagValue("DelayUseSkillTime_Summon", Config_MainControl.summonedDelayUseSkillTime_P4);
				summoned.logicVariable.SetLogicTagStringValue("SkillComboTag_Summon", comboTag);
				summoned.logicVariable.ToggleLogicTag("CloseBlock_Summon", value: true);
				summoned.logicVariable.ToggleLogicTag("OpenCrossObstacleMode_Summon", value: true);
				summoned.attackTarget = _actor.attackTarget;
				summoned.logicVariable.ToggleLogicTag("SummonFinish_Summon", value: true);
			});
		}
	}

	protected virtual string GetComboTag()
	{
		return "144_B1";
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "144_B1_InvincibleAdd"))
		{
			_actor.buffComponent.AddBuff(14400001, _actor);
		}
		else if (string.Equals(eventName, "144_B1_InvincibleRemove"))
		{
			_actor.buffComponent.RemoveBuffByBuffId(14400001);
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
		_actor.DisableCloseBlock();
		CommonUtils.DisableCrossObstacleMode(_actor);
		CommonUtils.ClearCrossObstacleMode(_actor);
		_actor.buffComponent.RemoveBuffByBuffId(14493001);
		_actor.buffComponent.RemoveBuffByBuffId(14400001);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514405, out var _))
		{
			_actor.logicVariable.ToggleLogicTag("TriggerPerk_P5", value: true);
		}
	}
}
