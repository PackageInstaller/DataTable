using System.Collections;
using TrueSync;

namespace AIScript.Monster._30921JuJiShou;

public class Skill02_FlashBomb : SkillSimpleBase
{
	private readonly string FlashBomb = "FlashBomb";

	private readonly FP JumpSpeed = 10;

	private readonly FP MoveSpeed = 8;

	private LogicEntity Targetenemy;

	private DeterministicShape MoveShape;

	private TSVector2 MovePoint;

	private long HideEffect;

	protected override void OnSkillDisable()
	{
		StopLookAt();
		SetLogicTagToggleValue(_actor, "FlashBombEnd", value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginAttack(1, FlashBomb, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(Targetenemy, 2, 360);
		yield return WaitCustomEvent("Fire");
		GetEnemy();
		Shoot1();
		yield return WaitCustomEvent("StopLookAt");
		StopLookAt();
		JumpBack();
		yield return WaitCustomEvent("Hide");
		HideEffect = PlayEffect("fx_m30921_loop_FlashBomb_Hide");
		SetUnparalleledEnable();
		if (GetTargetsByFaction(isFriend: true).Count >= 3)
		{
			yield return WaitCustomEvent("StartMove");
			GetEnemy();
			Skill02_FlashBomb skill02_FlashBomb = this;
			Skill02_FlashBomb skill02_FlashBomb2 = this;
			TSVector2 entityPosition = GetEntityPosition(Targetenemy);
			FP radius = 25;
			FP innerRadius = 13;
			skill02_FlashBomb.MoveShape = skill02_FlashBomb2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
			MovePoint = GetShapeRandomPoint(MoveShape, _actor, isReachable: true);
			MoveToNewPos();
			yield return WaitDashFinish();
		}
		else
		{
			yield return WaitCustomEvent("End");
		}
		CancelAttack();
		SetUnparalleledDisable();
		ReplaceAnimationGroup();
		StopEffect(HideEffect);
		BeginLookAt_NotWait(Targetenemy, 2, 360);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}

	private void Shoot1()
	{
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 1));
		FP positionY = 1;
		FP range = 3;
		LogicEntity targetenemy = Targetenemy;
		Shoot("Bullet_FlashBomb", position, positionY, range, default, AimType.Target, BulletDirectionType.ActorToBullet, default, targetenemy);
	}

	private void JumpBack()
	{
		BeginDash(1, RotateTo(GetForward(), 180), JumpSpeed, JumpSpeed * 0.59, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}

	private void MoveToNewPos()
	{
		BeginDash(2, MovePoint - GetPosition(), MoveSpeed, Distance(GetPosition(), MovePoint), 0, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
	}
}
