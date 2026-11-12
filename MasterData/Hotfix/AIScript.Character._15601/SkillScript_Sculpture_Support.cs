using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15601;

public class SkillScript_Sculpture_Support : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt();
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill_Sup_PenguinStatueCalling", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "PenguinStatueCalling"))
		{
			TSVector2 result = _actor.tsTransform.Position + _actor.tsTransform.Forward * Config_Support.distance_TargetPosition_Sculpture;
			if (_actor.attackTarget != null)
			{
				result = _actor.attackTarget.tsTransform.Position;
				result += (_actor.attackTarget.GetRadius() + Config_Support.offsetDistance_TargetPosition_Sculpture) * (_actor.tsTransform.Position - result).normalized;
			}
			if (!_actor.QueryPositionWalkable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Forward * Config_Support.shootOffset_Sculpture;
			ILRuntimeAPI.Shoot("Bullet_156_Sup_Skill_PenguinStatueCalling_Fly", _actor, default, position, Config_Support.shootPositionY_Sculpture, result, null, AimType.Position, BulletDirectionType.BulletToTarget);
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
