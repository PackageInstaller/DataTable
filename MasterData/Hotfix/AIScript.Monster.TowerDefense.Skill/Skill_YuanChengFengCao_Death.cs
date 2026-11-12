using System.Collections;

namespace AIScript.Monster.TowerDefense.Skill;

public class Skill_YuanChengFengCao_Death : TowerMonsterSkillBase
{
	protected override IEnumerator DoMainLogic()
	{
		_actor.PlayDeathAnim();
		BeginAttack(1, "Die", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		Dispatch_GetNextGridInfo((MonsterRecGridInfo gridInfo) =>
		{
			if (gridInfo.curGridDeployType != GridDeployType.TrapSpawnPoint)
			{
				Dispatch_CreateGrass(gridInfo.curGridIndex);
			}
		});
		yield return WaitTime(1);
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
	}
}
