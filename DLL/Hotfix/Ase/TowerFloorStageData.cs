using System;
using System.Collections.Generic;

namespace Ase;

[Serializable]
public class TowerFloorStageData
{
	public List<FloorNodeData> InteractNodes = new List<FloorNodeData>();

	public List<TowerFloorMonsterWaveData> MonsterWaves = new List<TowerFloorMonsterWaveData>();
}
