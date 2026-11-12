using System.Collections;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._Boss._Light._50251ShanDianLieQuan;

public class MiniBoss_Light_Skill03_2 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1952805747,
		(ComboInputBuffer.ActionKey)1918065779,
		(ComboInputBuffer.ActionKey)1867013987
	};

	private readonly ComboInputBuffer.ActionKey[] Attack02;

	private readonly ComboInputBuffer.ActionKey[] Move;

	private DeterministicShape Shape01;

	private DeterministicShape Shape02;

	private TSVector2 Pos01;

	private TSVector2 Pos02;

	private long PlayEffectName01;

	private long PlayEffectName02;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Hide");
		SetHideModelEnable();
		SetUnparalleledEnable();
		BeginLookAt(GetCurrentPlayer(), 0, 3600);
		PlayEffectName01 = PlayEffect("Atk01_BallLoop", 1f, 1, GetPosition(), 0, 1f, actorScale: true);
		MiniBoss_Light_Skill03_2 miniBoss_Light_Skill03_ = this;
		MiniBoss_Light_Skill03_2 miniBoss_Light_Skill03_2 = this;
		TSVector2 position = GetPosition();
		FP radius = 10;
		FP innerRadius = 7;
		miniBoss_Light_Skill03_.Shape01 = miniBoss_Light_Skill03_2.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
		Pos01 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
		int RollNum01 = 0;
		while (Distance(GetEntityPositionObsoleted(GetCurrentPlayer()), Pos01) < 10 && RollNum01 < 50)
		{
			Pos01 = GetShapeRandomPoint(Shape01, _actor, isReachable: true);
			RollNum01++;
			yield return WaitFrame(1);
		}
		BeginLookAtByPos(Pos01, 0, 3600);
		BeginDashActorForward(1, 24, Distance(GetPosition(), Pos01), 3600, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 1);
		yield return WaitDashFinish();
		BeginLookAt(GetCurrentPlayer(), 0, 3600);
		MiniBoss_Light_Skill03_2 miniBoss_Light_Skill03_3 = this;
		MiniBoss_Light_Skill03_2 miniBoss_Light_Skill03_4 = this;
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		innerRadius = 15;
		radius = 10;
		miniBoss_Light_Skill03_3.Shape02 = miniBoss_Light_Skill03_4.GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, innerRadius, radius);
		Pos02 = GetShapeRandomPoint(Shape02, _actor, isReachable: true);
		int num = 0;
		while ((Distance(GetEntityPositionObsoleted(GetCurrentPlayer()), Pos02) < 10 || Distance(Pos01, Pos02) < 8) && num < 50)
		{
			Pos02 = GetShapeRandomPoint(Shape02, _actor, isReachable: true);
			num++;
		}
		BeginLookAtByPos(Pos02, 0, 3600);
		BeginDashActorForward(2, 24, Distance(GetPosition(), Pos02), 3600, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 1);
		yield return WaitDashFinish();
		BeginLookAt(GetCurrentPlayer(), 0, 3600);
		PlayEffect("Atk01_ChangeBack", 1f, 2, GetPosition());
		StopEffect(PlayEffectName01);
		StopEffect(PlayEffectName02);
		BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(6);
		SetHideModelDisable();
		SetUnparalleledDisable();
		yield return WaitFrame(6);
		CancelAttack();
		Dash();
		yield return WaitCustomEvent("StopDash");
		StopDash();
		yield return WaitDashFinish();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void Dash()
	{
		FP fP = Distance(GetPosition(), GetEntityPositionObsoleted(GetCurrentPlayer()));
		FP speed = fP / 0.35;
		BeginDashActorForward(1, speed, fP, 360, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	public MiniBoss_Light_Skill03_2()
	{
		//IL_0024: Field data (rva=0x720) could not be found in any section!
		//IL_0024: Field data (rva=0x720) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._3183AD5CC447DEE86C6E6F85AD237EB12473784D2859CE96DAB80E4FFBEEEDD8));
		Attack02 = array;
		Move = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };
		base._002Ector();
	}
}
