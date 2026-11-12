using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_5_3 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_1 = 8069901;

	private readonly int MonsterID_2 = 8069903;

	private readonly int MonsterID_3 = 8070502;

	private readonly int MonsterID_4 = 8070501;

	private readonly int CommonRouteID_1;

	private readonly int CommonRouteID_2 = 1;

	private readonly int CommonRouteID_3 = 2;

	private readonly int CommonRouteID_4 = 3;

	private readonly int SpawnPointID_1 = 40;

	private readonly int SpawnPointID_2 = 1;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 14 },
		{ 1, 17 },
		{ 2, 17 },
		{ 3, 14 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_1, CommonRouteID_2, 6, new List<int> { MonsterID_1 }, -90, 5);
		AddGroupToWave(1, 2, SpawnPointID_1, CommonRouteID_3, 1, new List<int> { MonsterID_3 }, -90, 0);
		AddGroupToWave(1, 3, SpawnPointID_1, CommonRouteID_2, 6, new List<int> { MonsterID_1, MonsterID_2 }, -90, 4.5);
		AddGroupToWave(1, 4, SpawnPointID_1, CommonRouteID_3, 1, new List<int> { MonsterID_4 }, -90, 0);
		AddGroupToWave(1, 5, SpawnPointID_2, CommonRouteID_1, 6, new List<int> { MonsterID_1 }, -90, 4);
		AddGroupToWave(1, 6, SpawnPointID_2, CommonRouteID_4, 1, new List<int> { MonsterID_3 }, -90, 0);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2, MonsterID_3, MonsterID_4 });
		MarkHasDicTopBar();
		SetLighthouseActive(15, active: false);
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1);
		ShowDicTopbar(400232);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_2 }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitTime(2.5);
		ActiveGroup(2);
		yield return WaitTime(10);
		GiveARoleCard();
		yield return WaitTime(12);
		ActiveGroup(3);
		yield return WaitTime(2.5);
		ShowMonsterInfoUI(MonsterID_4);
		ActiveGroup(4);
		yield return WaitTime(10);
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1 }, IsSameTime: false));
		ActiveGroup(5);
		yield return WaitTime(15);
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
