using System.Collections.Generic;
using TrueSync;
using UnityEngine;

namespace AIScript;

public interface ITowerDefenseGameplayHost
{
	TowerDefenseMapData MapData { get; }

	TowerDefenseMapData.TowerGrid GetGrid(int index);

	TowerDefenseMapData.TowerGrid GetGrid(int x, int y);

	TowerDefenseMapData.TowerGrid GetGrid(Vector3 worldPosition);

	AdventureFXPlayer PlayEffect(string path, Vector3 position);

	List<int> GetItemTakeEffectGrids(int index);

	bool TryGetRoleIdByGrid(int gridIndex, out int roleId);

	bool TryGetGridIndexByRoleId(int roleId, out int gridIndex);

	bool TryGetRoleEffectiveSearchRange(int roleId, out FP range);

	void RemoveRoleBuff(int roleId, int buffId);
}
