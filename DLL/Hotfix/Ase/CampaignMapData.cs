using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class CampaignMapData : ScriptableObject
{
	public List<Vector3> bornPos;

	public List<Vector3> bornAngle;

	public bool countdownWin;

	public float countdownWinTime;

	public bool countdownLose;

	public float countdownLoseTime;

	public List<CampaignMonsterGroupData> monsterGroupDatas;

	public List<CampaignPreloadMonsterCountData> preloadMonsterCounts;

	public List<CampaignTriggerData> triggerDatas;

	public List<CampaignBuffData> buffDatas;

	public List<CampaignAirWallData> ariWallDatas;
}
