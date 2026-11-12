using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._Water._50181ShunYiGuai;

public class Water_Attack05_SpawnKill : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack05 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.O };

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack05, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(65);
		BeginRotateAngle_NotWait(80, 25);
		yield return WaitTime(3.5);
		BeginRotateAngle_NotWait(-160, 25);
		yield return WaitTime(3.8);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		ClearActors(new List<LogicEntity> { _actor });
	}
}
