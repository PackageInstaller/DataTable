using System.Collections;
using TrueSync;

namespace AIScript.Monster._50511TaLou;

public class Skill_Spawn_F : SkillSimpleBase
{
	protected readonly FP disWithPlayer = 18;

	protected readonly int buffId = 990010050;

	private bool IsSearching;

	protected TSVector2 TargetPosition;

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
		RemoveBuffFromTarget(_actor, buffId);
		ShowCenterHpBar();
	}
}
