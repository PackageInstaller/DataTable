using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_5_1 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_1 = 8069901;

	private readonly int MonsterID_2 = 8069903;

	private readonly int CommonRouteID_1;

	private readonly int CommonRouteID_2 = 1;

	private readonly int CommonRouteID_3 = 2;

	private readonly int SpawnPointID = 24;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int> { { 0, 10 } };

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID, CommonRouteID_2, 5, new List<int> { MonsterID_1 }, -90, 5);
		AddGroupToWave(1, 2, SpawnPointID, CommonRouteID_1, 3, new List<int> { MonsterID_2 }, -90, 5);
		AddGroupToWave(1, 3, SpawnPointID, CommonRouteID_3, 8, new List<int> { MonsterID_1 }, -90, 4);
		AddGroupToWave(1, 4, SpawnPointID, CommonRouteID_1, 4, new List<int> { MonsterID_2 }, -90, 4);
		PreloadMonster(new List<int> { MonsterID_1, MonsterID_2 });
		MarkHasDicTopBar();
		SetLighthouseActive(10, active: true);
		SetLighthouseActive(22, active: true);
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1);
		ShowDicTopbar(400230);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_1 }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitUntil_GroupClear(1);
		ActiveGroup(2);
		GiveARoleCard();
		yield return WaitUntil_GroupClear(2);
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
