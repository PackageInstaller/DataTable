using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[CreateAssetMenu(fileName = "TowerConfig", menuName = "Ase/TowerConfig", order = 0)]
public class TowerConfig : ScriptableObject
{
	public List<TowerFloorData> FloorConfigs = new List<TowerFloorData>();

	public Vector4 OriginPos;

	public TowerFloorData EndlessNormalFloorData;

	public TowerFloorData EndlessBossFloorData;

	public int EndlessDifficultyFactor;

	public int BossLayerInterval;

	public MonsterStrengthConfig HpStrengthConfig;

	public MonsterStrengthConfig AttackStrengthConfig;

	public MonsterStrengthConfig TenacityStrengthConfig;

	public MonsterStrengthConfig RecudeTenacityStrengthConfig;
}
