using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_5_8 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_1 = 8069902;

	private readonly int MonsterID_2 = 8069904;

	private readonly int MonsterID_3 = 8070502;

	private readonly int MonsterID_4 = 8080501;

	private readonly int MonsterID_5 = 8069901;

	private readonly int MonsterID_6 = 8069903;

	private readonly int MonsterID_7 = 8070501;

	private readonly int CommonRouteID_1 = 1;

	private readonly int CommonRouteID_2 = 2;

	private readonly int CommonRouteID_3 = 3;

	private readonly int CommonRouteID_4 = 4;

	private readonly int CommonRouteID_5 = 5;

	private readonly int CommonRouteID_6 = 6;

	private readonly int CommonRouteID_7 = 7;

	private readonly int CommonRouteID_8 = 8;

	private readonly int SpawnPointID_1 = 42;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 1, 16 },
		{ 2, 22 },
		{ 3, 15 },
		{ 4, 35 },
		{ 5, 9 },
		{ 6, 19 },
		{ 7, 33 },
		{ 8, 21 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_1, CommonRouteID_1, 5, new List<int> { MonsterID_5 }, 90, 4);
		AddGroupToWave(1, 2, SpawnPointID_1, CommonRouteID_1, 5, new List<int> { MonsterID_6 }, 90, 4);
		AddGroupToWave(1, 3, SpawnPointID_1, CommonRouteID_2, 1, new List<int> { MonsterID_3 }, 0, 0);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_1, CommonRouteID_3, 6, new List<int> { MonsterID_1 }, 0, 5);
		AddGroupToWave(2, 2, SpawnPointID_1, CommonRouteID_6, 1, new List<int> { MonsterID_7 }, -90, 0);
		AddGroupToWave(2, 3, SpawnPointID_1, CommonRouteID_3, 6, new List<int> { MonsterID_2 }, 0, 4);
		AddGroupToWave(2, 4, SpawnPointID_1, CommonRouteID_7, 1, new List<int> { MonsterID_4 }, 0, 0);
		AddGroupToWave(2, 5, SpawnPointID_1, CommonRouteID_4, 1, new List<int> { MonsterID_4 }, 0, 0);
		AddGroupToWave(2, 6, SpawnPointID_1, CommonRouteID_1, 16, new List<int> { MonsterID_1, MonsterID_2 }, 90, 4);
		AddGroupToWave(2, 7, SpawnPointID_1, CommonRouteID_8, 4, new List<int> { MonsterID_3 }, 0, 20);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2, MonsterID_3, MonsterID_4, MonsterID_5, MonsterID_6, MonsterID_7 });
		SetLighthouseActive(19, active: false);
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return WaitTime(2);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1 }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitUntil_GroupClear(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1, CommonRouteID_2 }, IsSameTime: true));
		ActiveGroup(2);
		ActiveGroup(3);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_7 }, IsSameTime: false));
		ActiveWave(2);
		ActiveGroup(4);
		yield return WaitTime(7);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_3, CommonRouteID_6 }, IsSameTime: true));
		ActiveGroup(1);
		yield return WaitTime(1.5);
		ActiveGroup(2);
		yield return WaitUntil_GroupClear(1);
		ActiveGroup(3);
		yield return WaitUntil_GroupClear(3);
		yield return WaitTime(12);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_4, CommonRouteID_8 }, IsSameTime: false));
		ActiveGroup(5);
		yield return WaitTime(1.5);
		GiveARoleCard();
		ActiveGroup(7);
		yield return WaitTime(20);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1 }, IsSameTime: false));
		ActiveGroup(6);
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
