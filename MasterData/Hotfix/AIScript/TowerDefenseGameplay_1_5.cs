using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_1_5 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_CommonMonster = 8069901;

	private readonly int MonsterID_CommonMonster_Plus = 8069902;

	private readonly int MonsterID_FastMonster = 8069903;

	private readonly int MonsterID_FastMonster_Plus = 8069904;

	private readonly int MonsterID_SpeedUpMonster = 8079902;

	private readonly int MonsterID_HardMonster = 8079901;

	private readonly int CommonRouteID_Up;

	private readonly int CommonRouteID_Down = 1;

	private readonly int SurroundRouteID_Up = 10;

	private readonly int SurroundRouteID_Down = 11;

	private readonly int SpawnPointID = 30;

	private Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 12 },
		{ 1, 12 },
		{ 10, 28 },
		{ 11, 28 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID, CommonRouteID_Up, 5, new List<int> { MonsterID_CommonMonster }, -90, 8);
		AddGroupToWave(1, 2, SpawnPointID, CommonRouteID_Down, 5, new List<int> { MonsterID_CommonMonster }, -90, 8);
		AddGroupToWave(1, 3, SpawnPointID, CommonRouteID_Up, 3, new List<int> { MonsterID_FastMonster }, -90, 8);
		AddGroupToWave(1, 4, SpawnPointID, CommonRouteID_Down, 3, new List<int> { MonsterID_FastMonster }, -90, 8);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID, SurroundRouteID_Down, 2, new List<int> { MonsterID_HardMonster }, -90, 20);
		AddGroupToWave(2, 2, SpawnPointID, SurroundRouteID_Up, 8, new List<int> { MonsterID_SpeedUpMonster }, -90, 8);
		AddGroupToWave(2, 3, SpawnPointID, CommonRouteID_Down, 10, new List<int> { MonsterID_CommonMonster_Plus, MonsterID_FastMonster_Plus }, -90, 5);
		AddGroupToWave(2, 4, SpawnPointID, SurroundRouteID_Down, 6, new List<int> { MonsterID_SpeedUpMonster }, -90, 8);
		PreloadMonster(new List<int> { MonsterID_CommonMonster, MonsterID_CommonMonster_Plus, MonsterID_FastMonster, MonsterID_FastMonster_Plus, MonsterID_SpeedUpMonster, MonsterID_HardMonster });
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Up, CommonRouteID_Down }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitTime(4);
		ActiveGroup(2);
		yield return WaitTime(12);
		ActiveGroup(3);
		yield return WaitTime(4);
		ActiveGroup(4);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { SurroundRouteID_Up, SurroundRouteID_Down }, IsSameTime: false));
		ActiveWave(2);
		ActiveGroup(1);
		yield return WaitTime(2);
		ActiveGroup(2);
		yield return WaitTime(12);
		ActiveGroup(3);
		yield return WaitTime(9);
		ActiveGroup(4);
	}

	private IEnumerator ShowRouteFlows(List<int> RouteList, bool IsSameTime)
	{
		yield return WaitTime(2);
		foreach (int Route in RouteList)
		{
			FP fP = (FP)RouteDic.get_Item(Route) / (FP)4;
			ShowRoute(Route, (float)fP);
			if (!IsSameTime)
			{
				if (fP > 1)
				{
					yield return WaitTime(fP - 2);
				}
				else
				{
					yield return WaitTime(fP);
				}
			}
		}
		yield return WaitTime(3);
	}
}
