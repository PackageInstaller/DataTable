#define LOG_DEBUG
using System;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._11801;

public class SkillScript_MainControl : SkillAdvancedBase
{
	private static readonly string actionTag = "Skill_Main_LuanZhan";

	private static readonly int loopCount = 2;

	private static readonly string lightAttackEventName = "Skill_Main_LightAttack";

	private static readonly int lightAttackHitDamageId = 118000015;

	private static readonly FP lightAttackRadius = 3.5f;

	private static readonly TSVector2 lightAttackPosOffset = new TSVector2(0, 0f);

	private static readonly string lightAttackEffectAlias = "fx_11801_base_Skill_Main_LuanZhan_loop_03";

	private static readonly string heavyAttackEventName = "Skill_Main_HeavyAttack";

	private static readonly int heavyAttackHitDamageId = 118000016;

	private static readonly FP heavyAttackRadius = 3.5f;

	private static readonly TSVector2 heavyAttackPosOffset = new TSVector2(0, 0f);

	private static readonly string heavyAttackEffectAlias_1 = "fx_11801_base_Skill_Main_LuanZhan_end_03";

	private static readonly string heavyAttackEffectAlias_2 = "fx_11801_base_Skill_Main_LuanZhan_end_04";

	private static readonly string hittedEffectAlias = "fx_11801_base_hit_01";

	private static readonly FP _stiffDuration = 0.7f;

	private static readonly FP _airBorneForce = 15f;

	private static readonly FP _hitStrength = 4f;

	private static readonly int perkId_1 = 511801;

	private static readonly int loopCount_add = 2;

	private static readonly int perkId_2 = 511802;

	private static readonly int maxAttackLevel = 3;

	private static readonly float lightAttackEffectScale_level1 = 1.14f;

	private static readonly FP lightAttackRadius_level1 = 4f;

	private static readonly TSVector2 lightAttackPosOffset_level1 = new TSVector2(0, 0f);

	private static readonly float lightAttackEffectScale_level2 = 1.42f;

	private static readonly FP lightAttackRadius_level2 = 5f;

	private static readonly TSVector2 lightAttackPosOffset_level2 = new TSVector2(0, 0f);

	private static readonly float lightAttackEffectScale_level3 = 1.71f;

	private static readonly FP lightAttackRadius_level3 = 6f;

	private static readonly TSVector2 lightAttackPosOffset_level3 = new TSVector2(0, 0f);

	private static readonly float heavyAttackEffectScale_level1 = 1.14f;

	private static readonly FP heavyAttackRadius_level1 = 4f;

	private static readonly TSVector2 heavyAttackPosOffset_level1 = new TSVector2(0, 0f);

	private static readonly float heavyAttackEffectScale_level2 = 1.42f;

	private static readonly FP heavyAttackRadius_level2 = 5f;

	private static readonly TSVector2 heavyAttackPosOffset_level2 = new TSVector2(0, 0f);

	private static readonly float heavyAttackEffectScale_level3 = 1.71f;

	private static readonly FP heavyAttackRadius_level3 = 6f;

	private static readonly TSVector2 heavyAttackPosOffset_level3 = new TSVector2(0, 0f);

	private readonly int perkId_5 = 511805;

	private static readonly int buffId_Base_1 = 11890002;

	private int _currentLoopCount;

	private int _totalLoopCount;

	private int _attackCount;

