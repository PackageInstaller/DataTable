using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_4_4 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_1 = 8069901;

	private readonly int MonsterID_2 = 8069903;

	private readonly int MonsterID_3 = 8070401;

	private readonly int MonsterID_4 = 8070402;

	private readonly int MonsterID_5 = 8080402;

	private readonly int CommonRouteID_1;

	private readonly int CommonRouteID_2 = 1;

	private readonly int CommonRouteID_3 = 2;

	private readonly int CommonRouteID_4 = 3;

	private readonly int CommonRouteID_5 = 4;

	private readonly int CommonRouteID_6 = 5;

	private readonly int CommonRouteID_7 = 6;

	private readonly int CommonRouteID_8 = 7;

	private readonly int CommonRouteID_9 = 8;

	private readonly int SpawnPointID_1 = 40;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 11 },
		{ 1, 12 },
		{ 2, 17 },
		{ 3, 12 },
		{ 4, 15 },
		{ 5, 16 },
		{ 6, 17 },
		{ 7, 12 },
		{ 8, 30 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_1, CommonRouteID_2, 5, new List<int> { MonsterID_1 }, -90, 4);
		AddGroupToWave(1, 2, SpawnPointID_1, CommonRouteID_2, 5, new List<int> { MonsterID_2 }, -90, 4);
		AddGroupToWave(1, 3, SpawnPointID_1, CommonRouteID_2, 1, new List<int> { MonsterID_3 }, -90, 0);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_1, CommonRouteID_8, 5, new List<int> { MonsterID_2 }, -90, 4);
		AddGroupToWave(2, 2, SpawnPointID_1, CommonRouteID_5, 5, new List<int> { MonsterID_1 }, -90, 4);
		AddGroupToWave(2, 3, SpawnPointID_1, CommonRouteID_5, 2, new List<int> { MonsterID_4 }, -90, 10);
		AddWave(3);
		AddGroupToWave(3, 1, SpawnPointID_1, CommonRouteID_6, 10, new List<int> { MonsterID_1 }, -90, 3);
		AddGroupToWave(3, 2, SpawnPointID_1, CommonRouteID_1, 10, new List<int> { MonsterID_2 }, -90, 3);
		AddGroupToWave(3, 3, SpawnPointID_1, CommonRouteID_6, 3, new List<int> { MonsterID_3 }, -90, 12);
		AddGroupToWave(3, 4, SpawnPointID_1, CommonRouteID_9, 1, new List<int> { MonsterID_5 }, -90, 0);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2, MonsterID_3, MonsterID_4, MonsterID_5 });
		MarkHasDicTopBar();
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1);
		ShowDicTopbar(400223);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_2 }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitUntil_GroupClear(1);
		ActiveGroup(3);
		yield return WaitTime(3);
		ActiveGroup(2);
		GiveARoleCard();
		yield return WaitUntil_GroupClear(2);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_5, CommonRouteID_8 }, IsSameTime: false));
		ActiveWave(2);
		ActiveGroup(2);
		yield return WaitTime(6);
		ActiveGroup(3);
		GiveARoleCard();
		yield return WaitUntil_GroupClear(2);
		ActiveGroup(1);
		yield return WaitUntil_WaveClear();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_9 }, IsSameTime: false));
		ActiveWave(3);
		ActiveGroup(4);
		ShowMonsterInfoUI(MonsterID_5);
		yield return WaitTime(10);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1, CommonRouteID_6 }, IsSameTime: true));
		ActiveGroup(2);
		ActiveGroup(3);
		yield return WaitUntil_GroupClear(2);
		ActiveGroup(1);
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
