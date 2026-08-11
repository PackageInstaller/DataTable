using System;
using System.Collections.Generic;

namespace Ase;

[Serializable]
public class TowerFloorMonsterWaveData
{
	public bool OpenRandomMonster;

	public int RandomMonsterPoolId;

	public int MonsterCapacity;

	public float DifficultyFactor;

	public int AttackCtrlCount;

	public List<FloorNodeData> MonsterNodes = new List<FloorNodeData>();
}
