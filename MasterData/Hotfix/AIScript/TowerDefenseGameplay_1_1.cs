using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_1_1 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_CommonMonster = 8069901;

	private readonly int MonsterID_CommonMonster_Plus = 8069902;

	private readonly int MonsterID_FastMonster = 8069903;

	private readonly int CommonRouteID;

	private readonly int SpawnPointID;

	private Dictionary<int, int> RouteDic = new Dictionary<int, int> { { 0, 10 } };

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID, CommonRouteID, 8, new List<int> { MonsterID_CommonMonster }, -90, 1.5f);
		AddGroupToWave(1, 2, SpawnPointID, CommonRouteID, 15, new List<int> { MonsterID_FastMonster }, -90, 1.5f);
		AddGroupToWave(1, 3, SpawnPointID, CommonRouteID, 20, new List<int> { MonsterID_CommonMonster_Plus }, -90, 1);
		PreloadMonster(new List<int> { MonsterID_CommonMonster, MonsterID_CommonMonster_Plus, MonsterID_FastMonster });
		MarkHasDicTopBar();
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1);
		ShowDicTopbar(400202);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID }, IsSameTime: false));
		ShowUITip("TowerDefense_Tutorial_Tips_1_1", 15f);
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitUntil_GroupClear(1);
		yield return WaitTime(2);
		ActiveGroup(2);
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
