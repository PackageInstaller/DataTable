#define LOG_DEBUG
using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11701;

public class SkillScript_B1_Skill : SkillAdvancedBase
{
	private const string _customEventName = "_Skill";

	private readonly string _areaEffectAlias = "AreaEffect_117_B1_Skill_ElectricCircle";

	private readonly FP _areaEffectDistance = 3;

	private readonly FP _areaEffectRadius = 4;

	private readonly string _actionTag = "Skill_B1";

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("11701 Skill OnDisable");
		base.OnSkillDisable();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("11701 Skill OnEnable");
		base.OnSkillEnable();
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
		if (eventName == "_Skill")
		{
			CustomAction(_areaEffectAlias, _areaEffectDistance, _areaEffectRadius, "");
		}
	}

	protected virtual void CustomAction(string areaEffectAlias, FP distance, FP areaEffectRadius, string bulletAlias)
	{
		TSVector2 shootPosition = GetShootPosition(distance, areaEffectRadius);
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectAlias, shootPosition);
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
}
