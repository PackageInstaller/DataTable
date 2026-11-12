using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_2_2 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_CommonMonster_Plus = 8069902;

	private readonly int MonsterID_HardMonster = 8079901;

	private readonly int CommonRouteID;

	private readonly int CommonRouteID_Wait = 1;

	private readonly int SpawnPointID = 16;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 7 },
		{ 1, 3 }
	};

	private readonly int Tutorial_Push = 400206;

	private readonly int Tutorial_Weight = 400207;

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID, CommonRouteID, 2, new List<int> { MonsterID_CommonMonster_Plus }, -90, 5);
		AddGroupToWave(1, 2, SpawnPointID, CommonRouteID, 6, new List<int> { MonsterID_CommonMonster_Plus }, -90, 0.5f);
		AddGroupToWave(1, 3, SpawnPointID, CommonRouteID_Wait, 1, new List<int> { MonsterID_HardMonster }, -90, 9);
		PreloadMonster(new List<int> { MonsterID_CommonMonster_Plus, MonsterID_HardMonster });
		MarkHasDicTopBar();
	}

	internal override IEnumerator DoMainLogic()
	{
		ShowOperateUI(showOrClose: false);
		yield return WaitTime(1);
		ShowDicTopbar(Tutorial_Push);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID }, IsSameTime: false));
		ShowUITip("TowerDefense_Tutorial_Tips_2_1", 15f);
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitUntil_GroupClear(1);
		yield return WaitTime(3);
		ActiveGroup(2);
		yield return WaitUntil_GroupClear(2);
		yield return WaitTime(1);
		ActiveGroup(3);
		yield return WaitTime(8);
		ShowDicTopbar(Tutorial_Weight);
		GiveARoleCard();
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
