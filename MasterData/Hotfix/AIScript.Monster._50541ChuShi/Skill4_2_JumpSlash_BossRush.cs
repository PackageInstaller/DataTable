using System.Collections;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class Skill4_2_JumpSlash_BossRush : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] JumpSlash = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly ComboInputBuffer.ActionKey[] JumpSlashAttack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly ComboInputBuffer.ActionKey[] JumpSlashEnd_Normal = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly ComboInputBuffer.ActionKey[] JumpSlashEnd_Attack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private static readonly ComboInputBuffer.ActionKey[] NullKey = new ComboInputBuffer.ActionKey[0];

	private static readonly FP WaitTimeAtSky_Normal = 0.5;

	private static readonly FP WaitTimeAtSky_Plus = 0;

	private static readonly FP WaitTimeBeforeDown = 0.7;

	private int BattleStage;

	private TSVector2 BlinkPosition;

	private TSVector2 RandomShapePosition;

	private LogicEntity Target;

	private FP WaitTimeAtSky;

	private long WarningFX;

	protected override void OnSkillEnable()
	{
		BattleStage = (int)(long)GetLogicTagFpValue(_actor, "BattleStage");
		Target = GetAttackTarget();
		if (BattleStage == 1)
		{
			WaitTimeAtSky = WaitTimeAtSky_Normal;
		}
		else
		{
			WaitTimeAtSky = WaitTimeAtSky_Plus;
		}
	}

	protected override void OnSkillDisable()
	{
		StopEffect(WarningFX);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, JumpSlash, flushInputedKeys: true);
		yield return WaitCustomEvent("CloseBlock");
		SetCloseBlockEnable();
		SetUnparalleledEnable();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(WaitTimeAtSky);
		ChooseBlinkPosition();
		yield return Blink(NullKey, BlinkPosition, 0.03, "", 0, "", 0, Target, NullKey, 0);
		Skill4_2_JumpSlash_BossRush skill4_2_JumpSlash_BossRush = this;
		Skill4_2_JumpSlash_BossRush skill4_2_JumpSlash_BossRush2 = this;
		TSVector2 blinkPosition = BlinkPosition;
		FP rotation = GetRotation();
		skill4_2_JumpSlash_BossRush.WarningFX = skill4_2_JumpSlash_BossRush2.PlayEffect("JumpSlashWarning", 1f, default, blinkPosition, rotation);
		yield return WaitTime(WaitTimeBeforeDown);
		BeginAttack(2, JumpSlashAttack);
		yield return WaitCustomEvent("JumpSlashAttackFX");
		Skill4_2_JumpSlash_BossRush skill4_2_JumpSlash_BossRush3 = this;
		blinkPosition = GetPosition();
		rotation = GetRotation();
		skill4_2_JumpSlash_BossRush3.PlayEffect("JumpSlashAttack", 1f, default, blinkPosition, rotation);
		yield return WaitCustomEvent("OpenBlock");
		SetCloseBlockDisable();
		SetUnparalleledDisable();
		StopEffect(WarningFX);
		Skill4_2_JumpSlash_BossRush skill4_2_JumpSlash_BossRush4 = this;
		rotation = 7;
		DeterministicShape shapeData = skill4_2_JumpSlash_BossRush4.GetShapeData(DeterministicShape.ShapeType.Circle, default, default, default, rotation);
		if (BattleStage >= 2 && GetTargetsFromShape(shapeData, GetTargetsByFaction(isFriend: false)).Count > 0)
		{
			BeginAttack(3, JumpSlashEnd_Attack, flushInputedKeys: true, forceInterruptAttack: true);
		}
		else
		{
			BeginAttack(3, JumpSlashEnd_Normal);
			yield return WaitCustomEvent("JumpSlashEndFX");
			Skill4_2_JumpSlash_BossRush skill4_2_JumpSlash_BossRush5 = this;
			blinkPosition = GetPosition();
			rotation = GetRotation();
			skill4_2_JumpSlash_BossRush5.PlayEffect("JumpSlashEnd", 1f, default, blinkPosition, rotation);
		}
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
