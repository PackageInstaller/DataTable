#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._13041MiNieWa;

public class Skill_StarMoonField_LD : SkillSimpleBase
{
	private static readonly int DodgeIndex = 0;

	private static readonly string DodgeKey = "Dodge";

	private static readonly int StarMoonIndex = 1;

	private static readonly string StarMoonKey = "StarMoon";

	private static readonly string groundAreaFx = "StarMoonField";

	private static readonly string chargFx = "StarMoonField_Charge";

	private static readonly string disappearFx = "fx_m13041_base_skill6_ground_disappear";

	private List<long> _fx = new List<long>();

	private static readonly int DashIndex = 10;

	protected override void OnSkillEnable()
	{
		SetLogicTagStringValue(_actor, "MiniewaID", GetTargetID(_actor).ToString());
		_fx.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return StartCor(BackPOS0());
		yield return StartCor(StarMoon());
		NovaLogger.Debug("");
	}

	protected IEnumerator BackPOS0()
	{
		TSVector2 placeHolderPosition = GetPlaceHolderPosition("BossCenterPoint");
		BeginLookAtByPos_NotWait(placeHolderPosition, 0.2, 9999);
		BeginAttack(DodgeIndex, DodgeKey, flushInputedKeys: true, forceInterruptAttack: true);
		SetCloseBlockEnable();
		SetBattleOutEnable();
		TSVector2 position = GetPosition();
		TSVector2 direction = placeHolderPosition - position;
		FP fP = Distance(position, placeHolderPosition);
		FP speed = fP / 0.3;
		BeginDash(DashIndex, direction, speed, fP, 999, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		BeginLookAtByDir_NotWait(TSVector2.down, 0.5, 360);
		SetBattleOutDisable();
		SetCloseBlockDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return null;
	}

	protected IEnumerator StarMoon()
	{
		BeginAttack(StarMoonIndex, StarMoonKey, flushInputedKeys: true, forceInterruptAttack: true);
		NovaLogger.Debug("执行子脚本");
		UseMonsterCloneActorCastSkill(1304110);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(0.2);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
