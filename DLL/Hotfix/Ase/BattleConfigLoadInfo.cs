using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class BattleConfigLoadInfo
{
	public int curWaveIndex;

	public List<TowerFloorMonsterWaveData> MonsterWaves;

	public bool LoadAllWaves;

	public bool CurWaveLoadFinish;

	public int SurviveMonsterCount;

	public string TowerMarkStr;

	public List<Vector4> ScenePoint;

	public float CurWaveDifficultyFactor = 1f;

	public List<WaveMonsterLoadData> WaveMonsterLoadDatas = new List<WaveMonsterLoadData>(10);

	public BattleConfigLoadInfo(string markStr)
	{
		TowerMarkStr = markStr;
	}

	public bool BattleStageEnd()
	{
		if (CurWaveLoadFinish && LoadAllWaves)
		{
			return SurviveMonsterCount <= 0;
		}
		return false;
	}

	public void Clear()
	{
		curWaveIndex = 0;
		MonsterWaves = null;
		LoadAllWaves = false;
		CurWaveLoadFinish = false;
		SurviveMonsterCount = 0;
	}
}
