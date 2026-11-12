#define LOG_ERROR
using System.Collections;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_Flower_Bomb : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Bomb_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly int BulletAmount = 16;

	private static readonly FP ShootIntervaltime = 0.15;

	private static readonly FP AreaMoveSpeedLv1_2 = 2;

	private static readonly FP AreaMoveSpeedLv3 = 3;

	private long ChargeFX;

	private int BulletCount;

	private TSVector2 ShootPosition;

	private DeterministicShape AttackShape;

	private long AttackShapeAreaID;

	private AreaEffectEntity AttackShapeArea;

	private CoroutineNode MoveAttackAreaCorNode;

	private string AreaEffect_Bomb_Warning;

	private FP Difficulty;

	private FP AreaMoveSpeed;

	private FP AreaMagnification;

	private FP IsMoving;

	private LogicEntity MasterBird;

	protected override void OnSkillEnable()
	{
		BulletCount = 0;
		IsMoving = 0;
		StartCor(CheckUltraSkill());
		AreaEffect_Bomb_Warning = "AreaEffect_Bomb_Warning_S_Lv3";
		AreaMoveSpeed = AreaMoveSpeedLv3;
		AreaMagnification = 1;
	}

	protected override void OnSkillDisable()
	{
		StopEffect(ChargeFX);
		StopAreaEffect(AttackShapeAreaID);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Bomb_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		SetLogicTagToggleValue(_actor, "ActiveHurt", value: true);
		ChargeFX = PlayEffect("ChargeFX");
		yield return WaitTime(0.5);
		ReplaceAnimationGroup();
		AttackShapeAreaID = PlayAreaEffect(AreaEffect_Bomb_Warning, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 4)));
		AttackShapeArea = GetAreaEffect(AttackShapeAreaID);
		if (AttackShapeArea == null)
		{
			NovaLogger.Error("蜂鸟花的攻击区域创建失败，技能直接跳过");
			InterruptSkill();
		}
		yield return WaitTime(0.5);
		StartCor(ref MoveAttackAreaCorNode, MoveAttackAreaCor());
		while (BulletCount < BulletAmount)
		{
			Skill_Flower_Bomb skill_Flower_Bomb = this;
			Skill_Flower_Bomb skill_Flower_Bomb2 = this;
			TSVector2 position = TransLocalPosToWorldPos(AttackShapeArea.tsTransform.Position, GetEntityPositionObsoleted(GetAttackTarget(isUpToDate: true)) - AttackShapeArea.tsTransform.Position, new TSVector2(0, AreaMoveSpeed * 0.03 * IsMoving));
			FP radius = 1.5 * AreaMagnification;
			FP innerRadius = 0;
			skill_Flower_Bomb.AttackShape = skill_Flower_Bomb2.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
			ShootPosition = GetShapeRandomPoint(AttackShape, _actor, isReachable: true);
			PlayEffect("BombShootFX", 1f, default, default, default, 1f, actorScale: true);
			FanMultipleShoot("Weapon_ParabolaBird", AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 1, 0, GetPosition(), 2.4, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 1, 1, 0, ShootPosition);
			BulletCount++;
			yield return WaitTime(ShootIntervaltime);
		}
		StopEffect(ChargeFX);
		StopCor(MoveAttackAreaCorNode);
		IsMoving = 0;
		CancelAttack();
		yield return WaitTime(0.5);
		StopAreaEffect(AttackShapeAreaID);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator MoveAttackAreaCor()
	{
		yield return WaitTime(1);
		IsMoving = 1;
		while (true)
		{
			if (Distance(AttackShapeArea.tsTransform.Position, GetEntityPositionObsoleted(GetAttackTarget(isUpToDate: true))) > 0.2)
			{
				AttackShapeArea.tsTransform.Position += (GetEntityPositionObsoleted(GetAttackTarget(isUpToDate: true)) - AttackShapeArea.tsTransform.Position).normalized * AreaMoveSpeed / 30;
			}
			yield return null;
		}
	}

	private IEnumerator CheckUltraSkill()
	{
		MasterBird = GetTargetByTeammateIndex(0).get_Item(0);
		while (!GetLogicTagToggleValue(MasterBird, "InterruptShootSkill"))
		{
			yield return null;
		}
		InterruptSkill();
	}
}
