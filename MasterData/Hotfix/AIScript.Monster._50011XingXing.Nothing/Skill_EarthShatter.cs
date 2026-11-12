#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Nothing;

public class Skill_EarthShatter : SkillBaseXingXing
{
	private readonly string playWarningEvent = "PlayWarningFx";

	private readonly string stopWarningEvent = "StopWarningFx";

	private long warningFxID;

	private readonly string warningFx = "fx_m50011_base_skill3_atk_ground_crack_common";

	private LogicEntity target;

	private TSVector2 movePos;

	protected override void OnSkillDisable()
	{
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (comboIndex == SkillBaseXingXing.ESATKIndex && eventName == playWarningEvent)
		{
			NovaLogger.Debug("猩猩无.播放预警");
			string fxAlias = warningFx;
			TSVector2 position = GetPosition();
			FP entityAngle = GetEntityAngle(_actor);
			warningFxID = PlayEffect(fxAlias, 1f, default, position, entityAngle);
		}
		if (comboIndex == SkillBaseXingXing.ESATKIndex && eventName == stopWarningEvent)
		{
			StopEffect(warningFxID);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetTarget();
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, GetEntityPositionObsoleted(target), default, default, 12, 7.5);
		if (GetDestination(shapeData, out var destination))
		{
			movePos = destination;
			yield return StartCor(Jump());
		}
		yield return StartCor(Attack());
	}

	private bool GetDestination(DeterministicShape shape, out TSVector2 destination)
	{
		bool result = false;
		destination = TSVector2.zero;
		TSVector2 position = GetPosition();
		FP fP = 15;
		for (int i = 0; i <= 10; i++)
		{
			destination = GetShapeRandomPoint(shape, _actor, isReachable: true);
			if (fP <= Distance(position, destination))
			{
				result = true;
				break;
			}
		}
		return result;
	}

	private IEnumerator Jump()
	{
		TSVector2 selfPos = GetPosition();
		FP dashDist = Distance(selfPos, movePos);
		SetCloseBlockEnable();
		BeginAttack(SkillBaseXingXing.ESJumpIndex, SkillBaseXingXing.ESJumpKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.45);
		BeginDash(SkillBaseXingXing.jumpIndex, movePos - selfPos, dashDist / 0.4, dashDist, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.2);
		yield return WaitTime(0.2);
		BeginLookAt_NotWait(target, 0.2, 675);
		yield return WaitDashFinish();
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetCloseBlockDisable();
	}

	private IEnumerator Attack()
	{
		BeginAttack(SkillBaseXingXing.ESATKIndex, SkillBaseXingXing.ESATKKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(target, 0.3, 200);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
