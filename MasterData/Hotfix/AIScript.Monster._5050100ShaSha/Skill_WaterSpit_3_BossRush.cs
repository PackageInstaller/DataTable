#define LOG_DEBUG
#define LOG_ERROR
using System.Collections;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class Skill_WaterSpit_3_BossRush : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] _actionKey_Water = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	protected readonly ComboInputBuffer.ActionKey[] _actionKey_Dark = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.W };

	private static readonly string Jumpto = "Jumpto";

	protected readonly string eventShoot = "Shoot";

	protected readonly string bulletPath_Water = "Weapon_50501ShaSha_Water_Throw_Lv3_BossRush";

	protected readonly string bulletPath_Dark = "Weapon_50501ShaSha_Dark_Throw_Lv3";

	protected FP bulletYPos = 4;

	protected TSVector2 bulletOffset = new TSVector2(0, 5);

	protected TSVector2 NonePlayerOffset = new TSVector2(0, 8);

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected string _bulletPath;

	protected int _buttleCount;

	protected FP dis;

	protected override void OnSkillEnable()
	{
		UpdateData();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		SetCloseBlockDisable();
	}

	protected void UpdateData()
	{
		if (_actor.buffComponent.CheckBuffByBuffID(505010110))
		{
			_actionKey = _actionKey_Dark;
			_bulletPath = bulletPath_Dark;
		}
		else
		{
			_actionKey = _actionKey_Water;
			_bulletPath = bulletPath_Water;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = _actor.actorSearchTargetInfo?.GetMonsterAttackTarget();
		BeginLookAt_NotWait(target, 0.4, 200);
		yield return WaitTime(0.2);
		if (_actor.DistanceWithRadius(target) < 6)
		{
			TSVector2 entityPosition = GetEntityPosition(target);
			Skill_WaterSpit_3_BossRush skill_WaterSpit_3_BossRush = this;
			Skill_WaterSpit_3_BossRush skill_WaterSpit_3_BossRush2 = this;
			TSVector2 position = entityPosition;
			FP radius = 12;
			FP innerRadius = 9;
			TSVector2 shapeRandomPoint = skill_WaterSpit_3_BossRush.GetShapeRandomPoint(skill_WaterSpit_3_BossRush2.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius), _actor, isReachable: true);
			NovaLogger.Debug($"目标点坐标: ({shapeRandomPoint.x}, {shapeRandomPoint.y})");
			NovaLogger.Debug($"玩家坐标: ({entityPosition.x}, {entityPosition.y})");
			BeginLookAtByPos(shapeRandomPoint, 2, 300);
			BeginAttack(1, Jumpto, flushInputedKeys: true, forceInterruptAttack: true);
			SetCloseBlockEnable();
			FP fP = Distance(GetPosition(), shapeRandomPoint);
			dis = fP + 3f;
			FP dash_spd = dis / 0.8;
			yield return WaitTime(0.1);
			doDash(dis, dash_spd);
			yield return WaitTime(1.1);
			CancelAttack();
			SetCloseBlockDisable();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		BeginLookAt_NotWait(target, 0.5, 300);
		yield return WaitTime(0.5);
		BeginAttack(2, _actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(eventShoot);
		AimAtTarget(target, 80);
		while (_buttleCount < 2)
		{
			Shoot1();
			_buttleCount++;
			yield return WaitCustomEvent(eventShoot);
		}
		Shoot1();
		CancelAim();
		yield return WaitCustomEvent("ShootEnd");
		CancelAttack();
		_buttleCount = 0;
		yield return WaitTime(0.5);
	}

	private void Shoot1()
	{
		LogicEntity attackTarget = GetAttackTarget();
		if (attackTarget == null)
		{
			NovaLogger.Error("Attack target is null in Shoot1");
			return;
		}
		TSVector2 entityPosition = GetEntityPosition(attackTarget);
		TSVector2 shootPosition = GetPosition() + TSVector2.Rotate(bulletOffset, _actor.tsTransform.Rotation);
		TSVector2 entityForward = GetEntityForward(_actor);
		FanMultipleShoot(_bulletPath, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, shootPosition, 4, entityForward, 60, AimType.Position, BulletDirectionType.ActorToBullet, 30, 5, 0, entityPosition);
	}

	private bool CheckPlay()
	{
		LogicEntity attackTarget = GetAttackTarget();
		FP fP = CalcAngleBetweenSelfAndAttackTarget();
		if (_actor.DistanceWithRadius(attackTarget) <= 12 && fP <= 80)
		{
			return true;
		}
		return false;
	}

	private void doDash(FP dis, FP dash_spd)
	{
		BeginDashActorForward(1, dash_spd, dis, 40, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	protected void OnFinish()
	{
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}
}
