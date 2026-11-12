using System.Collections;

namespace AIScript.Monster.TowerDefense.Skill;

public class Skill_ShuZhuangShu_GrowGrass : TowerMonsterSkillBase
{
	private int cdDeployTypetrue;

	private int lcDeployTypetrue;

	private int rcDeployTypetrue;

	private int cuDeployTypetrue;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		cdDeployTypetrue = 0;
		lcDeployTypetrue = 0;
		rcDeployTypetrue = 0;
		cuDeployTypetrue = 0;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		RemoveBuffFromTarget(_actor, 809001220);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		Dispatch_GetNextGridInfo((MonsterRecGridInfo gridInfo) =>
		{
			Dispatch_ClearGrass(gridInfo.ccIndex);
			if (cdDeployTypetrue == 1)
			{
				Dispatch_ClearGrass(gridInfo.cdIndex);
			}
			if (lcDeployTypetrue == 1)
			{
				Dispatch_ClearGrass(gridInfo.lcIndex);
			}
			if (rcDeployTypetrue == 1)
			{
				Dispatch_ClearGrass(gridInfo.rcIndex);
			}
			if (cuDeployTypetrue == 1)
			{
				Dispatch_ClearGrass(gridInfo.cuIndex);
			}
		});
		_skill?.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "Skill", flushInputedKeys: true, forceInterruptAttack: true);
		AddBuffToTarget(_actor, 809001220);
		yield return WaitCustomEvent("LoopStart");
		Dispatch_GetNextGridInfo((MonsterRecGridInfo gridInfo) =>
		{
			Dispatch_CreateGrass(gridInfo.ccIndex);
			if (gridInfo.cdDeployType != GridDeployType.TrapSpawnPoint && gridInfo.cdDeployType != GridDeployType.Pothole && gridInfo.cdDeployType != GridDeployType.Deephole && gridInfo.cdWalkableType == GridWalkableType.Walkable)
			{
				cdDeployTypetrue = 1;
				Dispatch_CreateGrass(gridInfo.cdIndex);
			}
			if (gridInfo.lcDeployType != GridDeployType.TrapSpawnPoint && gridInfo.lcDeployType != GridDeployType.Pothole && gridInfo.lcDeployType != GridDeployType.Deephole && gridInfo.lcWalkableType == GridWalkableType.Walkable)
			{
				lcDeployTypetrue = 1;
				Dispatch_CreateGrass(gridInfo.lcIndex);
			}
			if (gridInfo.rcDeployType != GridDeployType.TrapSpawnPoint && gridInfo.rcDeployType != GridDeployType.Pothole && gridInfo.rcDeployType != GridDeployType.Deephole && gridInfo.rcWalkableType == GridWalkableType.Walkable)
			{
				rcDeployTypetrue = 1;
				Dispatch_CreateGrass(gridInfo.rcIndex);
			}
			if (gridInfo.cuDeployType != GridDeployType.TrapSpawnPoint && gridInfo.cuDeployType != GridDeployType.Pothole && gridInfo.cuDeployType != GridDeployType.Deephole && gridInfo.cuWalkableType == GridWalkableType.Walkable)
			{
				cuDeployTypetrue = 1;
				Dispatch_CreateGrass(gridInfo.cuIndex);
			}
		});
		yield return WaitFrame(72);
		CancelAttack();
		RemoveBuffFromTarget(_actor, 809001220);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
