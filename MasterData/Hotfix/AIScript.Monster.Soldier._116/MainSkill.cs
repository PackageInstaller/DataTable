using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._116;

public class MainSkill : SkillAdvancedBase
{
	private readonly string comboTag = "MainSkill";

	private readonly string eventName_Shoot = "Fire";

	private readonly string bulletKey = "Bullet_Soldier_11601_MainSkill";

	private readonly TSVector2 shootOffset = new TSVector2(0, 0);

	private readonly FP shootPositionY = 1;

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
		}
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
			ShootBullet();
		}
	}

	private void ShootBullet()
	{
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
		}
		LockDirection();
		TSVector2 tSVector = _actor.tsTransform.Position + _actor.tsTransform.Left * shootOffset.x + _actor.tsTransform.Forward * shootOffset.y;
		LogicEntity attackTarget = _actor.attackTarget;
		TSVector2 shootDir = ((attackTarget != null) ? (attackTarget.tsTransform.Position - tSVector).normalized : _actor.tsTransform.Forward.normalized);
		ILRuntimeAPI.ShootByDirection(bulletKey, _actor, default, shootDir, tSVector, shootPositionY);
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
