using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("Game/Adventure/Gizmo/Virtual Monster Spawn Wave")]
public class VirtualMonsterSpawnWaveGizmo : BaseSpawnPointGizmo
{
	public override void Initialize(int x, int y)
	{
		base.Initialize(x, y);
		childrenGizmos = new List<BaseSpawnPointGizmo>();
		MonsterSpawnPointGizmo[] componentsInChildren = GetComponentsInChildren<MonsterSpawnPointGizmo>();
		foreach (MonsterSpawnPointGizmo monsterSpawnPointGizmo in componentsInChildren)
		{
			if (monsterSpawnPointGizmo.isActiveAndEnabled)
			{
				childrenGizmos.Add(monsterSpawnPointGizmo);
			}
		}
		childrenGizmos.Sort();
		for (int j = 0; j < childrenGizmos.Count; j++)
		{
			childrenGizmos.get_Item(j).Initialize(x, y);
		}
	}
}
