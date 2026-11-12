using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._117;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "SupportSkill";

	private readonly string eventName_Shoot = "117_B1_Shoot";

	private readonly string bulletAlias = "Bullet_SupSkill_Thunder_Soldier";

	private readonly FP bulletDistance = 4;

	private readonly FP bulletPositionRandomRadius = 1;

	private readonly FP bulletPositionY = 1;

	public void OnStart()
	{
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_Shoot))
		{
			ILRuntimeAPI.Shoot(bulletAlias, _actor, default, _actor.tsTransform.Position, bulletPositionY, GetShootPosition(), null, AimType.Position);
		}
	}

	private TSVector2 GetShootPosition()
	{
		if (_actor.attackTarget != null)
		{
			return _actor.attackTarget.tsTransform.Position;
		}
		TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Forward.normalized * bulletDistance;
		return ILRuntimeAPI.GetRandomPointInShape(_actor, CommonUtils.GetDeterministicCircleShape(bulletPositionRandomRadius, 0, position), isReachable: false);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}
}
