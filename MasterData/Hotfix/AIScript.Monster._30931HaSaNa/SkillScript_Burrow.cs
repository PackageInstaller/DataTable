using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_Burrow : SkillScript_MeeleBase
{
	private readonly string comboTag_Stage1 = "Burrow_Down";

	private readonly string eventName_Hide = "Hide";

	private readonly string comboTag_Stage2 = "Attack_3";

	private readonly string comboTag_Stage2_Strenth = "Attack_3_Strenth";

	private readonly string eventName_StartJump = "JumpStart";

	private readonly FP rushSpeed = 1.5;

	private readonly FP rotateSpeed = 150;

	private readonly string eventName_EndJump = "JumpEnd";

	private readonly string eventName_AddStrengthBuff = "TurnToHammer";

	private readonly string eventName_RemoveStrengthBuff = "HammerEnd";

	private readonly int buffId_Strength = 309310010;

	private readonly string comboTag_Stage3_A = "Attack_2_1_Hammer";

	private readonly string comboTag_Stage3_B = "Attack_4_End_WithoutDash";

	private readonly FP checkFanRadius_Strength = 10;

	private readonly FP checkFanAngle_Strength = 300;

	private readonly FP rotateDuration_2_1 = 0.25;

	private readonly FP rotateDuration_2_2 = 0.35;

	private readonly FP rotateSpeed_2 = 300;

	private bool IsComboStage3;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		IsComboStage3 = false;
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		TSVector2 targetPos = GetEntityPosition(attackTarget);
		BeginAttack(1, comboTag_Stage1, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(1);
		attackTarget = GetAttackTarget(isUpToDate: true);
		if (CheckTargetIsValid(attackTarget))
		{
			targetPos = TransLocalPosToWorldPos(GetPosition(), GetEntityPosition(attackTarget) - GetPosition(), TSVector2.up * (Distance(GetPosition(), GetEntityPosition(attackTarget)) - 1));
		}
		Teleport(targetPos);
		SkillScript_Burrow skillScript_Burrow = this;
		TSVector2 position = GetPosition();
		skillScript_Burrow.PlayEarlyWarningEffect("YuJing_circular_3", 0.75f, default, position);
		BeginLookAtMonsterTarget(0.75, 999);
		yield return WaitTime(0.75);
		SetUnparalleledDisable();
		SetHideModelDisable();
		BeginAttack(2, _isStrength ? comboTag_Stage2_Strenth : comboTag_Stage2, flushInputedKeys: true);
		if (_isStrength)
		{
			yield return WaitCustomEvent("SearchEnemy");
			SkillScript_Burrow skillScript_Burrow2 = this;
			TSVector2 position2 = GetPosition();
			FP radius = checkFanRadius_Strength;
			FP angle = checkFanAngle_Strength;
			FP rotation = GetRotation();
			DeterministicShape shapeData = skillScript_Burrow2.GetShapeData(DeterministicShape.ShapeType.Fan, position2, default, default, radius, default, angle, rotation);
			List<LogicEntity> targetsFromShape = GetTargetsFromShape(shapeData, null, includeSelf: false, GetAttackTarget(isUpToDate: true));
			if (targetsFromShape != null && targetsFromShape.Count > 0)
			{
				IsComboStage3 = true;
				if (TSRandom.Range(0, 100) <= 70)
				{
					BeginLookAtMonsterTarget(rotateDuration_2_1, rotateSpeed_2);
					BeginAttack(3, comboTag_Stage3_A, flushInputedKeys: true, forceInterruptAttack: true);
				}
				else
				{
					BeginLookAtMonsterTarget(rotateDuration_2_2, rotateSpeed_2);
					yield return WaitTime(0.35);
					SkillScript_Burrow skillScript_Burrow3 = this;
					position = GetPosition();
					rotation = GetRotation();
					skillScript_Burrow3.PlayEarlyWarningEffect("fx_warning_fan_45c_10r", 0.65f, default, position, rotation);
					yield return WaitCustomEvent("comboTag_Stage3_B");
					BeginAttack(3, comboTag_Stage3_B, flushInputedKeys: true, forceInterruptAttack: true);
				}
			}
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (string.Equals(eventName, eventName_Hide))
		{
			SetUnparalleledEnable();
			SetHideModelEnable();
		}
		else if (string.Equals(eventName, eventName_StartJump))
		{
			BeginDashActorForward(1, rushSpeed, 999, 999, comboWithAttack: true, isAngle: true, notChangeForward: true);
			BeginLookAtMonsterTarget(0.75, rotateSpeed);
		}
		else if (string.Equals(eventName, eventName_EndJump))
		{
			StopDash();
			StopWaitLookAt();
		}
		else if (_isStrength && string.Equals(eventName, eventName_AddStrengthBuff))
		{
			AddBuffToTarget(_actor, buffId_Strength);
		}
		else if (_isStrength && string.Equals(eventName, eventName_RemoveStrengthBuff) && ((comboIndex == 2 && !IsComboStage3) || (comboIndex == 3 && IsComboStage3)))
		{
			RemoveBuffFromTarget(_actor, buffId_Strength);
		}
		else if (string.Equals(eventName, "ShockWave-1"))
		{
			SetLogicTagTSVector2Value(_actor, "Offset_SmashPoint", new TSVector2(0, 3));
		}
	}
}
