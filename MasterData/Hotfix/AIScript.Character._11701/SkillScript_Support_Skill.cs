#define LOG_DEBUG
#define LOG_ERROR
using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11701;

public class SkillScript_Support_Skill : SkillAdvancedBase
{
	private const string _customEventName = "117_B2_Area";

	private Dictionary<int, string> areaEffectAliaDic = new Dictionary<int, string>
	{
		[0] = "AreaEffect_117_B2_Skill_ElectricCircle",
		[21] = "AreaEffect_117_B2P21_Skill_ElectricCircle_Large",
		[22] = "AreaEffect_117_B2P22_Skill_ElectricCircle_Quick",
		[23] = "AreaEffect_117_B2P23_Skill_ElectricCircle_Stun",
		[43] = "AreaEffect_117_B2P21P22_Skill_ElectricCircle_LargeQuick",
		[44] = "AreaEffect_117_B2P21P23_Skill_ElectricCircle_LargeStun",
		[45] = "AreaEffect_117_B2P22P23_Skill_ElectricCircle_QuickStun"
	};

	private readonly string _areaEffectAlias_24 = "AreaEffect_117_B2P24_Skill_ElectricCircle_Boom";

	private readonly string _areaEffectAlias_2124 = "AreaEffect_117_B2P21P24_Skill_ElectricCircle_LargeBoom";

	private readonly FP _areaEffectDistance = 3;

	private readonly FP _areaEffectRadius = 4;

	private readonly string _actionTag = "Skill_B2";

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("11701 Skill OnDisable");
		base.OnSkillDisable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("11701 Skill OnEnable");
		base.OnSkillEnable();
		if (GetPerk(511728))
		{
			(_actor as PlayerAdventureActor).playerSkillCd.ModifyResumeTimeAbs(-CommonUtils.GetScriptValue(_actor, 11728011), ActionKey.B);
		}
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	public void OnStart()
	{
		NovaLogger.Debug("11701 Skill OnStart");
		Attack();
	}

	private void Attack()
	{
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
			_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
			string actionTag = _actionTag;
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			Action<string> onCustomEvent = OnCustomEvent;
			BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		}
	}

	private void OnCustomEvent(string eventName)
	{
		NovaLogger.Debug("11701 Skill OnCustomEvent" + eventName);
		if (eventName == "117_B2_Area")
		{
			CustomAction(_areaEffectDistance, _areaEffectRadius, "");
		}
	}

	protected virtual void CustomAction(FP distance, FP areaEffectRadius, string bulletAlias)
	{
		string text = "";
		int num = 0;
		bool flag = false;
		if (GetPerk(511721))
		{
			flag = true;
			num += 21;
		}
		if (GetPerk(511722))
		{
			num += 22;
		}
		if (GetPerk(511723))
		{
			num += 23;
		}
		if (areaEffectAliaDic.ContainsKey(num))
		{
			text = areaEffectAliaDic.get_Item(num);
		}
		if (string.IsNullOrEmpty(text))
		{
			NovaLogger.Error("areaEffectAlias is null!!!!");
			return;
		}
		TSVector2 shootPosition = GetShootPosition(distance, areaEffectRadius);
		long num2 = ILRuntimeAPI.PlayAreaEffect(_actor, text, shootPosition);
		bool perk = GetPerk(511727);
		if (GetPerk(511726))
		{
			ILRuntimeAPI.AddAreaEffectLeftTime(num2, CommonUtils.GetScriptValue(_actor, 11726011));
		}
		if (perk)
		{
			Parallel.dicArea_p27.Add(num2, _actor.LogicTime);
		}
		if (GetPerk(511724))
		{
			num2 = ILRuntimeAPI.PlayAreaEffect(fxAlias: (!flag) ? _areaEffectAlias_24 : _areaEffectAlias_2124, actor: _actor, position: shootPosition);
			if (GetPerk(511726))
			{
				ILRuntimeAPI.AddAreaEffectLeftTime(num2, CommonUtils.GetScriptValue(_actor, 11726011));
			}
			if (perk)
			{
				Parallel.dicArea_p27.Add(num2, _actor.LogicTime);
			}
		}
		if (!string.IsNullOrEmpty(bulletAlias))
		{
			ILRuntimeAPI.Shoot(bulletAlias, _actor, 3, _actor.tsTransform.Position, 1, shootPosition, null, AimType.Position);
		}
	}

	protected TSVector2 GetShootPosition(FP bulletDistance, FP areaEffectRadius)
	{
		TSVector2 zero = TSVector2.zero;
		if (_actor.aimLockedTarget == null)
		{
			return _actor.tsTransform.Position + _actor.tsTransform.Forward.normalized * bulletDistance;
		}
		return (_actor.tsTransform.Position - _actor.aimLockedTarget.tsTransform.Position).normalized * (_actor.dtCollider.Radius + areaEffectRadius / 10000) + _actor.aimLockedTarget.tsTransform.Position;
	}

	private void OnFinish()
	{
		NovaLogger.Debug("11701 Skill onFinish");
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		NovaLogger.Debug("11701 Skill onInterrupt");
		_skill.Clear();
	}

	public void OnUpdate()
	{
		LockDirection();
	}
}
