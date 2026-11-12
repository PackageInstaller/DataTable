using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Fire._50181ShunYiGuai;

public class Fire_Attack05_SpawnKill : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack05 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	private LogicEntity Targetenemy;

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAtByPos_NotWait(new TSVector2(0, 0), 0.1, 9999);
		yield return WaitFrame(6);
		BeginAttack(1, Attack05, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(22);
		BeginRotateAngle_NotWait(720, 35);
		yield return WaitFrame(320);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		ClearActors(new List<LogicEntity> { _actor });
	}
}
