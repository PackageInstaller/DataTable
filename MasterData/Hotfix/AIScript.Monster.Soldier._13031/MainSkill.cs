using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._13031;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "Skill";

	private const string fireEvent = "Fire";

	private const string bulletPath = "Bullet_Skill";

	private static readonly TSVector2 bulletFireOffset = new TSVector2(0.11, 0.65);

	private static readonly FP bulletHeight = 1.6;

	private static readonly FP bulletRange = 10;

	private static readonly FP loopTime = 1;

	private const int buffId_cast_2 = 250102801;

	private const int buffId_cast_3 = 250102802;

	private CoroutineNode corMain;

	private int _potentialLv = 1;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		if (_potentialLv >= 3)
		{
			_actor.buffComponent.AddBuff(250102802, _actor);
		}
		else if (_potentialLv >= 2)
		{
			_actor.buffComponent.AddBuff(250102801, _actor);
		}
		StartCoroutine(ref corMain, DoMainLogic());
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private IEnumerator DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		MainSkill mainSkill = this;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		mainSkill.BeginAttack("Skill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		yield return _actor.WaitTime(loopTime);
		_actor.CancelAttack();
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("Fire"))
		{
			ShootBullet();
		}
	}

	private void ShootBullet()
	{
		TSVector2 position = _actor.tsTransform.TransformLocalPointToWorldSpace(bulletFireOffset);
		if (_actor.attackTarget != null && !_actor.attackTarget.IsDead())
		{
			AdventureActor actor = _actor;
			FP range = 0;
			FP positionY = bulletHeight;
			LogicEntity attackTarget = _actor.attackTarget;
			ILRuntimeAPI.Shoot("Bullet_Skill", actor, range, position, positionY, default, attackTarget, AimType.Target, BulletDirectionType.BulletToTarget);
		}
		else
		{
			ILRuntimeAPI.ShootByDirection("Bullet_Skill", _actor, bulletRange, _actor.tsTransform.Forward, position, bulletHeight);
		}
	}
}
