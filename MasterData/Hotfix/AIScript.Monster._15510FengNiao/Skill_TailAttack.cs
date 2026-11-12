using System.Collections;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_TailAttack : SimpleAPI_FengNiao
{
	private static readonly ComboInputBuffer.ActionKey[] TailAttack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	private TSVector2 AttackPosition;

	private string WarningFX;

	private string AttackFX;

	private bool IsAttack;

	private FP AttackTime;

	private FP AttackDistance;

	private FP Phase;

	private FP EndWaitTime;

	private DeterministicShape AttackShape;

	private HitFeatureData HitFeature;

	private string EarlyWarningFXName;

	private FP EarlyWarningFXSize;

	private bool IsBossRush;

	private bool IsUpgrade;

	private long ExtraWarning;

	private long Warning;

	protected override void OnSkillEnable()
	{
		IsAttack = false;
		Phase = GetLogicTagFpValue(_actor, "BattleStage");
		IsBossRush = GetLogicTagToggleValue(_actor, "IsBossRush");
		if (IsBossRush)
		{
			if (Phase == 2)
			{
				IsUpgrade = false;
			}
			else
			{
				IsUpgrade = true;
			}
		}
		else if (Phase == 1)
		{
			IsUpgrade = false;
		}
		else
		{
			IsUpgrade = true;
		}
		if (!IsUpgrade)
		{
			WarningFX = "TailAttackWarningP1";
			AttackTime = 2;
			AttackDistance = 6.7;
			AttackFX = "TailAttackP1";
			EndWaitTime = 1.4;
			EarlyWarningFXName = "TailAttackWarning_7";
			EarlyWarningFXSize = 1.05;
		}
		else
		{
			WarningFX = "TailAttackWarningP2";
			AttackTime = 2.5;
			AttackDistance = 11.7;
			AttackFX = "TailAttackP2";
			EndWaitTime = 3;
			EarlyWarningFXName = "TailAttackWarning_12";
			EarlyWarningFXSize = 1.18;
		}
		AttackPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0.26));
		TSVector2 attackPosition = AttackPosition;
		FP attackDistance = AttackDistance;
		FP innerRadius = 0;
		AttackShape = GetShapeData(DeterministicShape.ShapeType.Circle, attackPosition, default, default, attackDistance, innerRadius);
		innerRadius = 0.5;
		attackDistance = 4;
		HitFeature = GetHitFeatureData(HitBox.FeatureFlag.Stiff, default, default, UseAtttackForward: false, default, null, null, innerRadius, default, default, default, default, default, default, default, default, null, null, null, null, attackDistance);
	}

	protected override void OnSkillDisable()
	{
		StopEffect(ExtraWarning);
		StopEffect(Warning);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, TailAttack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		StartCor(AttackCor());
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		while (!IsAttack)
		{
			yield return null;
		}
		CancelAttack();
		FlowerShootStart();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(EndWaitTime);
	}

	private IEnumerator AttackCor()
	{
		Skill_TailAttack skill_TailAttack = this;
		Skill_TailAttack skill_TailAttack2 = this;
		string warningFX = WarningFX;
		TSVector2 attackPosition = AttackPosition;
		skill_TailAttack.Warning = skill_TailAttack2.PlayEffect(warningFX, 1f, default, attackPosition);
		Skill_TailAttack skill_TailAttack3 = this;
		Skill_TailAttack skill_TailAttack4 = this;
		string earlyWarningFXName = EarlyWarningFXName;
		attackPosition = AttackPosition;
		float spawnSize = (float)EarlyWarningFXSize;
		skill_TailAttack3.ExtraWarning = skill_TailAttack4.PlayEarlyWarningEffect(earlyWarningFXName, 15f, default, attackPosition, default, spawnSize);
		yield return WaitTime(AttackTime + 0.2);
		Skill_TailAttack skill_TailAttack5 = this;
		string attackFX = AttackFX;
		attackPosition = AttackPosition;
		skill_TailAttack5.PlayEffect(attackFX, 1f, default, attackPosition);
		AreaHit_Simple(_actor, AttackShape, HitFeature, 155100801, 0.5, HitBox.HurtAnimType.Large, "HittedFX_Magic");
		IsAttack = true;
		CompleteEarlyWarningEffect(ExtraWarning);
	}
}
