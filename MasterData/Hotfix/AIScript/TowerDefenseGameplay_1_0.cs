using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_1_0 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_CommonMonster = 8069901;

	private readonly int CommonRouteID;

	private readonly int SpawnPointID;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int> { { 0, 10 } };

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID, CommonRouteID, 3, new List<int> { MonsterID_CommonMonster }, -90, 4);
		AddGroupToWave(1, 2, SpawnPointID, CommonRouteID, 6, new List<int> { MonsterID_CommonMonster }, -90, 2.5f);
		PreloadMonster(new List<int> { MonsterID_CommonMonster });
		MarkHasDicTopBar();
	}

	internal override IEnumerator DoMainLogic()
	{
		ShowOperateUI(showOrClose: false);
		yield return WaitTime(1);
		ShowDicTopbar(400201);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitUntil_GroupClear(1);
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID }, IsSameTime: false));
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
