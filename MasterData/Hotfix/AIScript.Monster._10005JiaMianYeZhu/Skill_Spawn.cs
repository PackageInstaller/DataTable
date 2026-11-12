using System.Collections;

namespace AIScript.Monster._10005JiaMianYeZhu;

public class Skill_Spawn : SkillSimpleBase
{
	private bool IsSearching;

	protected override IEnumerator DoMainLogic()
	{
		IsSearching = true;
		while (IsSearching)
		{
			LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
			if (CheckTargetIsValid(attackTarget) && Distance(GetPosition(), GetEntityPositionObsoleted(attackTarget)) < 18)
			{
				IsSearching = false;
			}
			yield return null;
		}
		ShowCenterHpBar();
		TriggerOpLisener("Bubble1");
	}
}
