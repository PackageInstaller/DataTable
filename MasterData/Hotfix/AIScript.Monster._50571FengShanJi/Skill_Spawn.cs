using System.Collections;

namespace AIScript.Monster._50571FengShanJi;

public class Skill_Spawn : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Spawn_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	protected override IEnumerator DoMainLogic()
	{
		SetBattleOutEnable();
		GetAttackTarget(isUpToDate: true);
		while (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= 9)
		{
			yield return null;
		}
		SetBattleOutDisable();
		ShowCenterHpBar();
	}
}
