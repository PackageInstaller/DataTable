using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_2_5 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_CommonMonster = 8069901;

	private readonly int MonsterID_FastMonster = 8069903;

	private readonly int MonsterID_HardMonster = 8079901;

	private readonly int MonsterID_YinYing = 8079903;

	private readonly int CommonRouteID_Up;

	private readonly int CommonRouteID_Left = 1;

	private readonly int CommonRouteID_Elite1 = 10;

	private readonly int CommonRouteID_Elite2 = 11;

	private readonly int CommonRouteID_Elite3 = 12;

	private readonly int CommonRouteID_Elite4 = 13;

	private readonly int CommonRouteID_Elite5 = 14;

	private readonly int CommonRouteID_Elite6 = 15;

	private readonly int CommonRouteID_Elite7 = 16;

	private readonly int SpawnPointID_Up = 42;

	private readonly int SpawnPointID_Left = 20;

	private readonly int SpawnPointID_Elite1 = 34;

	private readonly int SpawnPointID_Elite2 = 24;

	private readonly int SpawnPointID_Elite3 = 14;

	private readonly int SpawnPointID_Elite4 = 13;

	private readonly int SpawnPointID_Elite5 = 12;

	private readonly int SpawnPointID_Elite6 = 22;

	private readonly int SpawnPointID_Elite7 = 33;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 12 },
		{ 1, 12 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_Up, CommonRouteID_Up, 10, new List<int> { MonsterID_CommonMonster }, -90, 4);
		AddGroupToWave(1, 2, SpawnPointID_Left, CommonRouteID_Left, 3, new List<int> { MonsterID_CommonMonster }, 180, 8);
		AddGroupToWave(1, 4, SpawnPointID_Elite2, CommonRouteID_Elite2, 1, new List<int> { MonsterID_HardMonster }, 180, 8);
		AddGroupToWave(1, 5, SpawnPointID_Elite3, CommonRouteID_Elite3, 1, new List<int> { MonsterID_HardMonster }, 180, 8);
		AddGroupToWave(1, 6, SpawnPointID_Elite4, CommonRouteID_Elite4, 1, new List<int> { MonsterID_HardMonster }, 180, 8);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_Up, CommonRouteID_Up, 12, new List<int> { MonsterID_FastMonster }, -90, 4);
		AddGroupToWave(2, 2, SpawnPointID_Left, CommonRouteID_Left, 5, new List<int> { MonsterID_FastMonster }, 180, 8);
		AddGroupToWave(2, 3, SpawnPointID_Elite1, CommonRouteID_Elite1, 1, new List<int> { MonsterID_YinYing }, 180, 8);
		AddGroupToWave(2, 4, SpawnPointID_Elite2, CommonRouteID_Elite2, 1, new List<int> { MonsterID_YinYing }, 180, 8);
		AddGroupToWave(2, 5, SpawnPointID_Elite3, CommonRouteID_Elite3, 1, new List<int> { MonsterID_YinYing }, 180, 8);
		AddGroupToWave(2, 6, SpawnPointID_Elite4, CommonRouteID_Elite4, 1, new List<int> { MonsterID_YinYing }, 180, 8);
		AddGroupToWave(2, 7, SpawnPointID_Elite5, CommonRouteID_Elite5, 1, new List<int> { MonsterID_YinYing }, 180, 8);
		PreloadMonster(new List<int> { MonsterID_CommonMonster, MonsterID_FastMonster, MonsterID_HardMonster, MonsterID_YinYing });
	}

	internal override IEnumerator DoMainLogic()
	{
		ActiveWave(1);
		ActiveGroup(4);
		ActiveGroup(5);
		ActiveGroup(6);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Left, CommonRouteID_Up }, IsSameTime: true));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitTime(17.5);
		ActiveGroup(2);
		yield return WaitUntil_WaveClear();
		yield return WaitTime(4);
		ActiveWave(2);
		ActiveGroup(3);
		ActiveGroup(4);
		ActiveGroup(5);
		ActiveGroup(6);
		ActiveGroup(7);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Up, CommonRouteID_Left }, IsSameTime: true));
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
