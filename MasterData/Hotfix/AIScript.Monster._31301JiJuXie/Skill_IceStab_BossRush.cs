using System.Collections;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_IceStab_BossRush : SkillSimpleBase
{
	private static readonly string combo_IceStab = "IceStabBossRush";

	private static readonly string combo_Turn_Left = "Turn_Left";

	private static readonly string combo_Turn_Right = "Turn_Right";

	private static readonly string evt_IceStabSpawn = "IceStabSpawn";

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		SetLogicTagToggleValue(_actor, Config.Skill_IceStab_Finish, value: true);
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
		BeginAttack(2, combo_IceStab, flushInputedKeys: true, forceInterruptAttack: true);
		PlayAreaEffect("Area_31301JiJuXie_BingCi_Big_BossRush", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 5)));
		yield return WaitCustomEvent(evt_IceStabSpawn);
		PlayFeedbackEffect("CameraShake_Down");
		PlayAreaEffect("Area_31301JiJuXie_BingCi_Trace_BossRush", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 5)));
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
