using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("触发器结果/怪物与陷阱/激活指定刷怪容器列表", 1)]
public class Task_MonsterSpawnList : TaskCellBase
{
	public enum MonsterSpawnType
	{
		Wave,
		Plan,
		Group
	}

	public MonsterSpawnType monsterSpawnType;

	public List<string> targetNames;

	private int curIndex;

	protected override void OnExecute()
	{
		if (targetNames == null || targetNames.Count == 0)
		{
			EndAction(success: false);
			return;
		}
		if (curIndex >= targetNames.Count)
		{
			EndAction(success: false);
			Debug.Log("触发器" + name + "目标已全部激活!");
			return;
		}
		string waveName = targetNames.get_Item(curIndex);
		curIndex++;
		List<BaseSpawnPointGizmo> waves = ModuleController<AdventureModuleController>.Instance.GetWaves(waveName);
		if (waves == null || waves.Count == 0)
		{
			EndAction(success: false);
			return;
		}
		if (monsterSpawnType == MonsterSpawnType.Plan)
		{
			for (int i = 0; i < waves.Count; i++)
			{
				BaseSpawnPointGizmo baseSpawnPointGizmo = waves.get_Item(i);
				if (!baseSpawnPointGizmo.IsAllActived())
				{
					baseSpawnPointGizmo.EnableSpawnLogic();
				}
			}
		}
		else
		{
			for (int j = 0; j < waves.Count; j++)
			{
				MonsterSpawnWaveGizmo monsterSpawnWaveGizmo = waves.get_Item(j) as MonsterSpawnWaveGizmo;
				if (monsterSpawnWaveGizmo.isTriggerActived && !monsterSpawnWaveGizmo.IsAllActived())
				{
					if (monsterSpawnWaveGizmo is RandomMonsterSpawnWaveGizmo)
					{
						monsterSpawnWaveGizmo.ExecuteSpawnLogic();
					}
					else
					{
						monsterSpawnWaveGizmo.EnableSpawnLogic();
					}
				}
			}
		}
		EndAction();
	}
}
