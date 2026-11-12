using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_4_7 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_1 = 8069902;

	private readonly int MonsterID_2 = 8069904;

	private readonly int MonsterID_3 = 8070401;

	private readonly int MonsterID_4 = 8070402;

	private readonly int MonsterID_5 = 8080403;

	private readonly int MonsterID_6 = 8069901;

	private readonly int MonsterID_7 = 8069903;

	private readonly int CommonRouteID_1;

	private readonly int CommonRouteID_2 = 1;

	private readonly int CommonRouteID_3 = 2;

	private readonly int CommonRouteID_4 = 3;

	private readonly int CommonRouteID_5 = 4;

	private readonly int CommonRouteID_6 = 5;

	private readonly int CommonRouteID_7 = 6;

	private readonly int CommonRouteID_8 = 7;

	private readonly int SpawnPointID_1 = 48;

	private readonly int SpawnPointID_2 = 66;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 15 },
		{ 1, 15 },
		{ 2, 19 },
		{ 3, 14 },
		{ 4, 14 },
		{ 5, 16 },
		{ 6, 28 },
		{ 7, 30 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_1, CommonRouteID_2, 5, new List<int> { MonsterID_7 }, -90, 4);
		AddGroupToWave(1, 2, SpawnPointID_1, CommonRouteID_2, 5, new List<int> { MonsterID_6 }, -90, 4);
		AddGroupToWave(1, 3, SpawnPointID_1, CommonRouteID_3, 1, new List<int> { MonsterID_3 }, -90, 0);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_2, CommonRouteID_4, 6, new List<int> { MonsterID_3, MonsterID_4 }, 90, 8);
		AddGroupToWave(2, 2, SpawnPointID_2, CommonRouteID_6, 3, new List<int> { MonsterID_4 }, -90, 15);
		AddGroupToWave(2, 3, SpawnPointID_2, CommonRouteID_8, 1, new List<int> { MonsterID_5 }, -90, 0);
		AddWave(3);
		AddGroupToWave(3, 1, SpawnPointID_2, CommonRouteID_7, 1, new List<int> { MonsterID_5 }, 90, 0);
		AddGroupToWave(3, 2, SpawnPointID_1, CommonRouteID_1, 12, new List<int> { MonsterID_1, MonsterID_2 }, -90, 3);
		AddGroupToWave(3, 3, SpawnPointID_1, CommonRouteID_3, 3, new List<int> { MonsterID_3 }, -90, 15);
		AddGroupToWave(3, 4, SpawnPointID_2, CommonRouteID_6, 3, new List<int> { MonsterID_4 }, -90, 8);
		AddGroupToWave(3, 5, SpawnPointID_2, CommonRouteID_5, 12, new List<int> { MonsterID_1, MonsterID_2 }, -90, 3);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2, MonsterID_3, MonsterID_4, MonsterID_5, MonsterID_6, MonsterID_7 });
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_2 }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitUntil_GroupClear(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_2, CommonRouteID_3 }, IsSameTime: true));
		ActiveGroup(2);
		ActiveGroup(3);
		GiveARoleCard();
		yield return WaitUntil_WaveClear();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_8 }, IsSameTime: false));
		ActiveWave(2);
		ActiveGroup(3);
		yield return WaitTime(5);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_4, CommonRouteID_6 }, IsSameTime: false));
		ActiveGroup(1);
		yield return WaitTime(10);
		GiveARoleCard();
		ActiveGroup(2);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		yield return WaitTime(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_7 }, IsSameTime: false));
		ActiveWave(3);
		ActiveGroup(1);
		yield return WaitTime(3);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1, CommonRouteID_3 }, IsSameTime: true));
		ActiveGroup(2);
		ActiveGroup(3);
		yield return WaitUntil_GroupClear(2);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_5, CommonRouteID_6 }, IsSameTime: true));
		ActiveGroup(4);
		ActiveGroup(5);
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
