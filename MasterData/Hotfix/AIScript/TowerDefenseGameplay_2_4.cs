using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_2_4 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_CommonMonster = 8069901;

	private readonly int MonsterID_FastMonster = 8069903;

	private readonly int MonsterID_CommonMonster_Plus = 8069902;

	private readonly int MonsterID_FastMonster_Plus = 8069904;

	private readonly int MonsterID_ChuanSongGuai = 8089902;

	private readonly int CommonRouteID_Up;

	private readonly int CommonRouteID_Down = 1;

	private readonly int CommonRouteID_Elite = 10;

	private readonly int SpawnPointID_Up = 30;

	private readonly int SpawnPointID_Down = 10;

	private readonly int SpawnPointID_Elite = 23;

	private readonly int Tutorial_BossWeight = 400210;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 16 },
		{ 1, 16 },
		{ 10, 14 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(0);
		AddGroupToWave(0, 1, SpawnPointID_Elite, CommonRouteID_Elite, 1, new List<int> { MonsterID_ChuanSongGuai }, -90, 1);
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_Down, CommonRouteID_Down, 4, new List<int> { MonsterID_CommonMonster }, -90, 7);
		AddGroupToWave(1, 2, SpawnPointID_Up, CommonRouteID_Up, 4, new List<int> { MonsterID_CommonMonster }, -90, 7);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_Up, CommonRouteID_Up, 7, new List<int> { MonsterID_CommonMonster }, -90, 4);
		AddGroupToWave(2, 2, SpawnPointID_Down, CommonRouteID_Down, 7, new List<int> { MonsterID_FastMonster }, -90, 4);
		AddWave(3);
		AddGroupToWave(3, 1, SpawnPointID_Up, CommonRouteID_Up, 8, new List<int> { MonsterID_CommonMonster_Plus }, -90, 5);
		AddGroupToWave(3, 2, SpawnPointID_Down, CommonRouteID_Down, 8, new List<int> { MonsterID_FastMonster_Plus }, -90, 5);
		AddGroupToWave(3, 3, SpawnPointID_Up, CommonRouteID_Up, 4, new List<int> { MonsterID_FastMonster_Plus }, -90, 5);
		AddGroupToWave(3, 4, SpawnPointID_Down, CommonRouteID_Down, 4, new List<int> { MonsterID_CommonMonster_Plus }, -90, 5);
		PreloadMonster(new List<int> { MonsterID_ChuanSongGuai, MonsterID_CommonMonster, MonsterID_CommonMonster_Plus, MonsterID_FastMonster, MonsterID_FastMonster_Plus });
	}

	internal override IEnumerator DoMainLogic()
	{
		ActiveWave(0);
		ActiveGroup(1);
		yield return WaitTime(1);
		ShowDicTopbar(Tutorial_BossWeight);
		yield return WaitTime(1);
		ShowMonsterInfoUI(MonsterID_ChuanSongGuai);
		yield return WaitTime(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Down, CommonRouteID_Up }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitTime(7.5);
		ActiveGroup(2);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Down, CommonRouteID_Up }, IsSameTime: true));
		ActiveWave(2);
		ActiveGroup(1);
		ActiveGroup(2);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Down, CommonRouteID_Up }, IsSameTime: true));
		ActiveWave(3);
		ActiveGroup(1);
		ActiveGroup(2);
		yield return WaitTime(20);
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
