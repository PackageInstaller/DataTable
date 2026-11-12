using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_1_3 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_CommonMonster = 8069901;

	private readonly int MonsterID_CommonMonster_Plus = 8069902;

	private readonly int MonsterID_FastMonster = 8069903;

	private readonly int MonsterID_FastMonster_Plus = 8069904;

	private readonly int MonsterID_HardMonster = 8079901;

	private readonly int CommonRouteID_Up;

	private readonly int CommonRouteID_Down = 1;

	private readonly int SurroundRouteID_Up = 10;

	private readonly int SpawnPointID = 30;

	private Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 12 },
		{ 1, 12 },
		{ 10, 12 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID, CommonRouteID_Up, 12, new List<int> { MonsterID_FastMonster }, -90, 2);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID, CommonRouteID_Down, 15, new List<int> { MonsterID_CommonMonster }, -90, 2);
		AddWave(3);
		AddGroupToWave(3, 1, SpawnPointID, SurroundRouteID_Up, 5, new List<int> { MonsterID_CommonMonster_Plus }, -90, 1);
		AddGroupToWave(3, 2, SpawnPointID, SurroundRouteID_Up, 10, new List<int> { MonsterID_CommonMonster_Plus, MonsterID_FastMonster_Plus }, -90, 0.5f);
		AddGroupToWave(3, 3, SpawnPointID, SurroundRouteID_Up, 4, new List<int> { MonsterID_HardMonster }, -90, 4);
		PreloadMonster(new List<int> { MonsterID_CommonMonster, MonsterID_CommonMonster_Plus, MonsterID_FastMonster, MonsterID_FastMonster_Plus, MonsterID_HardMonster });
		MarkHasDicTopBar();
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1.5);
		ShowDicTopbar(400204);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { 0 }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitUntil_GroupClear(1);
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { 1 }, IsSameTime: false));
		ActiveWave(2);
		ActiveGroup(1);
		yield return WaitUntil_GroupClear(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { 10 }, IsSameTime: false));
		ActiveWave(3);
		ActiveGroup(1);
		yield return WaitUntil_GroupComplete(1);
		yield return WaitTime(1);
		ActiveGroup(2);
		yield return WaitUntil_GroupComplete(2);
		yield return WaitTime(0.5);
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
