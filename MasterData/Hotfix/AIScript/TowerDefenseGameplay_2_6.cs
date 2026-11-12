using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_2_6 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_CommonMonster = 8069901;

	private readonly int MonsterID_FastMonster = 8069903;

	private readonly int MonsterID_CommonMonster_Plus = 8069902;

	private readonly int MonsterID_FastMonster_Plus = 8069904;

	private readonly int MonsterID_HardMonster = 8079901;

	private readonly int MonsterID_ChuanSongGuai = 8089902;

	private readonly int CommonRouteID_Up;

	private readonly int CommonRouteID_Down = 1;

	private readonly int CommonRouteID_Elite = 12;

	private readonly int CommonRouteID_Elite2 = 13;

	private readonly int SpawnPointID_Up = 30;

	private readonly int SpawnPointID_Down = 10;

	private readonly int SpawnPointID_Elite = 24;

	private readonly int Tutorial_BossWeight = 400210;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 16 },
		{ 1, 16 },
		{ 12, 25 },
		{ 13, 25 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(0);
		AddGroupToWave(0, 1, SpawnPointID_Elite, CommonRouteID_Elite, 1, new List<int> { MonsterID_ChuanSongGuai }, -90, 70);
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_Down, CommonRouteID_Down, 5, new List<int> { MonsterID_CommonMonster }, -90, 7);
		AddGroupToWave(1, 2, SpawnPointID_Up, CommonRouteID_Up, 5, new List<int> { MonsterID_CommonMonster }, -90, 7);
		AddGroupToWave(1, 3, SpawnPointID_Down, CommonRouteID_Down, 3, new List<int> { MonsterID_FastMonster }, -90, 7);
		AddGroupToWave(1, 4, SpawnPointID_Up, CommonRouteID_Up, 3, new List<int> { MonsterID_FastMonster }, -90, 7);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_Up, CommonRouteID_Up, 5, new List<int> { MonsterID_CommonMonster_Plus, MonsterID_FastMonster_Plus }, -90, 8);
		AddGroupToWave(2, 2, SpawnPointID_Down, CommonRouteID_Down, 5, new List<int> { MonsterID_CommonMonster_Plus, MonsterID_FastMonster_Plus }, -90, 8);
		AddGroupToWave(2, 3, SpawnPointID_Up, CommonRouteID_Up, 5, new List<int> { MonsterID_CommonMonster_Plus }, -90, 4);
		AddGroupToWave(2, 4, SpawnPointID_Down, CommonRouteID_Down, 5, new List<int> { MonsterID_CommonMonster_Plus }, -90, 4);
		AddWave(3);
		AddGroupToWave(3, 1, SpawnPointID_Up, CommonRouteID_Up, 7, new List<int> { MonsterID_HardMonster, MonsterID_FastMonster_Plus, MonsterID_FastMonster_Plus }, -90, 8);
		AddGroupToWave(3, 2, SpawnPointID_Down, CommonRouteID_Down, 7, new List<int> { MonsterID_FastMonster_Plus, MonsterID_FastMonster_Plus, MonsterID_HardMonster }, -90, 8);
		PreloadMonster(new List<int> { MonsterID_ChuanSongGuai, MonsterID_CommonMonster, MonsterID_CommonMonster_Plus, MonsterID_FastMonster, MonsterID_FastMonster_Plus });
	}

	internal override IEnumerator DoMainLogic()
	{
		ActiveWave(0);
		ActiveGroup(1);
		yield return WaitTime(2);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Down, CommonRouteID_Up }, IsSameTime: true));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitTime(3.5);
		ActiveGroup(2);
		yield return WaitTime(12);
		ActiveGroup(3);
		ActiveGroup(4);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		yield return WaitTime(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Down, CommonRouteID_Up }, IsSameTime: true));
		ActiveWave(2);
		ActiveGroup(1);
		ActiveGroup(2);
		yield return WaitTime(20);
		ActiveGroup(3);
		yield return WaitTime(2);
		ActiveGroup(4);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		yield return WaitTime(1);
		ActiveWave(3);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Down, CommonRouteID_Up }, IsSameTime: true));
		ActiveGroup(1);
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
