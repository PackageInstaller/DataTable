using System.Collections;
using TrueSync;

namespace AIScript.Monster._10501BanShenShu;

public class Skill_Wall : SkillSimpleBase
{
	private static readonly int ActionIndex = 0;

	private static readonly string AttackAction = "GeneralAttack";

	private static readonly string Wall = "fx_m10501_loop_Skill6_ground";

	private static readonly string AreaEffectAlis = "Wall";

	private static readonly TSVector2 InsideWallPOS = new TSVector2(0, 10.5);

	private static readonly TSVector2 OutsideWallPOS = new TSVector2(0, 10.5);

	private static CoroutineNode TimeLimit;

	private static long FxInsideWall;

	private static long FxOutsideWall;

	private static long AreaEffectWall;

	private static int AttackTimes;

	protected override void OnSkillEnable()
	{
		AttackTimes = 0;
	}

	protected override void OnSkillDisable()
	{
		AttackTimes = 0;
		StopCor(TimeLimit);
	}

	protected override IEnumerator DoMainLogic()
	{
		TimeLimit = StartCor(SkillDuration());
		BeginAttack(ActionIndex, AttackAction, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		FxInsideWall = PlayEffect(Wall, 1f, default, InsideWallPOS, 180);
		FxOutsideWall = PlayEffect(Wall, 1f, default, OutsideWallPOS, 180, 1.15f);
		AreaEffectWall = PlayAreaEffect(AreaEffectAlis, GetPosition());
		AddBuffToTarget(_actor, 10010213);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopCor(TimeLimit);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex == 0)
		{
			AttackTimes++;
			if (AttackTimes == 1)
			{
				CancelAttack();
			}
		}
	}

	protected IEnumerator SkillDuration()
	{
		yield return WaitTime(6);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		InterruptSkill();
	}
}
