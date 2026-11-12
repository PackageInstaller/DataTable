using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_5_4 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_1 = 8069901;

	private readonly int MonsterID_2 = 8069903;

	private readonly int MonsterID_3 = 8070502;

	private readonly int MonsterID_4 = 8080501;

	private readonly int CommonRouteID_1;

	private readonly int CommonRouteID_2 = 1;

	private readonly int CommonRouteID_3 = 2;

	private readonly int CommonRouteID_4 = 3;

	private readonly int CommonRouteID_5 = 4;

	private readonly int CommonRouteID_6 = 5;

	private readonly int CommonRouteID_7 = 6;

	private readonly int SpawnPointID_1 = 10;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 15 },
		{ 1, 14 },
		{ 2, 17 },
		{ 3, 16 },
		{ 4, 17 },
		{ 5, 16 },
		{ 6, 38 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_1, CommonRouteID_3, 5, new List<int> { MonsterID_1 }, -90, 4);
		AddGroupToWave(1, 2, SpawnPointID_1, CommonRouteID_3, 8, new List<int> { MonsterID_2 }, -90, 5);
		AddGroupToWave(1, 3, SpawnPointID_1, CommonRouteID_5, 1, new List<int> { MonsterID_3 }, -90, 0);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_1, CommonRouteID_1, 15, new List<int> { MonsterID_1, MonsterID_2 }, -90, 4);
		AddGroupToWave(2, 2, SpawnPointID_1, CommonRouteID_2, 15, new List<int> { MonsterID_1, MonsterID_2 }, -90, 3);
		AddGroupToWave(2, 3, SpawnPointID_1, CommonRouteID_6, 3, new List<int> { MonsterID_3 }, -90, 20);
		AddGroupToWave(2, 4, SpawnPointID_1, CommonRouteID_7, 1, new List<int> { MonsterID_4 }, -90, 0);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2, MonsterID_3, MonsterID_4 });
		MarkHasDicTopBar();
		SetLighthouseActive(23, active: false);
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1);
		ShowDicTopbar(400233);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_3 }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitUntil_GroupClear(1);
		ActiveGroup(3);
		yield return WaitTime(3);
		ActiveGroup(2);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_7 }, IsSameTime: false));
		ActiveWave(2);
		ActiveGroup(4);
		ShowMonsterInfoUI(MonsterID_4);
		yield return WaitTime(7);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1 }, IsSameTime: false));
		ActiveGroup(1);
		yield return WaitTime(15);
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_6 }, IsSameTime: false));
		ActiveGroup(3);
		yield return WaitUntil_GroupClear(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_2 }, IsSameTime: false));
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
