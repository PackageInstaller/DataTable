using System.Collections;
using TrueSync;

namespace AIScript.Monster._13031XinYue;

public class Skill_RPG : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Shoot_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private long LaserEffect;

	protected override void OnSkillDisable()
	{
		StopWaitLookAt();
		StopEffect(LaserEffect);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Shoot_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetAttackTarget(), 999, 50);
		yield return WaitCustomEvent("StopTurn");
		StopWaitLookAt();
		TSVector2 sourcePosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0.11, 1));
		double num = 1.9;
		TSVector2 targetPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 100));
		LaserEffect = PlayLinkEffect("AimLaser", useCustomSource: true, null, sourcePosition, num, null, targetPosition, num);
		yield return WaitTime(1);
		CancelAttack();
		StopEffect(LaserEffect);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
