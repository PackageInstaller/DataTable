using System;
using UnityEngine;

namespace Ase;

[Serializable]
public class TowerFloorData
{
	public string SceneName;

	public int NavMesh;

	public int[] EnvironmentBuff;

	public Vector4[] HeroPoints;

	public Vector4[] ScenePoints;

	public bool IsBossFloor;

	public int BattleTimeLineId;

	public int BattleDuration;

	public int RestDuration;

	public TowerFloorStageData NewBattleBeforeConfig = new TowerFloorStageData();

	public TowerFloorStageData NewBattleConfig = new TowerFloorStageData();

	public FloorNodeData[] BattleEndNodes;

	public bool OpenRandomBuff;

	public int RandomPoolId;

	public int ShowBuffCount;

	public int GetBuffCount;

	public bool OpenResetRefresh;

	public int RefreshCount;
}
