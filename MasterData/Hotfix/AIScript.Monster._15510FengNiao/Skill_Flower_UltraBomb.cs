#define LOG_ERROR
using System.Collections;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_Flower_UltraBomb : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Bomb_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly int BulletAmountLv1 = 12;

	private static readonly int BulletAmountLv2_3 = 22;

	private static readonly FP ShootIntervaltimeLv1 = 0.15;

	private static readonly FP ShootIntervaltimeLv2_3 = 0.075;

	private static readonly FP AreaMoveSpeedLv1_2 = 1.5;

	private static readonly FP AreaMoveSpeedLv3 = 2.5;

	private long ChargeFX;

	private int BulletCount;

	private DeterministicShape SmallAttackShape1;

	private DeterministicShape SmallAttackShape2;

	private DeterministicShape SmallAttackShape3;

	private DeterministicShape SmallAttackShape4;

	private DeterministicShape MasterAreaShape;

	private long AttackShapeAreaID;

	private AreaEffectEntity AttackShapeArea;

	private CoroutineNode MoveAttackAreaCorNode;

	private TSVector2 MasterAreaPosition;

	private TSVector2 SelfAreaPosition;

	private LogicEntity MasterBird;

	private FP AreaMoveSpeed;

	private FP Difficulty;

	private FP AreaMagnification;

	private string AreaEffect_Bomb_Warning_S_Ultra;

	private FP ShootIntervaltime;

	private int BulletAmount;

	private FP SelfAreaPositionOffsetMagnification;

	private bool IsBossRush;

	protected override void OnSkillEnable()
	{
		BulletCount = 0;
		MasterBird = GetTargetByTeammateIndex(0).get_Item(0);
		Difficulty = GetLogicTagFpValue(_actor, "Difficulty");
		IsBossRush = GetLogicTagToggleValue(MasterBird, "IsBossRush");
		if (Difficulty == 3 || IsBossRush)
		{
			AreaEffect_Bomb_Warning_S_Ultra = "AreaEffect_Bomb_Warning_S_Ultra_Lv3";
			AreaMoveSpeed = AreaMoveSpeedLv3;
			AreaMagnification = 1;
			SelfAreaPositionOffsetMagnification = 1;
			ShootIntervaltime = ShootIntervaltimeLv2_3;
			BulletAmount = BulletAmountLv2_3;
			return;
		}
		AreaEffect_Bomb_Warning_S_Ultra = "AreaEffect_Bomb_Warning_S_Ultra_Lv1_2";
		AreaMoveSpeed = AreaMoveSpeedLv1_2;
		AreaMagnification = 0.3;
		SelfAreaPositionOffsetMagnification = 0.6;
		ShootIntervaltime = ShootIntervaltimeLv2_3;
		BulletAmount = BulletAmountLv2_3;
		if (Difficulty == 1)
		{
			SelfAreaPositionOffsetMagnification = 0.3;
			BulletAmount = BulletAmountLv1;
			ShootIntervaltime = ShootIntervaltimeLv1;
		}
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
		while (!GetLogicTagToggleValue(MasterBird, "UltraSkillReady"))
		{
			yield return null;
		}
		SetLogicTagToggleValue(_actor, "ActiveHurt", value: true);
		ChargeFX = PlayEffect("ChargeFX");
		MasterAreaPosition = GetTSVector2(GetLogicTagFpValue(MasterBird, "UltraAreaX"), GetLogicTagFpValue(MasterBird, "UltraAreaY"));
		SelfAreaPosition = TransLocalPosToWorldPos(MasterAreaPosition, GetPosition() - TSVector2.zero, new TSVector2(0, 5 * SelfAreaPositionOffsetMagnification));
		AttackShapeAreaID = PlayAreaEffect(AreaEffect_Bomb_Warning_S_Ultra, SelfAreaPosition);
		AttackShapeArea = GetAreaEffect(AttackShapeAreaID);
		if (AttackShapeArea == null)
		{
			NovaLogger.Error("蜂鸟花大招的攻击区域创建失败，技能直接跳过");
			InterruptSkill();
			yield break;
		}
		StartCor(ref MoveAttackAreaCorNode, MoveAttackAreaCor());
		yield return WaitTime(0.5);
		while (BulletCount < BulletAmount)
		{
			Skill_Flower_UltraBomb skill_Flower_UltraBomb = this;
			Skill_Flower_UltraBomb skill_Flower_UltraBomb2 = this;
			TSVector2 position = TransLocalPosToWorldPos(AttackShapeArea.tsTransform.Position, TSVector2.up, new TSVector2(0, 4.5 * AreaMagnification * 0.25));
			FP radius = 2.25 * AreaMagnification;
			FP innerRadius = 0;
			skill_Flower_UltraBomb.SmallAttackShape1 = skill_Flower_UltraBomb2.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
			PlayEffect("BombShootFX", 1f, default, default, default, 1f, actorScale: true);
			FanMultipleShoot("Weapon_ParabolaBird", AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 1, 0, GetPosition(), 2.4, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 1, 1, 0, GetShapeRandomPoint(SmallAttackShape1, _actor, isReachable: true));
			yield return WaitTime(ShootIntervaltime);
			Skill_Flower_UltraBomb skill_Flower_UltraBomb3 = this;
			Skill_Flower_UltraBomb skill_Flower_UltraBomb4 = this;
			TSVector2 position2 = TransLocalPosToWorldPos(AttackShapeArea.tsTransform.Position, TSVector2.down, new TSVector2(0, 4.5 * AreaMagnification * 0.25));
			innerRadius = 2.25 * AreaMagnification;
			radius = 0;
			skill_Flower_UltraBomb3.SmallAttackShape2 = skill_Flower_UltraBomb4.GetShapeData(DeterministicShape.ShapeType.Circle, position2, default, default, innerRadius, radius);
			FanMultipleShoot("Weapon_ParabolaBird", AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 1, 0, GetPosition(), 2.4, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 1, 1, 0, GetShapeRandomPoint(SmallAttackShape2, _actor, isReachable: true));
			yield return WaitTime(ShootIntervaltime);
			Skill_Flower_UltraBomb skill_Flower_UltraBomb5 = this;
			Skill_Flower_UltraBomb skill_Flower_UltraBomb6 = this;
			TSVector2 position3 = TransLocalPosToWorldPos(AttackShapeArea.tsTransform.Position, TSVector2.left, new TSVector2(0, 4.5 * AreaMagnification * 0.25));
			radius = 2.25 * AreaMagnification;
			innerRadius = 0;
			skill_Flower_UltraBomb5.SmallAttackShape3 = skill_Flower_UltraBomb6.GetShapeData(DeterministicShape.ShapeType.Circle, position3, default, default, radius, innerRadius);
			FanMultipleShoot("Weapon_ParabolaBird", AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 1, 0, GetPosition(), 2.4, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 1, 1, 0, GetShapeRandomPoint(SmallAttackShape3, _actor, isReachable: true));
			yield return WaitTime(ShootIntervaltime);
			Skill_Flower_UltraBomb skill_Flower_UltraBomb7 = this;
			Skill_Flower_UltraBomb skill_Flower_UltraBomb8 = this;
			TSVector2 position4 = TransLocalPosToWorldPos(AttackShapeArea.tsTransform.Position, TSVector2.right, new TSVector2(0, 4.5 * AreaMagnification * 0.25));
			innerRadius = 2.25 * AreaMagnification;
			radius = 0;
			skill_Flower_UltraBomb7.SmallAttackShape4 = skill_Flower_UltraBomb8.GetShapeData(DeterministicShape.ShapeType.Circle, position4, default, default, innerRadius, radius);
			FanMultipleShoot("Weapon_ParabolaBird", AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 1, 0, GetPosition(), 2.4, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 1, 1, 0, GetShapeRandomPoint(SmallAttackShape4, _actor, isReachable: true));
			Skill_Flower_UltraBomb skill_Flower_UltraBomb9 = this;
			Skill_Flower_UltraBomb skill_Flower_UltraBomb10 = this;
			TSVector2 masterAreaPosition = MasterAreaPosition;
			radius = 4;
			innerRadius = 0;
			skill_Flower_UltraBomb9.MasterAreaShape = skill_Flower_UltraBomb10.GetShapeData(DeterministicShape.ShapeType.Circle, masterAreaPosition, default, default, radius, innerRadius);
			FanMultipleShoot("Weapon_ParabolaBird", AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 1, 0, GetPosition(), 2.4, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 1, 1, 0, GetShapeRandomPoint(MasterAreaShape, _actor, isReachable: true));
			BulletCount++;
			yield return WaitTime(ShootIntervaltime);
		}
		StopEffect(ChargeFX);
		StopCor(MoveAttackAreaCorNode);
		CancelAttack();
		yield return WaitTime(1);
		StopAreaEffect(AttackShapeAreaID);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(2);
	}

	private IEnumerator MoveAttackAreaCor()
	{
		while (true)
		{
			MasterAreaPosition = GetTSVector2(GetLogicTagFpValue(MasterBird, "UltraAreaX"), GetLogicTagFpValue(MasterBird, "UltraAreaY"));
			SelfAreaPosition = TransLocalPosToWorldPos(MasterAreaPosition, GetPosition() - TSVector2.zero, new TSVector2(0, 5 * SelfAreaPositionOffsetMagnification));
			if (Distance(AttackShapeArea.tsTransform.Position, SelfAreaPosition) > 0.2)
			{
				AttackShapeArea.tsTransform.Position += (SelfAreaPosition - AttackShapeArea.tsTransform.Position).normalized * AreaMoveSpeed / 30;
			}
			yield return null;
		}
	}
}
