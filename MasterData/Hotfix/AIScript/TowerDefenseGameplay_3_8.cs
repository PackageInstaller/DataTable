using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_3_8 : TowerDefenseGameplayBase
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

	private readonly int SpawnPointID_1 = 52;

	private readonly int SpawnPointID_2 = 19;

	private readonly int SpawnPointID_3 = 19;

	private readonly int SpawnPointID_4 = 42;

	private readonly int SpawnPointID_5 = 69;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 28 },
		{ 1, 22 },
		{ 2, 34 },
		{ 3, 27 },
		{ 4, 36 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_4, CommonRouteID_4, 1, new List<int> { MonsterID_4 }, 90, 0);
		AddGroupToWave(1, 2, SpawnPointID_5, CommonRouteID_5, 1, new List<int> { MonsterID_4 }, 0, 0);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_1, CommonRouteID_1, 2, new List<int> { MonsterID_3 }, 90, 20);
		AddGroupToWave(2, 2, SpawnPointID_2, CommonRouteID_2, 15, new List<int> { MonsterID_6, MonsterID_7 }, 0, 3);
		AddWave(3);
		AddGroupToWave(3, 1, SpawnPointID_1, CommonRouteID_1, 17, new List<int> { MonsterID_1 }, 90, 5);
		AddGroupToWave(3, 2, SpawnPointID_2, CommonRouteID_2, 18, new List<int> { MonsterID_1, MonsterID_2 }, 0, 5);
		AddGroupToWave(3, 3, SpawnPointID_2, CommonRouteID_3, 10, new List<int> { MonsterID_3 }, 0, 10);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2, MonsterID_3, MonsterID_4 });
	}

	internal override IEnumerator DoMainLogic()
	{
		ActiveWave(1);
		ActiveGroup(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_4, CommonRouteID_5 }, IsSameTime: false));
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
