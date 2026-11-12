using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("触发器结果/怪物与陷阱/操作刷怪容器", 0)]
public class Task_MonsterSpawn : TaskCellBase
{
	public enum OpenType
	{
		[InspectorName("激活")]
		active,
		[InspectorName("关闭")]
		close,
		[InspectorName("杀死")]
		kill,
		[InspectorName("使怪物进入战斗")]
		Action
	}

	public enum MonsterSpawnType
	{
		Wave,
		Plan,
		Group
	}

	public MonsterSpawnType monsterSpawnType;

	public string targetName;

	public OpenType openType;

	protected override void OnExecute()
	{
		if (monsterSpawnType == MonsterSpawnType.Plan)
		{
			List<BaseSpawnPointGizmo> plans = ModuleController<AdventureModuleController>.Instance.GetPlans(targetName);
			if (plans == null || plans.Count == 0)
			{
				Debug.LogError("没有获取到目标怪物出生Plan:" + targetName);
				EndAction(success: false);
				return;
			}
			for (int i = 0; i < plans.Count; i++)
			{
				BaseSpawnPointGizmo baseSpawnPointGizmo = plans.get_Item(i);
				switch (openType)
				{
				case OpenType.active:
					if (!baseSpawnPointGizmo.IsAllActived())
					{
						baseSpawnPointGizmo.EnableSpawnLogic();
					}
					break;
				case OpenType.close:
					baseSpawnPointGizmo.DisableSpawnLogic();
					break;
				case OpenType.kill:
					baseSpawnPointGizmo.KillAllSummoners();
					break;
				case OpenType.Action:
					baseSpawnPointGizmo.SpawnMonsterEnterAction();
					break;
				}
			}
		}
		else if (monsterSpawnType == MonsterSpawnType.Wave)
		{
			List<BaseSpawnPointGizmo> waves = ModuleController<AdventureModuleController>.Instance.GetWaves(targetName);
			if (waves == null || waves.Count == 0)
			{
				Debug.LogError("没有获取到目标怪物出生Wave:" + targetName);
				EndAction(success: false);
				return;
			}
			for (int j = 0; j < waves.Count; j++)
			{
				MonsterSpawnWaveGizmo monsterSpawnWaveGizmo = waves.get_Item(j) as MonsterSpawnWaveGizmo;
				if (null == monsterSpawnWaveGizmo)
				{
					continue;
				}
				switch (openType)
				{
				case OpenType.active:
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
					break;
				case OpenType.kill:
					monsterSpawnWaveGizmo.KillAllSummoners();
					break;
				case OpenType.Action:
					monsterSpawnWaveGizmo.SpawnMonsterEnterAction();
					break;
				case OpenType.close:
					monsterSpawnWaveGizmo.DisableSpawnLogic();
					break;
				}
			}
		}
		else
		{
			List<BaseSpawnPointGizmo> groups = ModuleController<AdventureModuleController>.Instance.GetGroups(targetName);
			if (groups == null || groups.Count == 0)
			{
				Debug.LogError("没有获取到目标怪物出生Plan:" + targetName);
				EndAction(success: false);
				return;
			}
			for (int k = 0; k < groups.Count; k++)
			{
				BaseSpawnPointGizmo baseSpawnPointGizmo2 = groups.get_Item(k);
				switch (openType)
				{
				case OpenType.active:
					if (!baseSpawnPointGizmo2.IsAllActived())
					{
						baseSpawnPointGizmo2.EnableSpawnLogic();
					}
					break;
				case OpenType.close:
					baseSpawnPointGizmo2.DisableSpawnLogic();
					break;
				case OpenType.kill:
					baseSpawnPointGizmo2.KillAllSummoners();
					break;
				case OpenType.Action:
					baseSpawnPointGizmo2.SpawnMonsterEnterAction();
					break;
				}
			}
		}
		EndAction();
	}
}
