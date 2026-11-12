#define LOG_DEBUG
using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11701;

public class SkillScript_B2_Skill : SkillAdvancedBase
{
	private const string _customEventName = "_Skill";

	private readonly FP bulletDistance = 4;

	private readonly FP bulletPositionRamdomRadius = 1;

	private readonly string bulletAlias = "Bullet_11701_B2_Skill_Thunder_AoE";

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1634882679,
		(ComboInputBuffer.ActionKey)1766023024,
		(ComboInputBuffer.ActionKey)1663990132
	};

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("11701 Skill_2 OnDisable");
		base.OnSkillDisable();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("11701 Skill_2 OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("11701 Skill_2 OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
			ComboInputBuffer.ActionKey[] actionKeys = _actionKeys;
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			Action<string> onCustomEvent = OnCustomEvent;
			BeginAttack(actionKeys, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (eventName.Equals("_Skill"))
		{
			Shoot(bulletAlias);
		}
		else
		{
			NovaLogger.Debug("no match custom event name: " + eventName);
		}
	}

	protected void Shoot(string bulletAlias)
	{
		if (!string.IsNullOrEmpty(bulletAlias))
		{
			ILRuntimeAPI.Shoot(bulletAlias, _actor, default, _actor.tsTransform.Position, 1, GetShootPosition(), null, AimType.Position);
		}
	}

	private TSVector2 GetShootPosition()
	{
		TSVector2 zero = TSVector2.zero;
		if (_actor.aimLockedTarget == null)
		{
			zero = _actor.tsTransform.Position + _actor.tsTransform.Forward.normalized * bulletDistance;
			return ILRuntimeAPI.GetRandomPointInShape(_actor, CommonUtils.GetDeterministicCircleShape(bulletPositionRamdomRadius, 0, zero), isReachable: false);
		}
		return _actor.aimLockedTarget.tsTransform.Position;
	}

	private void OnFinish()
	{
		NovaLogger.Debug("11701 Skill_2 onFinish");
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		NovaLogger.Debug("11701 Skill_2 onInterrupt");
		_skill.Clear();
	}
}
