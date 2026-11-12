using System.Collections;

namespace AIScript.Monster.Soldier;

public class Common_Dead : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Dead = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		(_actor as SoldierActor)?.OnShowHud(show: false);
		BeginAttack(1, Dead, flushInputedKeys: true, forceInterruptAttack: true);
		_actor.PlayDeathAnim();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
