using System.Collections;

namespace AIScript.Monster._30931HaSaNa;

public class Skill_Death : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		_actor.PlayDeathAnim();
		SendDeclareDeadEvent();
		ClearOwnerBullet();
		if (GetLogicTagToggleValue(_actor, "IsShaJuRen"))
		{
			BeginAttack(1, "ShaJuRenDeath", flushInputedKeys: true, forceInterruptAttack: true);
		}
		else
		{
			BeginAttack(1, "HaSaNaDeath", flushInputedKeys: true, forceInterruptAttack: true);
		}
		if (!GetLogicTagToggleValue(_actor, "IsMainline"))
		{
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield break;
		}
		yield return WaitTime(1.7);
		_actor.ClearSelf();
	}
}
