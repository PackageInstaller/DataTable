using System.Collections;

namespace AIScript.Monster._30901ChiHou;

public class Skill02_DashAttack : SkillSimpleBase
{
	private readonly string RunAttack = "RunAttack";

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) > 6)
		{
			MoveToPosition(GetEntityPosition(Targetenemy), 5, AdventureActor.MovementMode.Run, 2);
			yield return WaitMoveStatus();
		}
		yield return BeginLookAt(Targetenemy, 0.2, 900);
		BeginAttack(1, RunAttack, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEarlyWarningEffect("fx_warning_dash_1x6_5", 0.6f, 0, GetPosition(), GetTSVectToAngle(GetForward(), 0));
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
