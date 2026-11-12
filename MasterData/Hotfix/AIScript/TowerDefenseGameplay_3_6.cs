using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_3_6 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_1 = 8069902;

	private readonly int MonsterID_2 = 8069904;

	private readonly int MonsterID_3 = 8079904;

	private readonly int MonsterID_4 = 8089903;

	private readonly int MonsterID_5 = 8069905;

	private readonly int MonsterID_6 = 8069901;

	private readonly int MonsterID_7 = 8069903;

	private readonly int CommonRouteID_1;

	private readonly int CommonRouteID_2 = 1;

	private readonly int CommonRouteID_3 = 2;

	private readonly int CommonRouteID_4 = 3;

	private readonly int CommonRouteID_5 = 4;

	private readonly int SpawnPointID_1 = 21;

	private readonly int SpawnPointID_2 = 5;

	private readonly int SpawnPointID_3 = 21;

	private readonly int SpawnPointID_4 = 5;

	private readonly int SpawnPointID_5 = 49;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 15 },
		{ 1, 13 },
		{ 2, 25 },
		{ 3, 27 },
		{ 4, 15 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_1, CommonRouteID_1, 8, new List<int> { MonsterID_6 }, -90, 3);
		AddGroupToWave(1, 2, SpawnPointID_2, CommonRouteID_2, 5, new List<int> { MonsterID_7 }, 0, 4);
		AddGroupToWave(1, 3, SpawnPointID_5, CommonRouteID_5, 1, new List<int> { MonsterID_4 }, 90, 0);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_3, CommonRouteID_3, 12, new List<int> { MonsterID_1, MonsterID_2 }, -90, 4);
		AddGroupToWave(2, 2, SpawnPointID_4, CommonRouteID_4, 6, new List<int> { MonsterID_3 }, 0, 10);
		AddGroupToWave(2, 3, SpawnPointID_1, CommonRouteID_1, 10, new List<int> { MonsterID_2, MonsterID_1 }, 0, 3);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2, MonsterID_3, MonsterID_4 });
	}

	internal override IEnumerator DoMainLogic()
	{
		ActiveWave(1);
		ActiveGroup(3);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1, CommonRouteID_2, CommonRouteID_5 }, IsSameTime: false));
		ActiveGroup(1);
		ActiveGroup(2);
		yield return WaitTime(12);
		GiveARoleCard();
		yield return WaitUntil_GroupClear(1);
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1, CommonRouteID_3, CommonRouteID_4 }, IsSameTime: false));
		ActiveWave(2);
		ActiveGroup(1);
		ActiveGroup(2);
		ActiveGroup(3);
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
