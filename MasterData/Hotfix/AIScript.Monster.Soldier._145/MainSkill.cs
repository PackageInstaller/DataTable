using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._145;

public class MainSkill : SkillAdvancedBase
{
	private const string comboTag_Move = "MainSkill_Move";

	private const string comboTag_Shoot = "MainSkill_Shoot";

	private const string eventName_Shoot = "Shot";

	private const string bulletKey = "Bullet_Soldier_145_MainSkill";

	private const string bulletKey_Potential3 = "Bullet_Soldier_145_MainSkill_N";

	private static readonly TSVector2 shootOffset = new TSVector2(0, 0);

	private static readonly FP shootPositionY = 1;

	private static readonly FP fallbackRange = 10;

	public const int buffId_Trigger = 250105301;

	private int _potentialLv;

	private bool _didCast;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		_didCast = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (_potentialLv >= 2 && !(_actor == null) && !_actor.IsDead())
		{
			_actor.buffComponent?.AddBuff(250105301, _actor);
		}
	}

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).FindNearestConfrontTarget();
		}
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("MainSkill_Shoot", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnRecoveryBegin()
	{
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("MainSkill_Shoot", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
		if (!_didCast)
		{
			_didCast = true;
			Action_Summoned.TryPartnerSummon(_actor);
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

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Shot"))
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
		string bulletAlias = ((_potentialLv >= 3) ? "Bullet_Soldier_145_MainSkill_N" : "Bullet_Soldier_145_MainSkill");
		LogicEntity attackTarget = _actor.attackTarget;
		ILRuntimeAPI.Shoot(targetPosition: (attackTarget != null && !attackTarget.IsDead()) ? attackTarget.tsTransform.Position : (tSVector + _actor.tsTransform.Forward.normalized * fallbackRange), bulletAlias: bulletAlias, actor: _actor, range: 0, position: tSVector, positionY: shootPositionY, target: null, aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget);
	}
}
