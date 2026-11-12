using System.Collections;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_Thumping : SkillScript_MeeleBase
{
	private readonly string comboTag_Stage1 = "Attack_5";

	private readonly string comboTag_Stage2_A = "Attack_2_1_Hammer";

	private readonly string comboTag_Stage2_B = "Attack_4_End_WithoutDash";

	private readonly int buffId_Strength1 = 309310020;

	private readonly string eventName_AddStrengthBuff1 = "TurnToHammer1";

	private readonly string eventName_RemoveStrengthBuff1 = "HammerEnd1";

	private readonly int buffId_Strength2 = 309310010;

	private readonly string eventName_RemoveStrengthBuff2 = "HammerEnd";

	private readonly FP rotateDuration_2_1 = 0.25;

	private readonly FP rotateDuration_2_2 = 0.35;

	private readonly FP rotateSpeed_2 = 300;

	private readonly string eventName_P1LookAt = "P1LookAt";

	private readonly string eventName_P2LookAt = "P2LookAt";

	private readonly string eventName_P1Dash = "P1Dash";

	private readonly string eventName_P2Dash = "P2Dash";

	protected override IEnumerator DoMainLogic()
	{
		_isStrength = true;
		yield return BeginLookAtMonsterTarget(0.1, 9999);
		BeginAttack(1, comboTag_Stage1, flushInputedKeys: true);
		yield return WaitCustomEvent("NextCombo");
		if (TSRandom.Range(0, 100) <= 30)
		{
			BeginLookAtMonsterTarget(rotateDuration_2_1, rotateSpeed_2);
			BeginAttack(3, comboTag_Stage2_A, flushInputedKeys: true, forceInterruptAttack: true);
		}
		else
		{
			BeginLookAtMonsterTarget(rotateDuration_2_2, rotateSpeed_2);
			yield return WaitTime(0.35);
			SkillScript_Thumping skillScript_Thumping = this;
			TSVector2 position = GetPosition();
			FP rotation = GetRotation();
			skillScript_Thumping.PlayEarlyWarningEffect("fx_warning_fan_45c_10r", 0.65f, default, position, rotation);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			BeginAttack(3, comboTag_Stage2_B, flushInputedKeys: true, forceInterruptAttack: true);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (string.Equals(eventName, eventName_AddStrengthBuff1))
		{
			AddBuffToTarget(_actor, buffId_Strength1);
			AddBuffToTarget(_actor, buffId_Strength2);
		}
		else if (string.Equals(eventName, eventName_RemoveStrengthBuff1))
		{
			RemoveBuffFromTarget(_actor, buffId_Strength1);
		}
		else if (string.Equals(eventName, eventName_RemoveStrengthBuff2))
		{
			RemoveBuffFromTarget(_actor, buffId_Strength2);
		}
		else if (string.Equals(eventName, eventName_P1LookAt))
		{
			BeginLookAtMonsterTarget(0.5, 360);
		}
		else if (string.Equals(eventName, eventName_P2LookAt))
		{
			BeginLookAtMonsterTarget(0.25, 360);
		}
		else if (string.Equals(eventName, eventName_P1Dash))
		{
			FP fP = TSMath.Clamp(GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) - 2.5, 0, 8);
			BeginDashActorForward(1, fP / 0.22, fP, 0, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		}
		else if (string.Equals(eventName, eventName_P2Dash))
		{
			FP fP2 = TSMath.Clamp(GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) - 3, 0, 8);
			BeginDashActorForward(1, fP2 / 0.22, fP2, 0, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		}
		else if (string.Equals(eventName, "ShockWave1-1"))
		{
			SetLogicTagTSVector2Value(_actor, "Offset_SmashPoint", new TSVector2(0, 2));
		}
		else if (string.Equals(eventName, "ShockWave2-1"))
		{
			SetLogicTagTSVector2Value(_actor, "Offset_SmashPoint", new TSVector2(0, 3));
		}
	}
}
