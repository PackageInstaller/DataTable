using System.Collections;
using TrueSync;

namespace AIScript.Monster._Boss._Light._50251ShanDianLieQuan;

public class MiniBoss_Light_Skill04 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey._2
	};

	private readonly ComboInputBuffer.ActionKey[] Stun = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey._3
	};

	private readonly ComboInputBuffer.ActionKey[] Move = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private long PlayEffectName;

	private TSVector2 HomePos;

	private TSVector2 SkillPos;

	private DeterministicShape Shape01;

	private DeterministicShape Shape02;

	private DeterministicShape Shape03;

	private DeterministicShape Shape04;

	protected override void OnSkillEnable()
	{
		HomePos = new TSVector2(0, 0);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Move, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect("Atk04_Up", 1f, 1, GetPosition(), 0, 1f, actorScale: true);
		SetHideModelEnable();
		BeginLookAtCameraDir_NotWait(DirectionType.UP, 0.1, 3600);
		yield return WaitFrame(3);
		FP tSVectToAngle = GetTSVectToAngle(GetForward(), 0);
		MiniBoss_Light_Skill04 miniBoss_Light_Skill = this;
		MiniBoss_Light_Skill04 miniBoss_Light_Skill2 = this;
		TSVector2 homePos = HomePos;
		FP radius = 14;
		FP innerRadius = 13;
		FP angle = 90;
		FP rotation = tSVectToAngle;
		miniBoss_Light_Skill.Shape01 = miniBoss_Light_Skill2.GetShapeData(DeterministicShape.ShapeType.Fan, homePos, default, default, radius, innerRadius, angle, rotation);
		SkillPos = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
		Teleport(SkillPos);
		if (GetBuffNum(_actor, 100129910) == 0)
		{
			BeginLookAtByPos_NotWait(HomePos, 0, 3600);
			yield return WaitFrame(6);
			MiniBoss_Light_Skill04 miniBoss_Light_Skill3 = this;
			MiniBoss_Light_Skill04 miniBoss_Light_Skill4 = this;
			TSVector2 position = GetPosition();
			rotation = 35;
			angle = 0;
			innerRadius = 90;
			radius = GetTSVectToAngle(GetForward(), 0) + 45;
			miniBoss_Light_Skill3.Shape02 = miniBoss_Light_Skill4.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, rotation, angle, innerRadius, radius);
			MiniBoss_Light_Skill04 miniBoss_Light_Skill5 = this;
			MiniBoss_Light_Skill04 miniBoss_Light_Skill6 = this;
			TSVector2 position2 = GetPosition();
			radius = 35;
			innerRadius = 0;
			angle = 1;
			rotation = GetTSVectToAngle(GetForward(), 0) + 90;
			miniBoss_Light_Skill5.Shape03 = miniBoss_Light_Skill6.GetShapeData(DeterministicShape.ShapeType.Fan, position2, default, default, radius, innerRadius, angle, rotation);
			MiniBoss_Light_Skill04 miniBoss_Light_Skill7 = this;
			MiniBoss_Light_Skill04 miniBoss_Light_Skill8 = this;
			TSVector2 position3 = GetPosition();
			rotation = 35;
			angle = 0;
			innerRadius = 1;
			radius = GetTSVectToAngle(GetForward(), 0) - 90;
			miniBoss_Light_Skill7.Shape04 = miniBoss_Light_Skill8.GetShapeData(DeterministicShape.ShapeType.Fan, position3, default, default, rotation, angle, innerRadius, radius);
			PlayEffect("Atk04_LightDown", 1f, 1, GetPosition(), 0, 1f, actorScale: true);
			yield return WaitFrame(3);
			SetHideModelDisable();
			LogicEntity Enemy = GetCurrentPlayer();
			if (AreaCheckMonsterTarget(Shape02))
			{
				BeginAttack(2, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
				BeginLookAtByPos_NotWait(GetShapeRandomPoint(Shape03, _actor), 0.4, 360);
				yield return WaitFrame(60);
				BeginAttack(3, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitCustomEvent("Fire");
				BeginRotateAngle_NotWait(-180, 60);
			}
			else
			{
				BeginAttack(2, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
				BeginLookAtByPos_NotWait(GetShapeRandomPoint(Shape04, _actor), 0.4, 360);
				yield return WaitFrame(60);
				BeginAttack(3, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
				yield return WaitCustomEvent("Fire");
				BeginRotateAngle_NotWait(180, 60);
			}
			for (int time = 0; time <= 90; time++)
			{
				if (GetBuffNum(Enemy, 502510006) != 0)
				{
					break;
				}
				yield return null;
			}
			CancelAim();
			CancelAttack();
			RemoveBuffFromTarget(_actor, 502510001);
			yield return WaitFrame(8);
			BeginAttack(3, Stun, flushInputedKeys: true, forceInterruptAttack: true);
			AddBuffToTarget(_actor, 502510002);
			yield return WaitTime(1.9);
			RemoveBuffFromTarget(_actor, 502510002);
			CancelAttack();
		}
		else
		{
			BeginLookAt_NotWait(GetCurrentPlayer(), 0.1, 3600);
			yield return WaitFrame(6);
			PlayEffect("Atk04_LightDown", 1f, 1, GetPosition(), 0, 1f, actorScale: true);
			yield return WaitFrame(3);
			SetHideModelDisable();
			BeginAttack(2, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
			BeginLookAt_NotWait(GetCurrentPlayer(), 1.4, 45);
			yield return WaitFrame(60);
			BeginAttack(3, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Fire");
			LogicEntity Enemy = GetCurrentPlayer();
			AimAtTarget(Enemy, 20);
			for (int time = 0; time <= 90; time++)
			{
				if (GetBuffNum(Enemy, 502510006) != 0)
				{
					break;
				}
				yield return null;
			}
			CancelAim();
			CancelAttack();
			RemoveBuffFromTarget(_actor, 502510001);
			yield return WaitFrame(8);
			BeginAttack(3, Stun, flushInputedKeys: true, forceInterruptAttack: true);
			AddBuffToTarget(_actor, 502510002);
			yield return WaitTime(1.9);
			RemoveBuffFromTarget(_actor, 502510002);
			CancelAttack();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
