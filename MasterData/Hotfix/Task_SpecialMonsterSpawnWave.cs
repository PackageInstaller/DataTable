using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("触发器结果/怪物与陷阱/特殊刷怪波次激活(刷新怪出生位置等)", 0)]
public class Task_SpecialMonsterSpawnWave : TaskCellBase
{
	public string waveId;

	public List<WaveCfg> waves = new List<WaveCfg>();

	protected override void OnExecute()
	{
		List<BaseSpawnPointGizmo> list = ModuleController<AdventureModuleController>.Instance.GetWaves(waveId);
		if (list == null || list.Count == 0)
		{
			Debug.LogError("没有获取到目标怪物出生Wave:" + waveId);
			EndAction(success: false);
			return;
		}
		if (waves.Count == 0)
		{
			Debug.LogError("出生配置为空");
			EndAction(success: false);
			return;
		}
		int num = 0;
		int count = waves.Count;
		for (int i = 0; i < list.Count; i++)
		{
			MonsterSpawnWaveGizmo monsterSpawnWaveGizmo = list.get_Item(i) as MonsterSpawnWaveGizmo;
			if (monsterSpawnWaveGizmo != null)
			{
				MonsterSpawnPointGizmo[] componentsInChildren = monsterSpawnWaveGizmo.GetComponentsInChildren<MonsterSpawnPointGizmo>();
				for (int j = 0; j < componentsInChildren.Length; j++)
				{
					componentsInChildren[j].waveCfg = waves.get_Item(num);
					num = ++num % count;
				}
			}
		}
		EndAction();
	}
}
