using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_2_7 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_CommonMonster = 8069901;

	private readonly int MonsterID_FastMonster = 8069903;

	private readonly int MonsterID_CommonMonster_Plus = 8069902;

	private readonly int MonsterID_FastMonster_Plus = 8069904;

	private readonly int MonsterID_YinYing = 8079903;

	private readonly int MonsterID_ChuanSongGuai = 8089902;

	private readonly int CommonRouteID_Up;

	private readonly int CommonRouteID_Down = 1;

	private readonly int CommonRouteID_Up2 = 10;

	private readonly int CommonRouteID_Down2 = 11;

	private readonly int CommonRouteID_Boss1 = 20;

	private readonly int CommonRouteID_Boss2 = 21;

	private readonly int CommonRouteID_Elite = 22;

	private readonly int SpawnPointID_Up = 61;

	private readonly int SpawnPointID_Down = 2;

	private readonly int SpawnPointID_Elite = 41;

	private readonly int SpawnPointID_Boss1 = 53;

	private readonly int SpawnPointID_Boss2 = 29;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 12 },
		{ 1, 13 },
		{ 10, 16 },
		{ 11, 17 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(0);
		AddGroupToWave(0, 1, SpawnPointID_Elite, CommonRouteID_Elite, 1, new List<int> { MonsterID_YinYing }, -90, 1);
		AddGroupToWave(0, 3, SpawnPointID_Boss1, CommonRouteID_Boss1, 1, new List<int> { MonsterID_ChuanSongGuai }, -90, 1);
		AddGroupToWave(0, 4, SpawnPointID_Boss2, CommonRouteID_Boss2, 1, new List<int> { MonsterID_ChuanSongGuai }, -90, 1);
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_Up, CommonRouteID_Up, 14, new List<int> { MonsterID_CommonMonster }, -90, 3);
		AddGroupToWave(1, 2, SpawnPointID_Up, CommonRouteID_Up2, 3, new List<int> { MonsterID_FastMonster }, -90, 7);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_Down, CommonRouteID_Down, 8, new List<int> { MonsterID_CommonMonster_Plus }, 0, 5);
		AddGroupToWave(2, 2, SpawnPointID_Down, CommonRouteID_Down2, 3, new List<int> { MonsterID_FastMonster_Plus }, 0, 8);
		AddGroupToWave(2, 3, SpawnPointID_Up, CommonRouteID_Up2, 2, new List<int> { MonsterID_YinYing }, -90, 10);
		AddWave(3);
		AddGroupToWave(3, 1, SpawnPointID_Up, CommonRouteID_Up2, 7, new List<int> { MonsterID_FastMonster_Plus, MonsterID_YinYing }, -90, 8);
		AddGroupToWave(3, 2, SpawnPointID_Down, CommonRouteID_Down2, 7, new List<int> { MonsterID_YinYing, MonsterID_FastMonster_Plus }, 0, 8);
		PreloadMonster(new List<int> { MonsterID_ChuanSongGuai, MonsterID_CommonMonster, MonsterID_CommonMonster_Plus, MonsterID_FastMonster, MonsterID_FastMonster_Plus, MonsterID_YinYing });
	}

	internal override IEnumerator DoMainLogic()
	{
		ActiveWave(0);
		ActiveGroup(1);
		ActiveGroup(3);
		ActiveGroup(4);
		yield return WaitTime(2);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Up, CommonRouteID_Up2 }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitTime(20);
		ActiveGroup(2);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Down, CommonRouteID_Down2, CommonRouteID_Up2 }, IsSameTime: false));
		ActiveWave(2);
		ActiveGroup(1);
		yield return WaitTime(20);
		ActiveGroup(2);
		ActiveGroup(3);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		yield return WaitTime(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Down2, CommonRouteID_Up2 }, IsSameTime: true));
		ActiveWave(3);
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
