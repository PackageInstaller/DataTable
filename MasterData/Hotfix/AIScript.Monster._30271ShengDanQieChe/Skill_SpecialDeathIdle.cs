using System.Collections;
using TrueSync;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill_SpecialDeathIdle : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Run = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private TSVector2 QieCheEscape1;

	private TSVector2 QieCheEscape2;

	private TSVector2 QieCheEscape3;

	private long Emoji;

	private long BoxFx;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		QieCheEscape1 = GetPlaceHolderPosition("QieCheEscape1");
		QieCheEscape2 = GetPlaceHolderPosition("QieCheEscape2");
		QieCheEscape3 = GetPlaceHolderPosition("QieCheEscape3");
		SetUnparalleledEnable();
		SetSearchedImmunityEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopEffect(Emoji);
		StopEffect(BoxFx);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Run, flushInputedKeys: true, forceInterruptAttack: true);
		Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_Dizzy");
		Dash01();
		SetCloseBlockEnable();
		yield return WaitDashFinish();
		StopEffect(Emoji);
		if (_actor.actorHealthInfo.hp == 0L)
		{
			BoxFx = PlayEffect("fx_m30271_loop_ThrowBoxLv2_2");
			yield return WaitTime(0.5);
			Shoot01();
			yield return WaitTime(1.5);
			PlayEffect("fx_m30271_base_ThrowBoxLv2_end_2");
			StopEffect(BoxFx);
			yield return WaitTime(0.5);
		}
		Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_Escape");
		BeginLookAtByPos_NotWait(QieCheEscape2, 0.5, 360);
		yield return WaitTime(0.5);
		StartCor(Jump01());
		yield return WaitTime(0.5);
		BeginLookAtByPos_NotWait(QieCheEscape3, 0.5, 360);
		yield return WaitTime(0.5);
		StartCor(Jump02());
		yield return WaitTime(0.5);
		_actor.ClearSelf();
	}

	private void Shoot01()
	{
		TSVector2 position = GetPosition();
		FP radius = 4;
		FP innerRadius = 1;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
		for (int i = 0; i < 3; i++)
		{
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, GetCurrentPlayer(), isReachable: true);
			CircleMultipleShoot("Bullet_30271_PlayerGift", AdventureWeapon.MultipleShootStyle.RandomDirection, alignShoot: true, 0, 1, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), 2, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 0, 0, shapeRandomPoint);
		}
	}

	private void Dash01()
	{
		TSVector2 direction = QieCheEscape1 - GetPosition();
		FP speed = Distance(GetPosition(), QieCheEscape1);
		FP distance = Distance(GetPosition(), QieCheEscape1);
		BeginLookAtByPos_NotWait(QieCheEscape1, 0.5, 360);
		BeginDash(1, direction, speed, distance, 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.5);
	}

	protected IEnumerator Jump01()
	{
		CrossJump(QieCheEscape2, 0, 0.5, checkPositionReachable: false);
		yield return WaitTime(0.5);
	}

	protected IEnumerator Jump02()
	{
		CrossJump(QieCheEscape3, 0, 0.5, checkPositionReachable: false);
		yield return WaitTime(0.5);
	}
}
