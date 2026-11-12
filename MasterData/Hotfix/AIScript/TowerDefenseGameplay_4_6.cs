using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_4_6 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_1 = 8069902;

	private readonly int MonsterID_2 = 8069904;

	private readonly int MonsterID_3 = 8070401;

	private readonly int MonsterID_4 = 8070402;

	private readonly int MonsterID_5 = 8080402;

	private readonly int MonsterID_6 = 8069901;

	private readonly int MonsterID_7 = 8069903;

	private readonly int CommonRouteID_1;

	private readonly int CommonRouteID_2 = 1;

	private readonly int CommonRouteID_3 = 2;

	private readonly int CommonRouteID_4 = 3;

	private readonly int CommonRouteID_5 = 4;

	private readonly int CommonRouteID_6 = 5;

	private readonly int CommonRouteID_7 = 6;

	private readonly int SpawnPointID_1 = 30;

	private readonly int SpawnPointID_2 = 10;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 15 },
		{ 1, 15 },
		{ 2, 15 },
		{ 3, 15 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_1, CommonRouteID_1, 6, new List<int> { MonsterID_6 }, 0, 4);
		AddGroupToWave(1, 2, SpawnPointID_2, CommonRouteID_4, 6, new List<int> { MonsterID_7 }, -90, 4);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_2, CommonRouteID_6, 1, new List<int> { MonsterID_3 }, -90, 0);
		AddGroupToWave(2, 2, SpawnPointID_1, CommonRouteID_5, 1, new List<int> { MonsterID_3 }, 0, 0);
		AddGroupToWave(2, 3, SpawnPointID_2, CommonRouteID_3, 8, new List<int> { MonsterID_1 }, -90, 3);
		AddGroupToWave(2, 4, SpawnPointID_1, CommonRouteID_2, 2, new List<int> { MonsterID_4 }, 0, 10);
		AddWave(3);
		AddGroupToWave(3, 1, SpawnPointID_1, CommonRouteID_7, 1, new List<int> { MonsterID_5 }, 0, 0);
		AddGroupToWave(3, 2, SpawnPointID_1, CommonRouteID_2, 3, new List<int> { MonsterID_3, MonsterID_4 }, 0, 10);
		AddGroupToWave(3, 3, SpawnPointID_1, CommonRouteID_2, 11, new List<int> { MonsterID_2 }, 0, 3);
		AddGroupToWave(3, 4, SpawnPointID_2, CommonRouteID_3, 3, new List<int> { MonsterID_3, MonsterID_4 }, -90, 10);
		AddGroupToWave(3, 5, SpawnPointID_2, CommonRouteID_3, 11, new List<int> { MonsterID_1 }, -90, 3);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2, MonsterID_3, MonsterID_4, MonsterID_5, MonsterID_6, MonsterID_7 });
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1, CommonRouteID_4 }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitTime(15);
		ActiveGroup(2);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		yield return WaitTime(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_2, CommonRouteID_3 }, IsSameTime: true));
		ActiveWave(2);
		ActiveGroup(1);
		ActiveGroup(2);
		yield return WaitTime(10);
		ActiveGroup(3);
		ActiveGroup(4);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		yield return WaitTime(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_2, CommonRouteID_3 }, IsSameTime: false));
		ActiveWave(3);
		ActiveGroup(1);
		yield return WaitTime(5);
		ActiveGroup(2);
		ActiveGroup(3);
		yield return WaitTime(10);
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
