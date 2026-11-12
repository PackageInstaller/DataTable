using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_3_4 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_1 = 8069901;

	private readonly int MonsterID_2 = 8069903;

	private readonly int MonsterID_3 = 8079904;

	private readonly int MonsterID_4 = 8089903;

	private readonly int CommonRouteID_1;

	private readonly int CommonRouteID_2 = 1;

	private readonly int CommonRouteID_3 = 2;

	private readonly int SpawnPointID_1 = 43;

	private readonly int SpawnPointID_2 = 47;

	private readonly int SpawnPointID_3 = 7;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 23 },
		{ 1, 20 },
		{ 2, 20 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_1, CommonRouteID_1, 10, new List<int> { MonsterID_1 }, 180, 3);
		AddGroupToWave(1, 2, SpawnPointID_2, CommonRouteID_2, 10, new List<int> { MonsterID_2 }, 180, 3);
		AddGroupToWave(1, 3, SpawnPointID_3, CommonRouteID_3, 1, new List<int> { MonsterID_4 }, 0, 0);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_1, CommonRouteID_1, 10, new List<int> { MonsterID_1 }, 180, 3);
		AddGroupToWave(2, 2, SpawnPointID_2, CommonRouteID_2, 10, new List<int> { MonsterID_2 }, 180, 3);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2, MonsterID_4 });
		MarkHasDicTopBar();
	}

	internal override IEnumerator DoMainLogic()
	{
		ActiveWave(1);
		ActiveGroup(3);
		yield return WaitTime(1);
		ShowDicTopbar(400214);
		yield return WaitTime(1);
		ShowMonsterInfoUI(MonsterID_4);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1, CommonRouteID_3 }, IsSameTime: false));
		ActiveGroup(1);
		yield return WaitTime(15);
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_2 }, IsSameTime: false));
		ActiveGroup(2);
		yield return WaitUntil_GroupClear(1);
		GiveARoleCard();
		yield return WaitUntil_GroupClear(2);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1, CommonRouteID_2 }, IsSameTime: false));
		ActiveWave(2);
		ActiveGroup(1);
		ActiveGroup(2);
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
