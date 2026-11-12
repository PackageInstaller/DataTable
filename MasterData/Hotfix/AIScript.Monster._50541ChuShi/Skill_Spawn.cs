using System.Collections;
using TrueSync;

namespace AIScript.Monster._50541ChuShi;

public class Skill_Spawn : SkillSimpleBase
{
	private bool IsSearching;

	private FP SearchDistance;

	protected override IEnumerator DoMainLogic()
	{
		IsSearching = true;
		SetBattleOutEnable();
		SetLogicTagToggleValue(_actor, "IsUltra", value: false);
		SetLogicTagToggleValue(_actor, "IsCallKnife", value: false);
		while (IsSearching)
		{
			LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
			if (CheckTargetIsValid(attackTarget))
			{
				SearchDistance = Distance(GetPosition(), GetEntityPositionObsoleted(attackTarget));
				if (SearchDistance < 18)
				{
					IsSearching = false;
				}
			}
			yield return null;
		}
		SetBattleOutDisable();
		ShowCenterHpBar();
	}
}
