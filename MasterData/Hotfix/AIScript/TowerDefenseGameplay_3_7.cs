using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_3_7 : TowerDefenseGameplayBase
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

	private readonly int SpawnPointID_1 = 12;

	private readonly int SpawnPointID_2 = 52;

	private readonly int SpawnPointID_3 = 19;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 24 },
		{ 1, 17 },
		{ 2, 29 },
		{ 3, 40 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_2, CommonRouteID_3, 1, new List<int> { MonsterID_4 }, 0, 0);
		AddGroupToWave(1, 2, SpawnPointID_3, CommonRouteID_4, 1, new List<int> { MonsterID_4 }, -90, 0);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_1, CommonRouteID_1, 6, new List<int> { MonsterID_6 }, 180, 6);
		AddGroupToWave(2, 2, SpawnPointID_1, CommonRouteID_2, 6, new List<int> { MonsterID_7 }, 180, 4);
		AddGroupToWave(2, 3, SpawnPointID_1, CommonRouteID_1, 1, new List<int> { MonsterID_3 }, 180, 0);
		AddWave(3);
		AddGroupToWave(3, 1, SpawnPointID_1, CommonRouteID_1, 20, new List<int> { MonsterID_1, MonsterID_2 }, 180, 4);
		AddGroupToWave(3, 2, SpawnPointID_1, CommonRouteID_2, 1, new List<int> { MonsterID_3 }, 180, 0);
		AddGroupToWave(3, 3, SpawnPointID_1, CommonRouteID_2, 4, new List<int> { MonsterID_1, MonsterID_2 }, 180, 8);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2, MonsterID_3, MonsterID_4 });
	}

	internal override IEnumerator DoMainLogic()
	{
		ActiveWave(1);
		ActiveGroup(1);
		ActiveGroup(2);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_3, CommonRouteID_4 }, IsSameTime: false));
		yield return WaitTime(3);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1, CommonRouteID_2 }, IsSameTime: false));
		ActiveWave(2);
		ActiveGroup(1);
		yield return WaitTime(2);
		ActiveGroup(2);
		ActiveGroup(3);
		yield return WaitTime(5);
		GiveARoleCard();
		yield return WaitUntil_GroupClear(2);
		GiveARoleCard();
		yield return WaitUntil_WaveClear();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1, CommonRouteID_2 }, IsSameTime: false));
		ActiveWave(3);
		ActiveGroup(1);
		yield return WaitTime(1);
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
