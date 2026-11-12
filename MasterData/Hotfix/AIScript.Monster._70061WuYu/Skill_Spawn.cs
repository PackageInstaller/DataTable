using System.Collections;
using TrueSync;

namespace AIScript.Monster._70061WuYu;

public class Skill_Spawn : SkillSimpleBase
{
	protected TSVector2 TargetPosition;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		if (attackTarget != null)
		{
			TargetPosition = GetEntityPosition(attackTarget);
		}
		while (attackTarget != null && Distance(TargetPosition, GetPosition()) >= 12)
		{
			yield return WaitFrame(3);
			attackTarget = GetAttackTarget(isUpToDate: true);
			if (attackTarget != null)
			{
				TargetPosition = GetEntityPosition(attackTarget);
			}
		}
		SetBattleOutDisable();
		ShowCenterHpBar();
		yield return WaitFrame(60);
	}
}
