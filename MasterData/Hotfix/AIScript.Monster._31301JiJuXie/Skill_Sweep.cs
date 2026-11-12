using System.Collections;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Sweep : SkillSimpleBase
{
	private static readonly string combo_Turn_Left = "Turn_Left";

	private static readonly string combo_Turn_Right = "Turn_Right";

	private static readonly string combo_Sweep_1 = "Sweep_1";

	private static readonly string combo_Sweep_1_End = "Sweep_1_End";

	private static readonly string evt_FX = "RootFX";

	private static readonly string combo_Sweep_Stage2_L = "Sweep_2_L";

	private static readonly string combo_Sweep_Stage2_R = "Sweep_2_R";

	private long RootFX;

	private LogicEntity Targetenemy;

	private int phase;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopEffect(RootFX);
		StopDash();
		SetLogicTagToggleValue(_actor, Config.Skill_Sweep_Finish, value: true);
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
		BeginAttack(2, combo_Sweep_1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.56);
		LogicEntity logicEntity2 = GetAttackTarget();
		if (logicEntity2 == null)
		{
			logicEntity2 = GetCurrentPlayer();
		}
		GetEntityPosition(logicEntity2);
		yield return WaitCustomEvent(evt_FX);
		StopWaitLookAt();
		RootFX = PlayEffect("fx_m31301_base_skill5_1_foot", 1f, 1, GetPosition(), 0);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (phase >= 2 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > -100 && CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) < 100 && Distance(GetPosition(), GetEntityPosition(GetAttackTarget())) <= 13)
		{
			FP fP = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
			string actionKey2 = ((fP > 0 && fP <= 180) ? combo_Sweep_Stage2_L : combo_Sweep_Stage2_R);
			BeginAttack(4, actionKey2, flushInputedKeys: true, forceInterruptAttack: true);
			GetEnemy();
			BeginLookAt_NotWait(Targetenemy, 0.3, 120);
			Dash();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginAttack(3, combo_Sweep_1_End, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private void Dash()
	{
		BeginDashActorForward(1, 20, 4, 60, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.3);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
