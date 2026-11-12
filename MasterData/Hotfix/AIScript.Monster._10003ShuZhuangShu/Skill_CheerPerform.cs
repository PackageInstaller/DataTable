using System.Collections;

namespace AIScript.Monster._10003ShuZhuangShu;

public class Skill_CheerPerform : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Cheer_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected override IEnumerator DoMainLogic()
	{
		SetBattleOutEnable();
		while (Distance(GetEntityPositionObsoleted(GetCurrentPlayer()), GetPosition()) > 18)
		{
			yield return null;
		}
		TriggerOpLisener("BattleStart");
		while (true)
		{
			BeginAttack(1, Cheer_Combo, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(6);
		}
	}
}
