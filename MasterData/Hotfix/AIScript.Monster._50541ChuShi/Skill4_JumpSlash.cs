using System.Collections;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class Skill4_JumpSlash : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] JumpSlash = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly ComboInputBuffer.ActionKey[] JumpSlashOnce_End = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.D
	};

	private static readonly ComboInputBuffer.ActionKey[] JumpSlash3Times_End = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey.E
	};

	private static readonly ComboInputBuffer.ActionKey[] NullKey = new ComboInputBuffer.ActionKey[0];

	private static readonly FP WaitTimeAtSky_Phase1 = 0.5;

	private static readonly FP WaitTimeAtSky_Phase2 = 0;

	private static readonly FP WaitTimeBeforeDown = 0.7;

	private int ActionPhase;

	private TSVector2 BlinkPosition;

	private TSVector2 RandomShapePosition;

	private LogicEntity Target;

	private FP WaitTimeAtSky;

	private long WarningFX;

	protected override void OnSkillEnable()
	{
		ActionPhase = (int)(long)GetLogicTagFpValue(_actor, "actionPhase");
		Target = GetAttackTarget();
	}

	protected override void OnSkillDisable()
	{
		StopEffect(WarningFX);
	}

	protected override IEnumerator DoMainLogic()
	{
		TSVector2 blinkPosition;
		FP rotation;
		if (ActionPhase == 1)
		{
			WaitTimeAtSky = WaitTimeAtSky_Phase1;
			BeginAttack(1, JumpSlash, flushInputedKeys: true);
			yield return WaitCustomEvent("CloseBlock");
			SetCloseBlockEnable();
			SetBattleOutEnable();
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			yield return WaitTime(WaitTimeAtSky);
			ChooseBlinkPosition();
			yield return Blink(NullKey, BlinkPosition, 0.03, "", 0, "", 0, Target, NullKey, 0);
			Skill4_JumpSlash skill4_JumpSlash = this;
			Skill4_JumpSlash skill4_JumpSlash2 = this;
			blinkPosition = BlinkPosition;
			rotation = GetRotation();
			skill4_JumpSlash.WarningFX = skill4_JumpSlash2.PlayEffect("JumpSlashWarning", 1f, default, blinkPosition, rotation);
			yield return WaitTime(WaitTimeBeforeDown);
			BeginAttack(2, JumpSlashOnce_End);
			yield return WaitCustomEvent("JumpSlashAttackFX");
			Skill4_JumpSlash skill4_JumpSlash3 = this;
			blinkPosition = GetPosition();
			rotation = GetRotation();
			skill4_JumpSlash3.PlayEffect("JumpSlashAttack", 1f, default, blinkPosition, rotation);
			yield return WaitCustomEvent("OpenBlock");
			SetCloseBlockDisable();
			SetBattleOutDisable();
			StopEffect(WarningFX);
			yield return WaitCustomEvent("JumpSlashEndFX");
			Skill4_JumpSlash skill4_JumpSlash4 = this;
			blinkPosition = GetPosition();
			rotation = GetRotation();
			skill4_JumpSlash4.PlayEffect("JumpSlashEnd", 1f, default, blinkPosition, rotation);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(0.5);
			yield break;
		}
		WaitTimeAtSky = WaitTimeAtSky_Phase2;
		BeginAttack(1, JumpSlash, flushInputedKeys: true);
		yield return WaitCustomEvent("CloseBlock");
		SetCloseBlockEnable();
		SetBattleOutEnable();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(WaitTimeAtSky);
		ChooseBlinkPosition();
		yield return Blink(NullKey, BlinkPosition, 0.03, "", 0, "", 0, Target, NullKey, 0);
		Skill4_JumpSlash skill4_JumpSlash5 = this;
		Skill4_JumpSlash skill4_JumpSlash6 = this;
		blinkPosition = BlinkPosition;
		rotation = GetRotation();
		skill4_JumpSlash5.WarningFX = skill4_JumpSlash6.PlayEffect("JumpSlashWarning", 1f, default, blinkPosition, rotation);
		yield return WaitTime(WaitTimeBeforeDown);
		BeginAttack(2, JumpSlash3Times_End);
		yield return WaitCustomEvent("JumpSlashAttackFX");
		Skill4_JumpSlash skill4_JumpSlash7 = this;
		blinkPosition = GetPosition();
		rotation = GetRotation();
		skill4_JumpSlash7.PlayEffect("JumpSlashAttackFire", 1f, default, blinkPosition, rotation);
		yield return WaitCustomEvent("OpenBlock");
		SetCloseBlockDisable();
		SetBattleOutDisable();
		StopEffect(WarningFX);
		yield return WaitCustomEvent("CloseBlock");
		SetCloseBlockEnable();
		SetBattleOutEnable();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(WaitTimeAtSky);
		ChooseBlinkPosition();
		yield return Blink(NullKey, BlinkPosition, 0.03, "", 0, "", 0, Target, NullKey, 0);
		Skill4_JumpSlash skill4_JumpSlash8 = this;
		Skill4_JumpSlash skill4_JumpSlash9 = this;
		blinkPosition = BlinkPosition;
		rotation = GetRotation();
		skill4_JumpSlash8.WarningFX = skill4_JumpSlash9.PlayEffect("JumpSlashWarning", 1f, default, blinkPosition, rotation);
		yield return WaitTime(WaitTimeBeforeDown);
		BeginAttack(3, JumpSlash3Times_End);
		yield return WaitCustomEvent("JumpSlashAttackFX");
		Skill4_JumpSlash skill4_JumpSlash10 = this;
		blinkPosition = GetPosition();
		rotation = GetRotation();
		skill4_JumpSlash10.PlayEffect("JumpSlashAttackFire", 1f, default, blinkPosition, rotation);
		yield return WaitCustomEvent("OpenBlock");
		SetCloseBlockDisable();
		SetBattleOutDisable();
		StopEffect(WarningFX);
		yield return WaitCustomEvent("CloseBlock");
		SetCloseBlockEnable();
		SetBattleOutEnable();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(WaitTimeAtSky);
		ChooseBlinkPosition();
		yield return Blink(NullKey, BlinkPosition, 0.03, "", 0, "", 0, Target, NullKey, 0);
		Skill4_JumpSlash skill4_JumpSlash11 = this;
		Skill4_JumpSlash skill4_JumpSlash12 = this;
		blinkPosition = BlinkPosition;
		rotation = GetRotation();
		skill4_JumpSlash11.WarningFX = skill4_JumpSlash12.PlayEffect("JumpSlashWarning", 1f, default, blinkPosition, rotation);
		yield return WaitTime(WaitTimeBeforeDown);
		BeginAttack(4, JumpSlashOnce_End);
		yield return WaitCustomEvent("JumpSlashAttackFX");
		Skill4_JumpSlash skill4_JumpSlash13 = this;
		blinkPosition = GetPosition();
		rotation = GetRotation();
		skill4_JumpSlash13.PlayEffect("JumpSlashAttackFire", 1f, default, blinkPosition, rotation);
		yield return WaitCustomEvent("OpenBlock");
		SetCloseBlockDisable();
		SetBattleOutDisable();
		StopEffect(WarningFX);
		yield return WaitCustomEvent("JumpSlashEndFX");
		Skill4_JumpSlash skill4_JumpSlash14 = this;
		blinkPosition = GetPosition();
		rotation = GetRotation();
		skill4_JumpSlash14.PlayEffect("JumpSlashEndFire", 1f, default, blinkPosition, rotation);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.5);
	}

	protected void ChooseBlinkPosition()
	{
		Target = GetAttackTarget(isUpToDate: true);
		if (CheckTargetIsValid(Target))
		{
			RandomShapePosition = GetEntityPositionObsoleted(Target);
		}
		else
		{
			RandomShapePosition = new TSVector2(0, 0);
		}
		TSVector2 randomShapePosition = RandomShapePosition;
		FP radius = 3;
		FP innerRadius = 3;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, randomShapePosition, default, default, radius, innerRadius);
		BlinkPosition = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
	}
}
