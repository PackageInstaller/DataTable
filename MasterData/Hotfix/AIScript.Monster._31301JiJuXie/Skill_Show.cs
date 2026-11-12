using System.Collections;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Show : SkillSimpleBase
{
	private static readonly string combo_Show = "Show";

	private static readonly string combo_Turn_Left = "Turn_Left";

	private static readonly string combo_Turn_Right = "Turn_Right";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		SetLogicTagToggleValue(_actor, Config.Skill_Show_Finish, value: true);
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
		BeginAttack(1, combo_Show, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
