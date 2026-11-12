using System.Collections;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_SprayWater : SkillSimpleBase
{
	private static readonly string combo_Turn_Left = "Turn_Left";

	private static readonly string combo_Turn_Right = "Turn_Right";

	private static readonly string combo_Spray_Charge = "Spray_Charge";

	private static readonly string combo_Spray_EndLeft = "Spray_EndLeft";

	private static readonly string combo_Spray_EndRight = "Spray_EndRight";

	private static readonly string evt_FX = "evt_FX";

	private long WaterFX1;

	private long WaterFX2;

	private long WaterFX3;

	private static FP loopTime = 0.5;

	private static FP SprayDash_Speed = 14.5;

	private static FP SprayDash_Duration = 1;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopEffect(WaterFX1);
		StopEffect(WaterFX2);
		StopEffect(WaterFX3);
		SetLogicTagToggleValue(_actor, Config.Skill_SprayWater_Finish, value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		string actionKey = ((CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 0) ? combo_Turn_Left : combo_Turn_Right);
		BeginAttack(1, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		TSVector2 entityPosition = GetEntityPosition(logicEntity);
		BeginLookAtByPos(entityPosition, 0.66, (FP)90 / (FP)0.66);
		yield return WaitTime(0.66);
		StopWaitLookAt();
		BeginAttack(2, combo_Spray_Charge, flushInputedKeys: true, forceInterruptAttack: true);
		WaterFX1 = PlayEffect("fx_m31301_loop_skill3_charge_start", 1f, 1, GetPosition(), 0);
		yield return WaitCustomEvent(evt_FX);
		WaterFX2 = PlayEffect("fx_m31301_loop_skill3_spout", 1f, 1, GetPosition(), 0);
		WaterFX3 = PlayEffect("fx_m31301_loop_skill3_spout_fire", 1f, 1, GetPosition(), 0);
		yield return WaitTime(loopTime);
		FP fP = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		bool playerOnRight = fP > 0 && fP <= 180;
		string actionKey2 = ((fP > 0 && fP <= 180) ? combo_Spray_EndLeft : combo_Spray_EndRight);
		BeginAttack(3, actionKey2, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.5);
		TSVector2 forward = GetForward();
		TSVector2 direction = (playerOnRight ? new TSVector2(-forward.y, forward.x) : new TSVector2(forward.y, -forward.x));
		BeginDash(1, direction, SprayDash_Speed, SprayDash_Speed * SprayDash_Duration, 720, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		StopDash();
		CancelAttack();
		StopEffect(WaterFX1);
		StopEffect(WaterFX2);
		StopEffect(WaterFX3);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
