#define LOG_ERROR
using System.Collections;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_Flower_Bomb_Hardcore : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Bomb_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly int BulletAmount = 12;

	private static readonly FP ShootIntervaltime = 0.15;

	private FP AreaMoveSpeedFar = 3;

	private FP AreaMoveSpeedNear = 1.3;

	private long ChargeFX;

	private int BulletCount;

	private TSVector2 ShootPosition;

	private DeterministicShape AttackShape;

	private long AttackShapeAreaID;

	private AreaEffectEntity AttackShapeArea;

	private CoroutineNode MoveAttackAreaCorNode;

	private string AreaEffect_Bomb_Warning;

	private FP AreaMoveSpeed;

	private FP IsMoving;

	private TSVector2 PlayerPosition;

	private TSVector2 SelfAreaPosition;

	protected override void OnSkillEnable()
	{
		BulletCount = 0;
		IsMoving = 0;
		AreaEffect_Bomb_Warning = "AreaEffect_Bomb_Warning_S_Lv3";
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
		ChargeFX = PlayEffect("ChargeFX");
		yield return WaitTime(0.5);
		ReplaceAnimationGroup();
		PlayerPosition = GetEntityPositionObsoleted(GetCurrentPlayer());
		SelfAreaPosition = TransLocalPosToWorldPos(PlayerPosition, GetPosition() - TSVector2.zero, new TSVector2(0, 7));
		AreaMoveSpeed = AreaMoveSpeedFar;
		if (!QueryPositionReachable(GetCurrentPlayer(), SelfAreaPosition))
		{
			SelfAreaPosition = TransLocalPosToWorldPos(PlayerPosition, TSVector2.zero - GetPosition(), new TSVector2(0, 3));
			AreaMoveSpeed = AreaMoveSpeedNear;
		}
		AttackShapeAreaID = PlayAreaEffect(AreaEffect_Bomb_Warning, SelfAreaPosition);
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
			Skill_Flower_Bomb_Hardcore skill_Flower_Bomb_Hardcore = this;
			Skill_Flower_Bomb_Hardcore skill_Flower_Bomb_Hardcore2 = this;
			TSVector2 position = TransLocalPosToWorldPos(AttackShapeArea.tsTransform.Position, PlayerPosition - AttackShapeArea.tsTransform.Position, new TSVector2(0, AreaMoveSpeed * Distance(GetPosition(), AttackShapeArea.tsTransform.Position) / 15 * IsMoving));
			FP radius = 1.5;
			FP innerRadius = 0;
			skill_Flower_Bomb_Hardcore.AttackShape = skill_Flower_Bomb_Hardcore2.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
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
		StopAreaEffect(AttackShapeAreaID);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(1);
	}

	private IEnumerator MoveAttackAreaCor()
	{
		IsMoving = 1;
		while (true)
		{
			AttackShapeArea.tsTransform.Position += (PlayerPosition - AttackShapeArea.tsTransform.Position).normalized * AreaMoveSpeed / 30;
			yield return null;
		}
	}
}
