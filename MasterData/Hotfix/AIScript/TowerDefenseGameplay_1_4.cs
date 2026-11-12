using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_1_4 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_CommonMonster = 8069901;

	private readonly int MonsterID_CommonMonster_Plus = 8069902;

	private readonly int MonsterID_FastMonster = 8069903;

	private readonly int MonsterID_FastMonster_Plus = 8069904;

	private readonly int MonsterID_SpeedUpMonster = 8079902;

	private readonly int CommonRouteID_Up;

	private readonly int CommonRouteID_Down = 1;

	private readonly int SpawnPointID_Up = 40;

	private readonly int SpawnPointID_Down;

	private Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 13 },
		{ 1, 13 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_Up, CommonRouteID_Up, 5, new List<int> { MonsterID_CommonMonster }, -90, 5);
		AddGroupToWave(1, 2, SpawnPointID_Down, CommonRouteID_Down, 5, new List<int> { MonsterID_CommonMonster }, -90, 5);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_Up, CommonRouteID_Up, 3, new List<int> { MonsterID_SpeedUpMonster }, -90, 10);
		AddGroupToWave(2, 2, SpawnPointID_Down, CommonRouteID_Down, 3, new List<int> { MonsterID_SpeedUpMonster }, -90, 10);
		AddGroupToWave(2, 3, SpawnPointID_Up, CommonRouteID_Up, 6, new List<int> { MonsterID_FastMonster }, -90, 2);
		AddGroupToWave(2, 4, SpawnPointID_Down, CommonRouteID_Down, 6, new List<int> { MonsterID_FastMonster }, -90, 2);
		AddWave(3);
		AddGroupToWave(3, 1, SpawnPointID_Up, CommonRouteID_Up, 4, new List<int> { MonsterID_SpeedUpMonster }, -90, 15);
		AddGroupToWave(3, 2, SpawnPointID_Down, CommonRouteID_Down, 4, new List<int> { MonsterID_SpeedUpMonster }, -90, 15);
		AddGroupToWave(3, 3, SpawnPointID_Up, CommonRouteID_Up, 10, new List<int> { MonsterID_CommonMonster_Plus }, -90, 4);
		AddGroupToWave(3, 4, SpawnPointID_Down, CommonRouteID_Down, 10, new List<int> { MonsterID_FastMonster_Plus }, -90, 4);
		PreloadMonster(new List<int> { MonsterID_CommonMonster, MonsterID_CommonMonster_Plus, MonsterID_FastMonster, MonsterID_FastMonster_Plus, MonsterID_SpeedUpMonster });
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Up, CommonRouteID_Down }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitTime(2);
		ActiveGroup(2);
		yield return WaitUntil_WaveClear();
		ActiveWave(2);
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Up, CommonRouteID_Down }, IsSameTime: false));
		ActiveGroup(1);
		ShowMonsterInfoUI(MonsterID_SpeedUpMonster);
		yield return WaitTime(5);
		ActiveGroup(2);
		yield return WaitTime(7);
		ActiveGroup(4);
		yield return WaitTime(5);
		ActiveGroup(3);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Up, CommonRouteID_Down }, IsSameTime: true));
		ActiveWave(3);
		ActiveGroup(1);
		ActiveGroup(2);
		yield return WaitTime(4);
		ActiveGroup(3);
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
