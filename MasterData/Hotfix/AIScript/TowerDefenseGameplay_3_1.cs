using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_3_1 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_1 = 8069901;

	private readonly int MonsterID_2 = 8069903;

	private readonly int CommonRouteID;

	private readonly int SpawnPointID = 24;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int> { { 0, 9 } };

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID, 1, 4, new List<int> { MonsterID_1 }, -90, 6);
		AddGroupToWave(1, 2, SpawnPointID, CommonRouteID, 8, new List<int> { MonsterID_1 }, -90, 4);
		AddGroupToWave(1, 3, SpawnPointID, CommonRouteID, 8, new List<int> { MonsterID_2, MonsterID_1 }, -90, 2);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2 });
		InitItemNum(3, 5);
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitUntil_GroupClear(1);
		ActiveGroup(2);
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID }, IsSameTime: false));
		yield return WaitUntil_GroupClear(2);
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
