using System.Collections;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class SkillBaseMaoYan : SkillSimpleBase
{
	protected enum E_TypeOfFire
	{
		Random,
		Tree,
		Triplet,
		Sweep
	}

	protected bool shootState;

	protected readonly string dodgeFxAlias = "fx_common_base_charge_fire_actor";

	protected readonly string ReloadAction = "Reload";

	protected readonly int ReloadIndex = 1;

	protected readonly string ShootAction = "HipFire";

	protected readonly int ShootIndex = 2;

	protected readonly string LFRDodge = "LFR_Dodge";

	protected readonly int LFRIndex = 3;

	protected readonly string FDodge = "F_Dodge";

	protected readonly int FIndex = 4;

	protected readonly string L2RShoot = "L2R_Shoot";

	protected readonly int L2RIndex = 5;

	protected readonly string R2LShoot = "R2L_Shoot";

	protected readonly int R2LIndex = 6;

	protected readonly string BarrageCombo = "Barrage";

	protected readonly int BarrageIndex = 7;

	protected readonly int rollIndex = 100;

	protected readonly int slideIndex = 101;

	protected LogicEntity GetTarget()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (!CheckTargetIsValid(logicEntity))
		{
			logicEntity = GetCurrentPlayer();
		}
		return logicEntity;
	}

	protected IEnumerator Reload()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		CancelAttack();
		AimAtTarget(currentPlayer, 450);
		BeginAttack(ReloadIndex, ReloadAction, flushInputedKeys: true, forceInterruptAttack: true);
		AlertMovement(GetPosition(), GetEntityPositionObsoleted(GetTarget()), TSVector2.zero, GetTarget());
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopMove();
		CancelAim();
	}

	protected void PlayEarlyWarning()
	{
		PlayEffect(dodgeFxAlias, 1f, 1.6, GetPosition(), default, 2.3f);
	}

	protected void AlertMovement(TSVector2 selfPos, TSVector2 playerPos, TSVector2 sceneCenter, LogicEntity target)
	{
		FP fP = 7;
		FP fP2 = Distance(selfPos, playerPos);
		FP fP3 = 9;
		int num = ((Distance(selfPos, sceneCenter) >= fP3) ? 1 : 2);
		if (num == 2)
		{
			num = ((!(fP2 <= fP)) ? 2 : 0);
		}
		TSVector2 zero = TSVector2.zero;
		switch (num)
		{
		case 0:
		{
			FP tSVectToAngle = 8;
			FP angle2 = 4;
			FP innerRadius = 30;
			FP radius = GetTSVectToAngle(selfPos - playerPos, 0);
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, selfPos, default, default, tSVectToAngle, angle2, innerRadius, radius);
			zero = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			break;
		}
		case 1:
			zero = TSVector2.zero;
			break;
		case 2:
		{
			FP angle = ((GetRandomValue(0, 1) >= 0.5) ? (-30) : 30);
			FP radius = 8;
			FP innerRadius = 4;
			FP angle2 = 30;
			FP tSVectToAngle = GetTSVectToAngle(sceneCenter - selfPos, angle);
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, selfPos, default, default, radius, innerRadius, angle2, tSVectToAngle);
			zero = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			break;
		}
		default:
			zero = TSVector2.zero;
			break;
		}
		MoveToPosition(zero, 0.5, AdventureActor.MovementMode.Walk, 3, _stopDisIgnoreRadius: false);
	}

	protected IEnumerator Roll(TSVector2 targetPOS, bool playEarlyWarning)
	{
		LogicEntity target = GetTarget();
		TSVector2 selfPOS = GetPosition();
		FP relativeDIST = Distance(selfPOS, targetPOS);
		FP dashSpeed = relativeDIST / 0.4;
		BeginAttack(FIndex, FDodge, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginLookAt_NotWait(target, 0.1, 1800);
		BeginDash(rollIndex, targetPOS - selfPOS, dashSpeed, relativeDIST, 0, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.3);
		yield return WaitDashFinish();
		if (playEarlyWarning)
		{
			PlayEarlyWarning();
		}
	}

	protected IEnumerator Slide(TSVector2 targetPOS, bool playEarlyWarning)
	{
		LogicEntity target = GetTarget();
		TSVector2 position = GetPosition();
		FP fP = Distance(position, targetPOS);
		FP speed = fP / 0.3;
		BeginAttack(LFRIndex, LFRDodge, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAtByPos_NotWait(targetPOS, 0.1, 1800);
		BeginDash(slideIndex, targetPOS - position, speed, fP, 0, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.3);
		yield return WaitTime(0.1);
		CancelAttack();
		yield return WaitDashFinish();
		if (playEarlyWarning)
		{
			PlayEarlyWarning();
		}
		yield return BeginLookAt(target, 0.1, 1800);
	}

	protected CoroutineNode HipFire(int magazineCapacity, E_TypeOfFire EtypeOfFire)
	{
		SetLogicTagFpValue(_actor, "MagazineCapacity", magazineCapacity);
		return EtypeOfFire switch
		{
			E_TypeOfFire.Random => StartCor(TypeRandom()), 
			E_TypeOfFire.Tree => StartCor(TypeTree()), 
			E_TypeOfFire.Triplet => StartCor(TypeRandom()), 
			E_TypeOfFire.Sweep => StartCor(TpyeSweep()), 
			_ => StartCor(TypeRandom()), 
		};
	}

	protected void HipFire(int magazineCapacity, E_TypeOfFire EtypeOfFire, out IEnumerator HipFireCoroutine)
	{
		SetLogicTagFpValue(_actor, "MagazineCapacity", magazineCapacity);
		switch (EtypeOfFire)
		{
		case E_TypeOfFire.Random:
			HipFireCoroutine = TypeRandom();
			break;
		case E_TypeOfFire.Tree:
			HipFireCoroutine = TypeTree();
			break;
		case E_TypeOfFire.Triplet:
			HipFireCoroutine = TypeRandom();
			break;
		case E_TypeOfFire.Sweep:
			HipFireCoroutine = TpyeSweep();
			break;
		default:
			HipFireCoroutine = TypeRandom();
			break;
		}
	}

	private IEnumerator TypeRandom()
	{
		shootState = true;
		int magazineCapacity = (int)(long)GetLogicTagFpValue(_actor, "MagazineCapacity");
		for (int i = 0; i < 3; i++)
		{
			for (int j = 0; j < magazineCapacity; j++)
			{
				PlayEffect("fx_70021_base_Fire", 1f, default, default, default, 1.5f);
				TSVector2 shootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1.5));
				FanMultipleShoot("Bullet_Fire_Strike_COM", AdventureWeapon.MultipleShootStyle.RandomDirection, alignShoot: false, 0, 1, 0, shootPosition, 2, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, 30, 0, 0);
				yield return WaitTime(0.05);
			}
			yield return WaitTime(0.3);
		}
		shootState = false;
	}

	private IEnumerator TypeTree()
	{
		shootState = true;
		CoroutineNode diffusionShootCor = null;
		int magazineCapacity = (int)(long)GetLogicTagFpValue(_actor, "MagazineCapacity");
		for (int i = 0; i < magazineCapacity; i++)
		{
			TSVector2 shootPos = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0.1, 1.5));
			TSVector2 forward = GetForward();
			Shooting(shootPos, forward);
			if (i == 1)
			{
				diffusionShootCor = StartCor(DiffusionShoot());
			}
			yield return WaitTime(0.1);
		}
		StopCor(diffusionShootCor);
		shootState = false;
	}

	private IEnumerator DiffusionShoot()
	{
		shootState = true;
		FP diffusionAngle = 10;
		for (int i = 0; i < 4; i++)
		{
			TSVector2 forward = GetForward();
			TSVector2 shootPos = TransLocalPosToWorldPos(GetPosition(), forward, new TSVector2(0, 1.5));
			TSVector2 direction = RotateTo(forward, -diffusionAngle);
			Shooting(shootPos, direction);
			TSVector2 direction2 = RotateTo(forward, diffusionAngle);
			Shooting(shootPos, direction2);
			yield return WaitTime(0.3);
			diffusionAngle += (FP)5;
		}
		shootState = false;
	}

	private IEnumerator TpyeSweep()
	{
		shootState = true;
		bool StrafingDirection = GetLogicTagToggleValue(_actor, "SweepDirection");
		FP deflectingDirection = (StrafingDirection ? 45 : (-45));
		for (int m = 0; m < 10; m++)
		{
			TSVector2 position = GetPosition();
			TSVector2 forward = GetForward();
			TSVector2 tSVector = ((!StrafingDirection) ? RotateTo(forward, deflectingDirection + 10.5 * (double)m) : RotateTo(forward, deflectingDirection - 10.5 * (double)m));
			TSVector2 shootPos = TransLocalPosToWorldPos(position, tSVector, new TSVector2(0, 1.3));
			Shooting(shootPos, tSVector);
			yield return WaitTime(0.07);
		}
		shootState = false;
	}

	private void Shooting(TSVector2 shootPos, TSVector2 direction)
	{
		shootState = true;
		FanMultipleShoot("Bullet_Fire_Strike_COM", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, shootPos, 2, direction, 0, AimType.Default, BulletDirectionType.ActorToBullet, 0, 0, 0);
		PlayEffect("fx_70021_base_Fire", 1f, default, default, default, 1f, actorScale: true);
		shootState = false;
	}
}
