using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_5_5 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_1 = 8069902;

	private readonly int MonsterID_2 = 8069904;

	private readonly int MonsterID_3 = 8070502;

	private readonly int MonsterID_4 = 8080501;

	private readonly int MonsterID_5 = 8069901;

	private readonly int MonsterID_6 = 8069903;

	private readonly int CommonRouteID_1 = 1;

	private readonly int CommonRouteID_2 = 2;

	private readonly int CommonRouteID_3 = 3;

	private readonly int CommonRouteID_4 = 4;

	private readonly int CommonRouteID_5 = 5;

	private readonly int CommonRouteID_6 = 6;

	private readonly int SpawnPointID_1 = 10;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 1, 14 },
		{ 2, 16 },
		{ 3, 14 },
		{ 4, 14 },
		{ 5, 14 },
		{ 6, 14 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_1, CommonRouteID_4, 1, new List<int> { MonsterID_3 }, -90, 0);
		AddGroupToWave(1, 2, SpawnPointID_1, CommonRouteID_2, 5, new List<int> { MonsterID_5 }, -90, 4);
		AddGroupToWave(1, 3, SpawnPointID_1, CommonRouteID_2, 5, new List<int> { MonsterID_6 }, -90, 4);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_1, CommonRouteID_3, 28, new List<int> { MonsterID_1, MonsterID_6 }, -90, 4);
		AddGroupToWave(2, 2, SpawnPointID_1, CommonRouteID_5, 1, new List<int> { MonsterID_4 }, -90, 0);
		AddGroupToWave(2, 3, SpawnPointID_1, CommonRouteID_6, 3, new List<int> { MonsterID_3 }, -90, 25);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2, MonsterID_3, MonsterID_4, MonsterID_5, MonsterID_6 });
		SetLighthouseActive(34, active: false);
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_4 }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitTime(3);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_2 }, IsSameTime: false));
		ActiveGroup(2);
		yield return WaitTime(7);
		ActiveGroup(3);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_5 }, IsSameTime: true));
		ActiveWave(2);
		ActiveGroup(2);
		yield return WaitTime(7);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_3 }, IsSameTime: false));
		ActiveGroup(1);
		yield return WaitTime(40);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_6 }, IsSameTime: true));
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
