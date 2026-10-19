using System;
using System.Runtime.CompilerServices;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinListenEvt : BaseAbilityMixin
{
	public ConfigMixinListenEvt config;

	private float timeFlag;

	private bool _isHandlingEvt;

	public AbilityMixinListenEvt(ConfigMixinListenEvt config, Ability ab, byte index)
		: base(ab, index)
	{
		this.config = config;
	}

	internal override void RebindForPool(ConfigMixin configMixin, Ability ab, byte newIndex)
	{
		base.RebindForPool(configMixin, ab, newIndex);
		config = (ConfigMixinListenEvt)configMixin;
	}

	internal override void ResetForPool()
	{
		config = null;
		timeFlag = 0f;
		_isHandlingEvt = false;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		timeFlag = 0f;
		for (int i = 0; i < config.configs.Length; i++)
		{
			ListenEvtItem listenEvtItem = config.configs[i];
			ListenEvt(listenEvtItem.listenEvtType, listenEvtItem.global);
		}
	}

	internal override void OnRemove()
	{
		RemoveListen();
	}

	internal override void OnSilentRemove()
	{
		RemoveListen();
	}

	internal override void ListenEvt(BaseEvt evt)
	{
		if (Time.time - timeFlag > config.cd || config.cd < 1E-06f)
		{
			timeFlag = Time.time;
			DoThisAction(evt);
		}
	}

	private void RemoveListen()
	{
		if (config != null)
		{
			for (int i = 0; i < config.configs.Length; i++)
			{
				ListenEvtItem listenEvtItem = config.configs[i];
				RemoveListenEvt(listenEvtItem.listenEvtType, listenEvtItem.global);
			}
		}
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (Time.time - timeFlag > config.cd || config.cd < 1E-06f)
		{
			timeFlag = Time.time;
			DoThisAction(evt);
		}
	}

	private void DoThisAction(BaseEvt evt)
	{
		if (_isHandlingEvt)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("[EvtLoop] " + evt.GetType().Name + " 监听Action被跳过以防止死循环, ability:" + ability.config.name);
			}
			return;
		}
		_isHandlingEvt = true;
		try
		{
			for (int i = 0; i < config.configs.Length; i++)
			{
				ListenEvtItem listenEvtItem = config.configs[i];
				if (listenEvtItem.MatchType(listenEvtItem.listenEvtType, evt))
				{
					DoActions(owner, evt, listenEvtItem.actions);
				}
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"*********策划处理下：监听技能报错了,ability:{ability.config.name}, ex:{arg}");
			}
		}
		finally
		{
			_isHandlingEvt = false;
		}
	}

	private void ListenEvt(ListenEvtType eventType, bool global)
	{
		if (global)
		{
			Singleton<GameManager>.instance.ecsManager.systemAbility.AddListener(GetEvtType(eventType), this);
		}
		else
		{
			owner.GetCompAbility().AddListener(GetEvtType(eventType), this);
		}
	}

	private void RemoveListenEvt(ListenEvtType eventType, bool global)
	{
		if (global)
		{
			Singleton<GameManager>.instance.ecsManager.systemAbility.RemoveListener(GetEvtType(eventType), this);
		}
		else
		{
			owner.GetCompAbility().RemoveListener(GetEvtType(eventType), this);
		}
	}

	private static Type GetEvtType(ListenEvtType listenEvtType)
	{
		switch (listenEvtType)
		{
		case ListenEvtType.AfterMeAttack:
			return typeof(EvtAttack);
		case ListenEvtType.AfterMeAttacked:
			return typeof(EvtAttacked);
		case ListenEvtType.AfterMeDealDamage:
			return typeof(EvtDealDamage);
		case ListenEvtType.AfterMeDamaged:
			return typeof(EvtDamaged);
		case ListenEvtType.WhenMeModifyDamage:
			return typeof(EvtModifyDamage);
		case ListenEvtType.WhenMeModifyDamaged:
			return typeof(EvtAttackeeModifyDamage);
		case ListenEvtType.WhenMeModifyTenacitied:
			return typeof(EvtAttackeeModifyTenacitied);
		case ListenEvtType.BattleChange:
			return typeof(EvtBattleChange);
		case ListenEvtType.WhenMeEnterWeak:
			return typeof(EvtEnterWeak);
		case ListenEvtType.WhenMeCriticalDamage:
			return typeof(EvtCriticalDamage);
		case ListenEvtType.WhenMeTenacitiedRecoverMax:
			return typeof(EvtTenacitiedRecoverMax);
		case ListenEvtType.AfterMeTenacitiedDamaged:
			return typeof(EvtTenacitiedDamaged);
		case ListenEvtType.WhenMeAddAbility:
			return typeof(EvtAddAbilityAdd);
		case ListenEvtType.WhenMeAddAbilityBefore:
			return typeof(EvtAddAbilityBeforeAdd);
		case ListenEvtType.WhenMePostureDamaged:
			return typeof(EvtPostureDamage);
		case ListenEvtType.WhenSwitchSkill:
			return typeof(EvtSetSwitchPos);
		case ListenEvtType.WhenMePerfectDodge:
			return typeof(EvtPerfectDodge);
		case ListenEvtType.WhenMeULTRA:
			return typeof(EvtUltra);
		case ListenEvtType.WhenMeStateChange:
			return typeof(EvtStateChange);
		case ListenEvtType.WhenMeOpenBox:
			return typeof(EvtOpenBox);
		case ListenEvtType.WhenMeAddAbilityTo:
			return typeof(EvtAddAbilityAddTo);
		case ListenEvtType.WhenMeDynamicValueChange:
			return typeof(EvtDynamicValueChange);
		case ListenEvtType.WhenMeAirAttackCountChange:
			return typeof(EvtAirAttackCountChange);
		case ListenEvtType.WhenHitWall:
			return typeof(EvtHitWall);
		case ListenEvtType.AfterMeKillEntity:
		case ListenEvtType.AfterMeKillBullet:
			return typeof(EvtKillEntity);
		case ListenEvtType.OnDodge:
			return typeof(EvtDodge);
		case ListenEvtType.OnDummyCreate:
			return typeof(EvtDummyCreate);
		case ListenEvtType.OnBulletCreate:
			return typeof(EvtCreateBullet);
		case ListenEvtType.OnSkill:
			return typeof(EvtSkill);
		case ListenEvtType.OnLastCombo:
			return typeof(EvtLastCombo);
		case ListenEvtType.AfterSwitchSkill:
			return typeof(EvtAfterSwitchSkill);
		case ListenEvtType.OnAirDodge:
			return typeof(EvtAirDodge);
		case ListenEvtType.OnNormalAttack:
			return typeof(EvtNormalAttack);
		case ListenEvtType.OnSacrificeHp:
			return typeof(EvtSacrificeHp);
		case ListenEvtType.SummonMonster:
			return typeof(EvtSummonMonster);
		case ListenEvtType.SummonMonsterDie:
			return typeof(EvtSummonMonsterDie);
		case ListenEvtType.OnBulletDie:
			return typeof(EvtBulletDie);
		case ListenEvtType.BeforeSacrificeHp:
			return typeof(EvtBeforeSacrificeHp);
		case ListenEvtType.BeforeRemoveSummonMonster:
			return typeof(EvtBeforeRemoveSummonMonster);
		case ListenEvtType.WhenMeBreakPoint:
			return typeof(EvtBreakPoint);
		case ListenEvtType.WhenCheckRemain:
			return typeof(EvtSetCanRemain);
		case ListenEvtType.WhenTryAssist:
			return typeof(EvtTryAssist);
		case ListenEvtType.WhenNormalEnergyValueChange:
			return typeof(EvtModifyNormalEnergy);
		case ListenEvtType.WhenMotionChange:
			return typeof(EvtMotionChange);
		case ListenEvtType.WhenMeModifyTenacity:
			return null;
		case ListenEvtType.WhenSpawnProduct:
			return typeof(EvtOnSpawnProduct);
		case ListenEvtType.BackSwing:
			return typeof(EvtBackSwing);
		case ListenEvtType.RogueRoomEnter:
			return typeof(EvtRogueRoomEnter);
		case ListenEvtType.RogueRoomOver:
			return typeof(EvtRogueRoomOver);
		case ListenEvtType.RogueParamChanged:
			return typeof(EvtRogueParameterChange);
		case ListenEvtType.RogueTriggerParamChanged:
			return typeof(EvtRogueTriggerParameterChange);
		case ListenEvtType.TriggerAssistBack:
			return typeof(EvtTriggerAssistBack);
		case ListenEvtType.TriggerSwitchSkill:
			return typeof(EvtSwitchSKill);
		case ListenEvtType.EnterWeak:
			return typeof(EvtEnterWeak);
		case ListenEvtType.ExitWeak:
			return typeof(EvtExitWeak);
		case ListenEvtType.ParrySuccess:
			return typeof(EvtParrySuccess);
		case ListenEvtType.DeflectSuccess:
			return typeof(EvtDeflectSuccess);
		case ListenEvtType.BeforeModifyNormalEnergy:
			return typeof(EvtBeforeModifyNormalEnergy);
		case ListenEvtType.RegurgitateNormalEnergy:
			return typeof(EvtRegurgitateNormalEnergy);
		case ListenEvtType.BeforeModifyAssistValue:
			return typeof(EvtBeforeModifyAssistValue);
		case ListenEvtType.ModifyAssistValue:
			return typeof(EvtModifyAssistValue);
		case ListenEvtType.TriggerAssistBackChange:
			return typeof(EvtAssistBackChange);
		case ListenEvtType.BloodBottleRecverMax:
			return typeof(BloodBottleRecoverMax);
		case ListenEvtType.UseBloodBottle:
			return typeof(UseBloodBottle);
		case ListenEvtType.BeforeModifySpecialEnergy:
			return typeof(EvtBeforeModifySpecialEnergy);
		case ListenEvtType.WhenSpecialEnergyValueChange:
			return typeof(EvtModifySpecialEnergy);
		case ListenEvtType.WhenMeAccumulateDamageDone:
			return typeof(EvtAccumulateDamage);
		case ListenEvtType.TriggerAssistSkill:
			return typeof(EvtAssistSKill);
		case ListenEvtType.WhenHpChanged:
			return typeof(EvtHpChanged);
		case ListenEvtType.WhenWorldChanged:
			return typeof(EvtOnWorldChanged);
		case ListenEvtType.WhenEntityDie:
			return typeof(EvtEntityDie);
		case ListenEvtType.WhenUltraTimelineOver:
			return typeof(EvtUltraTimelineOver);
		case ListenEvtType.BpGlobalEvent:
			return typeof(EvtBpGlobal);
		case ListenEvtType.WhenAddRogueItem:
			return typeof(EvtAddRogueItem);
		case ListenEvtType.WhenRemoveRogueItem:
			return typeof(EvtRemoveRogueItem);
		case ListenEvtType.WhenComboCountChange:
			return typeof(EvtComboCountChange);
		case ListenEvtType.WhenCharacterVisible:
			return typeof(EvtCharacterVisible);
		default:
			throw new SwitchExpressionException(listenEvtType);
		}
	}
}
