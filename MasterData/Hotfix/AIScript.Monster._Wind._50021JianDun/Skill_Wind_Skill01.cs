using System.Collections;

namespace AIScript.Monster._Wind._50021JianDun;

public class Skill_Wind_Skill01 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true);
		yield return WaitCustomEvent("R1");
		DoTrace();
		yield return WaitTraceFinish();
		RemoveBuffFromTarget(_actor, 500210010);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected void DoTrace()
	{
		int num = 3;
		int num2 = -1;
		int num3 = 5;
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		AddBuffToTarget(_actor, 500210010);
		BeginTrace(logicEntity, num, num2, num3);
	}
}
