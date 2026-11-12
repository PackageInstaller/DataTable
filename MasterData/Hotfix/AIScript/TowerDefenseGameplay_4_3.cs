using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_4_3 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_1 = 8069901;

	private readonly int MonsterID_2 = 8069903;

	private readonly int MonsterID_3 = 8070401;

	private readonly int MonsterID_4 = 8070402;

	private readonly int CommonRouteID_1;

	private readonly int CommonRouteID_2 = 1;

	private readonly int CommonRouteID_3 = 2;

	private readonly int CommonRouteID_4 = 3;

	private readonly int CommonRouteID_5 = 4;

	private readonly int SpawnPointID_1 = 40;

	private readonly int SpawnPointID_2 = 48;

	private readonly int SpawnPointID_3 = 24;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 12 },
		{ 1, 14 },
		{ 2, 14 },
		{ 3, 12 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_1, CommonRouteID_2, 5, new List<int> { MonsterID_1 }, -90, 5);
		AddGroupToWave(1, 2, SpawnPointID_1, CommonRouteID_2, 1, new List<int> { MonsterID_4 }, -90, 0);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_2, CommonRouteID_3, 6, new List<int> { MonsterID_2 }, 90, 4);
		AddGroupToWave(2, 2, SpawnPointID_2, CommonRouteID_3, 1, new List<int> { MonsterID_4 }, 90, 0);
		AddWave(3);
		AddGroupToWave(3, 1, SpawnPointID_1, CommonRouteID_1, 6, new List<int> { MonsterID_1, MonsterID_2 }, -90, 4);
		AddGroupToWave(3, 2, SpawnPointID_1, CommonRouteID_1, 3, new List<int> { MonsterID_4 }, -90, 10);
		AddGroupToWave(3, 3, SpawnPointID_2, CommonRouteID_4, 6, new List<int> { MonsterID_1, MonsterID_2 }, 90, 4);
		AddGroupToWave(3, 4, SpawnPointID_2, CommonRouteID_4, 3, new List<int> { MonsterID_4 }, 90, 10);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2, MonsterID_3, MonsterID_4 });
		MarkHasDicTopBar();
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1);
		ShowDicTopbar(400222);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_2 }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitTime(12);
		ActiveGroup(2);
		ShowMonsterInfoUI(MonsterID_4);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_3 }, IsSameTime: false));
		ActiveWave(2);
		ActiveGroup(1);
		yield return WaitTime(5);
		ActiveGroup(2);
		GiveARoleCard();
		yield return WaitUntil_WaveClear();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1, CommonRouteID_4 }, IsSameTime: false));
		ActiveWave(3);
		ActiveGroup(1);
		yield return WaitTime(2);
		ActiveGroup(2);
		yield return WaitTime(5);
		ActiveGroup(3);
		yield return WaitTime(2);
		ActiveGroup(4);
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
