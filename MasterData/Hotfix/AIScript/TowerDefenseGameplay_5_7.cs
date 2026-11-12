using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_5_7 : TowerDefenseGameplayBase
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

	private readonly int CommonRouteID_9 = 9;

	private readonly int SpawnPointID_1 = 1;

	private readonly int SpawnPointID_2 = 60;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 1, 18 },
		{ 2, 16 },
		{ 3, 18 },
		{ 4, 18 },
		{ 5, 20 },
		{ 6, 36 },
		{ 7, 24 },
		{ 8, 18 },
		{ 9, 18 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_1, CommonRouteID_2, 5, new List<int> { MonsterID_5 }, 0, 4);
		AddGroupToWave(1, 2, SpawnPointID_1, CommonRouteID_2, 9, new List<int> { MonsterID_6 }, 0, 4);
		AddGroupToWave(1, 3, SpawnPointID_2, CommonRouteID_4, 1, new List<int> { MonsterID_3 }, -90, 0);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_2, CommonRouteID_9, 12, new List<int> { MonsterID_1, MonsterID_2 }, -90, 8);
		AddGroupToWave(2, 2, SpawnPointID_2, CommonRouteID_8, 1, new List<int> { MonsterID_7 }, -90, 18);
		AddGroupToWave(2, 3, SpawnPointID_2, CommonRouteID_6, 1, new List<int> { MonsterID_4 }, -90, 0);
		AddGroupToWave(2, 4, SpawnPointID_1, CommonRouteID_7, 1, new List<int> { MonsterID_4 }, 0, 0);
		AddGroupToWave(2, 5, SpawnPointID_1, CommonRouteID_2, 15, new List<int> { MonsterID_1, MonsterID_2 }, 0, 5);
		AddGroupToWave(2, 6, SpawnPointID_2, CommonRouteID_5, 3, new List<int> { MonsterID_3 }, -90, 20);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2, MonsterID_3, MonsterID_4, MonsterID_5, MonsterID_6, MonsterID_7 });
		SetLighthouseActive(5, active: false);
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_2 }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitUntil_GroupClear(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_2, CommonRouteID_4 }, IsSameTime: true));
		ActiveGroup(2);
		ActiveGroup(3);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_6 }, IsSameTime: false));
		ActiveWave(2);
		ActiveGroup(3);
		yield return WaitTime(5);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_8 }, IsSameTime: false));
		ActiveGroup(1);
		yield return WaitTime(10);
		ActiveGroup(2);
		yield return WaitTime(76);
		GiveARoleCard();
		yield return WaitTime(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_7 }, IsSameTime: false));
		ActiveGroup(4);
		yield return WaitTime(3);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_2 }, IsSameTime: true));
		ActiveGroup(5);
		yield return WaitTime(28);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_5 }, IsSameTime: true));
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
