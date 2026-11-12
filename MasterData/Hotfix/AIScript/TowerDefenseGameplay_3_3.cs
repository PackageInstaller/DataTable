using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_3_3 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_1 = 8069901;

	private readonly int MonsterID_2 = 8069903;

	private readonly int MonsterID_3 = 8079904;

	private readonly int CommonRouteID_1;

	private readonly int CommonRouteID_2 = 1;

	private readonly int SpawnPointID_1 = 1;

	private readonly int SpawnPointID_2 = 40;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 15 },
		{ 1, 15 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_1, CommonRouteID_1, 10, new List<int> { MonsterID_1 }, 0, 3);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_2, CommonRouteID_2, 12, new List<int> { MonsterID_1, MonsterID_2 }, -90, 5);
		AddGroupToWave(2, 2, SpawnPointID_1, CommonRouteID_1, 2, new List<int> { MonsterID_3 }, 0, 20);
		AddGroupToWave(2, 3, SpawnPointID_1, CommonRouteID_1, 9, new List<int> { MonsterID_1 }, 0, 4);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2, MonsterID_3 });
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1 }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitTime(10);
		GiveARoleCard();
		yield return WaitUntil_GroupClear(1);
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_2 }, IsSameTime: false));
		ActiveWave(2);
		ActiveGroup(1);
		yield return WaitTime(8);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1 }, IsSameTime: false));
		ActiveGroup(2);
		yield return WaitTime(2);
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
