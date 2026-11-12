using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_1_7 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_CommonMonster = 8069901;

	private readonly int MonsterID_CommonMonster_Plus = 8069902;

	private readonly int MonsterID_FastMonster = 8069903;

	private readonly int MonsterID_FastMonster_Plus = 8069904;

	private readonly int MonsterID_SpeedUpMonster = 8079902;

	private readonly int MonsterID_HardMonster = 8079901;

	private readonly int CommonRouteID_Up;

	private readonly int CommonRouteID_Down = 1;

	private readonly int PatrolRouteID_Up = 10;

	private readonly int PatrolRouteID_Down = 11;

	private readonly int ShortRouteID_Up = 20;

	private readonly int ShortRouteID_Down = 21;

	private readonly int RightRouteID_Up = 30;

	private readonly int RightRouteID_Down = 31;

	private readonly int HardMonsterRoute_Up = 40;

	private readonly int HardMonsterRoute_Down = 41;

	private readonly int HardMonsterRoute_First = 42;

	private readonly int SpawnPointID_Up = 37;

	private readonly int SpawnPointID_Down = 25;

	private readonly int SpawnPointID_Top = 67;

	private readonly int SpawnPointID_Bot = 7;

	private Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 13 },
		{ 1, 13 },
		{ 10, 23 },
		{ 11, 23 },
		{ 20, 10 },
		{ 21, 10 },
		{ 30, 7 },
		{ 31, 7 },
		{ 40, 4 },
		{ 41, 4 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_Up, CommonRouteID_Up, 7, new List<int> { MonsterID_CommonMonster }, -90, 6);
		AddGroupToWave(1, 2, SpawnPointID_Down, CommonRouteID_Down, 4, new List<int> { MonsterID_FastMonster }, -90, 6);
		AddGroupToWave(1, 3, SpawnPointID_Top, HardMonsterRoute_First, 1, new List<int> { MonsterID_HardMonster }, 180, 60);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_Up, PatrolRouteID_Up, 7, new List<int> { MonsterID_SpeedUpMonster }, -90, 8);
		AddGroupToWave(2, 2, SpawnPointID_Down, PatrolRouteID_Down, 7, new List<int> { MonsterID_SpeedUpMonster }, -90, 8);
		AddGroupToWave(2, 5, SpawnPointID_Up, PatrolRouteID_Up, 4, new List<int> { MonsterID_CommonMonster_Plus }, -90, 10);
		AddGroupToWave(2, 6, SpawnPointID_Down, PatrolRouteID_Down, 4, new List<int> { MonsterID_CommonMonster_Plus }, -90, 10);
		AddGroupToWave(2, 7, SpawnPointID_Bot, HardMonsterRoute_Down, 1, new List<int> { MonsterID_HardMonster }, 0, 60);
		AddWave(3);
		AddGroupToWave(3, 1, SpawnPointID_Top, RightRouteID_Up, 9, new List<int> { MonsterID_CommonMonster_Plus, MonsterID_FastMonster_Plus }, 180, 8);
		AddGroupToWave(3, 2, SpawnPointID_Bot, RightRouteID_Down, 9, new List<int> { MonsterID_CommonMonster_Plus, MonsterID_FastMonster_Plus }, 0, 8);
		AddGroupToWave(3, 3, SpawnPointID_Up, ShortRouteID_Up, 8, new List<int> { MonsterID_CommonMonster_Plus, MonsterID_FastMonster_Plus }, -90, 5);
		AddGroupToWave(3, 4, SpawnPointID_Down, ShortRouteID_Down, 8, new List<int> { MonsterID_FastMonster_Plus, MonsterID_CommonMonster_Plus }, -90, 5);
		AddGroupToWave(3, 5, SpawnPointID_Up, ShortRouteID_Up, 3, new List<int> { MonsterID_SpeedUpMonster }, -90, 16);
		AddGroupToWave(3, 6, SpawnPointID_Down, ShortRouteID_Down, 3, new List<int> { MonsterID_SpeedUpMonster }, -90, 16);
		AddGroupToWave(3, 7, SpawnPointID_Top, HardMonsterRoute_Up, 2, new List<int> { MonsterID_HardMonster }, 180, 30);
		AddGroupToWave(3, 8, SpawnPointID_Bot, HardMonsterRoute_Down, 2, new List<int> { MonsterID_HardMonster }, 0, 30);
		PreloadMonster(new List<int> { MonsterID_CommonMonster, MonsterID_CommonMonster_Plus, MonsterID_FastMonster, MonsterID_FastMonster_Plus, MonsterID_SpeedUpMonster, MonsterID_HardMonster });
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Up, CommonRouteID_Down, HardMonsterRoute_Up }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		ActiveGroup(3);
		yield return WaitTime(21);
		ActiveGroup(2);
		yield return WaitTime(23);
		GiveARoleCard();
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { PatrolRouteID_Up, PatrolRouteID_Down, HardMonsterRoute_Up, HardMonsterRoute_Down }, IsSameTime: false));
		ActiveWave(2);
		ActiveGroup(1);
		ActiveGroup(7);
		yield return WaitTime(3);
		ActiveGroup(2);
		yield return WaitTime(17);
		ActiveGroup(5);
		ActiveGroup(6);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { RightRouteID_Up, RightRouteID_Down }, IsSameTime: true));
		yield return StartCoroutine(ShowRouteFlows(new List<int> { ShortRouteID_Up, ShortRouteID_Down, HardMonsterRoute_Up, HardMonsterRoute_Down }, IsSameTime: true));
		ActiveWave(3);
		ActiveGroup(1);
		ActiveGroup(2);
		ActiveGroup(7);
		ActiveGroup(8);
		yield return WaitTime(20);
		ActiveGroup(5);
		ActiveGroup(6);
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
