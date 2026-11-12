using System.Collections;
using AIScript.Utils;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_BurrowingSprayWater_BossRush : SkillSimpleBase
{
	private static readonly string combo_Turn_Left = "Turn_Left";

	private static readonly string combo_Turn_Right = "Turn_Right";

	private static readonly string combo_Spray_Charge = "Spray_Charge";

	private static readonly string combo_Spray_EndLeft = "Spray_EndLeft";

	private static readonly string combo_Spray_EndRight = "Spray_EndRight";

	private static readonly string combo_Burrow_Down = "Burrow_Down";

	private static readonly string combo_Burrow_Up = "Burrow_Up";

	private static readonly string evt_FX = "evt_FX";

	private long WaterFX1;

	private long WaterFX2;

	private long WaterFX3;

	private long WarningFx;

	private long WarningFx1;

	private static FP loopTime = 0.5;

	private static FP SprayDash_Speed = 14.5;

	private static FP SprayDash_Duration = 1;

	private CoroutineNode OctSprayWater;

	private bool isHidden;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		isHidden = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopEffect(WaterFX1);
		StopCor(OctSprayWater);
		StopEffect(WaterFX2);
		StopEffect(WaterFX3);
		StopEffect(WarningFx1);
		StopEffect(WarningFx);
		if (isHidden)
		{
			ExitBurrow();
		}
		SetLogicTagToggleValue(_actor, Config.Skill_BurrowSprayWater_Finish, value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, combo_Burrow_Down, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.15);
		EnterBurrow();
		yield return WaitTime(0.18);
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		TSVector2 normalized = (new TSVector2(0, 0) - entityPosition).normalized;
		TSVector2 tSVector = new TSVector2(-normalized.y, normalized.x);
		TSVector2 FinishPos = new TSVector2(0, 0) + tSVector * 0 + normalized * 8;
		TSVector2 position = GetPosition();
		Vector3 startPosition = new Vector3((float)position.x, 0f, (float)position.y);
		Vector3 targetPosition = new Vector3((float)FinishPos.x, 0f, (float)FinishPos.y);
		float speed = (float)(Distance(position, FinishPos) / 0.6);
		PlayMovableFx("fx_m31301_loop_skill4_loop_move_root", startPosition, targetPosition, speed, () =>
		{
			WarningFx = PlayEffect("fx_m31301_loop_skill4_loop_move_root", 1f, 0, FinishPos, 0);
		});
		yield return WaitTime(0.6);
		Teleport(FinishPos);
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		TSVector2 entityPosition2 = GetEntityPosition(logicEntity);
		BeginLookAtByPos_NotWait(entityPosition2, 0.4, 4000);
		yield return WaitTime(0.4);
		StopWaitLookAt();
		StopTrace();
		StopEffect(WarningFx);
		WarningFx1 = PlayEffect("fx_m31301_base_skill4_end_move_warning", 2f, 1, GetPosition(), 0);
		yield return WaitTime(0.3);
		BeginAttack(2, combo_Burrow_Up, flushInputedKeys: true, forceInterruptAttack: true);
		ExitBurrow();
		yield return WaitTime(1.2);
		string actionKey = ((CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 0) ? combo_Turn_Left : combo_Turn_Right);
		BeginAttack(3, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		LogicEntity logicEntity2 = GetAttackTarget();
		if (logicEntity2 == null)
		{
			logicEntity2 = GetCurrentPlayer();
		}
		BeginLookAt_NotWait(logicEntity2, 0.1, 400);
		yield return WaitTime(0.1);
		StopWaitLookAt();
		BeginAttack(4, combo_Spray_Charge, flushInputedKeys: true, forceInterruptAttack: true);
		OctSprayWater = StartCor(OctopusBatterySprayWater());
		WaterFX1 = PlayEffect("fx_m31301_loop_skill3_charge_start", 1f, 1, GetPosition(), 0);
		yield return WaitCustomEvent(evt_FX);
		WaterFX2 = PlayEffect("fx_m31301_loop_skill3_spout", 1f, 1, GetPosition(), 0);
		WaterFX3 = PlayEffect("fx_m31301_loop_skill3_spout_fire", 1f, 1, GetPosition(), 0);
		yield return WaitTime(loopTime);
		FP fP = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		bool playerOnRight = fP > 0 && fP <= 180;
		string actionKey2 = ((fP > 0 && fP <= 180) ? combo_Spray_EndLeft : combo_Spray_EndRight);
		BeginAttack(5, actionKey2, flushInputedKeys: true, forceInterruptAttack: true);
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

	private IEnumerator OctopusBatterySprayWater()
	{
		yield return WaitTime(0.3);
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Config.evt_SprayWaterBattery;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
	}

	private void EnterBurrow()
	{
		if (!isHidden)
		{
			CommonUtils_MonsterAPI.SetUnparalleledEnable(_actor);
			SetHideModelEnable();
			SetCloseBlockEnable();
			_actor.PauseMovementBlock();
			isHidden = true;
		}
	}

	private void ExitBurrow()
	{
		if (isHidden)
		{
			CommonUtils_MonsterAPI.SetUnparalleledDisable(_actor);
			SetHideModelDisable();
			SetCloseBlockDisable();
			_actor.ResumeMovementBlock();
			isHidden = false;
		}
	}
}
