using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_3_5 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_1 = 8069902;

	private readonly int MonsterID_2 = 8069904;

	private readonly int MonsterID_3 = 8079904;

	private readonly int MonsterID_4 = 8089903;

	private readonly int MonsterID_5 = 8069905;

	private readonly int CommonRouteID_1;

	private readonly int CommonRouteID_2 = 1;

	private readonly int CommonRouteID_3 = 2;

	private readonly int CommonRouteID_4 = 3;

	private readonly int SpawnPointID = 10;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 14 },
		{ 1, 17 },
		{ 2, 25 },
		{ 3, 39 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID, CommonRouteID_1, 8, new List<int> { MonsterID_1 }, 180, 8);
		AddGroupToWave(1, 2, SpawnPointID, CommonRouteID_2, 8, new List<int> { MonsterID_2 }, 180, 8);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID, CommonRouteID_4, 1, new List<int> { MonsterID_4 }, 180, 0);
		AddGroupToWave(2, 2, SpawnPointID, CommonRouteID_3, 6, new List<int> { MonsterID_3 }, 180, 15);
		AddGroupToWave(2, 3, SpawnPointID, CommonRouteID_1, 20, new List<int> { MonsterID_1 }, 180, 4);
		AddGroupToWave(2, 4, SpawnPointID, CommonRouteID_2, 8, new List<int> { MonsterID_2 }, 180, 5);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2, MonsterID_3, MonsterID_4 });
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1, CommonRouteID_2 }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitTime(25);
		ActiveGroup(2);
		yield return WaitUntil_WaveClear();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_3, CommonRouteID_4 }, IsSameTime: false));
		ActiveWave(2);
		ActiveGroup(1);
		yield return WaitTime(2);
		ActiveGroup(2);
		yield return WaitTime(10);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1, CommonRouteID_2 }, IsSameTime: false));
		ActiveGroup(3);
		yield return WaitTime(1);
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
