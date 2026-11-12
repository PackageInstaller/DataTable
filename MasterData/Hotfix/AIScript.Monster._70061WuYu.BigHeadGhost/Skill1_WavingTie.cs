using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu.BigHeadGhost;

public class Skill1_WavingTie : SkillSimpleBase
{
	private static readonly string ComboKey = "Skill1_WavingTie";

	private static readonly FP LookAtDuration = 0.1;

	private static readonly FP LookAtRotateSpeed = 7200;

	private static readonly string EarlyWarningFxAlias = "fx_warning_fan_180c_6r";

	private static readonly FP EarlyWarningWaitTime = 0.35;

	private static readonly FP EarlyWarningDurationAdd = 0.15;

	private static readonly TSVector2 EarlyWarningPosOffset = new TSVector2(0.1, 0.5);

	private static readonly FP EarlyWarningAngleOffset = 20;

	private static readonly float EarlyWarningSpawnSize = 0.5f;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		if (logicEntity != null)
		{
			BeginLookAt_NotWait(logicEntity, LookAtDuration, LookAtRotateSpeed);
		}
		yield return WaitTime(LookAtDuration);
		StopWaitLookAt();
		Skill1_WavingTie skill1_WavingTie = this;
		string earlyWarningFxAlias = EarlyWarningFxAlias;
		float duration = (float)EarlyWarningWaitTime + (float)EarlyWarningDurationAdd;
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), EarlyWarningPosOffset);
		FP angle = GetRotation() - EarlyWarningAngleOffset;
		float earlyWarningSpawnSize = EarlyWarningSpawnSize;
		skill1_WavingTie.PlayEarlyWarningEffect(earlyWarningFxAlias, duration, default, position, angle, earlyWarningSpawnSize);
		yield return WaitTime(EarlyWarningWaitTime);
		BeginAttack(0, ComboKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