	private PlayFX _playFX;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("11801 Skill OnDisable");
		base.OnSkillDisable();
		if (!ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_5, out var _))
		{
			_actor.buffComponent.RemoveBuffByBuffId(buffId_Base_1);
		}
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("11801 Skill OnEnable");
		base.OnSkillEnable();
		_attackCount = 0;
		_currentLoopCount = 0;
		_totalLoopCount = loopCount;
		_actor.logicVariable.SetLogicTagValue("skill_mainControl_attackCount", _attackCount);
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_1, out var perkLevel))
		{
			_totalLoopCount = loopCount + loopCount_add;
		}
		if (!ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_5, out perkLevel))
		{
			_actor.buffComponent.AddBuff(buffId_Base_1, _actor);
		}
	}

	public void OnStart()
	{
		NovaLogger.Debug("11801 Skill OnStart");
		string text = actionTag;
		System.Action onComboLoop = OnComboLoop;
		Action<string> onCustomEvent = OnCustom;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(text, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnComboLoop()
	{
		_currentLoopCount++;
		if (_currentLoopCount >= _totalLoopCount)
		{
			comboAttack.CancelAttack();
		}
	}

	private void OnCustom(string eventName)
	{
		int num = 0;
		FP zero = FP.Zero;
		TSVector2 position = _actor.tsTransform.Position;
		string fxAlias = "";
		string text = "";
		float fxScale = 1f;
		HitBox.FeatureFlag hitFlags = HitBox.FeatureFlag.None;
		HitBox.HitBoxFeatureData hitBoxFeatureData = new HitBox.HitBoxFeatureData
		{
			hitStrenth = _hitStrength
		};
		if (eventName.Equals(lightAttackEventName))
		{
			num = lightAttackHitDamageId;
			zero = lightAttackRadius;
			position += lightAttackPosOffset;
			fxAlias = lightAttackEffectAlias;
			hitFlags = HitBox.FeatureFlag.Stiff;
			hitBoxFeatureData.StiffDuration = _stiffDuration;
		}
		else if (eventName.Equals(heavyAttackEventName))
		{
			num = heavyAttackHitDamageId;
			zero = heavyAttackRadius;
			position += heavyAttackPosOffset;
			fxAlias = heavyAttackEffectAlias_1;
			text = heavyAttackEffectAlias_2;
			hitFlags = HitBox.FeatureFlag.AirBorne;
			hitBoxFeatureData.KnockOutForce = _airBorneForce;
		}
		if (num == 0)
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_2, out var _))
		{
			_attackCount = Mathf.Clamp(_attackCount, 0, maxAttackLevel);
			switch (_attackCount)
			{
			case 1:
				if (eventName.Equals(lightAttackEventName))
				{
					zero = lightAttackRadius_level1;
					position += lightAttackPosOffset_level1;
					fxScale = lightAttackEffectScale_level1;
				}
				else
				{
					zero = heavyAttackRadius_level1;
					position += heavyAttackPosOffset_level1;
					fxScale = heavyAttackEffectScale_level1;
				}
				break;
			case 2:
				if (eventName.Equals(lightAttackEventName))
				{
					zero = lightAttackRadius_level2;
					position += lightAttackPosOffset_level2;
					fxScale = lightAttackEffectScale_level2;
				}
				else
				{
					zero = heavyAttackRadius_level2;
					position += heavyAttackPosOffset_level2;
					fxScale = heavyAttackEffectScale_level2;
				}
				break;
			case 3:
				if (eventName.Equals(lightAttackEventName))
				{
					zero = lightAttackRadius_level3;
					position += lightAttackPosOffset_level3;
					fxScale = lightAttackEffectScale_level3;
				}
				else
				{
					zero = heavyAttackRadius_level3;
					position += heavyAttackPosOffset_level3;
					fxScale = heavyAttackEffectScale_level3;
				}
				break;
			}
			_actor.logicVariable.SetLogicTagValue("skill_mainControl_attackCount", _attackCount);
			_attackCount++;
		}
		CommomAreaHitConfig commonAreaHitConfig = new CommomAreaHitConfig
		{
			fxAlias = fxAlias,
			hitDamageId = num,
			hitFlags = hitFlags,
			hitFeatureData = hitBoxFeatureData,
			position = position,
			fxScale = fxScale,
			hittedEffectAlias = hittedEffectAlias
		};
		if (!string.IsNullOrEmpty(text))
		{
			if (_playFX == null)
			{
				_playFX = new PlayFX();
			}
			_playFX.Play(_actor, null, text, _actor.tsTransform.PositionY, position, _actor.tsTransform.Forward, null, 1f, fxScale);
		}
		ILRuntimeAPI.CircleAreaHit(_actor, commonAreaHitConfig, zero, 0);
	}

	private void OnFinish()
	{
		NovaLogger.Debug("11801 Skill onFinish");
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		NovaLogger.Debug("11801 Skill onInterrupt");
		OnFinish();
	}
}
