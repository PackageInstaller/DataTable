using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_2_3 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_CommonMonster = 8069901;

	private readonly int MonsterID_YinYing = 8079903;

	private readonly int CommonRouteID_Up;

	private readonly int CommonRouteID_Left = 1;

	private readonly int CommonRouteID_Elite = 10;

	private readonly int SpawnPointID_Up = 42;

	private readonly int SpawnPointID_Left = 20;

	private readonly int SpawnPointID_Elite = 42;

	private readonly int Tutorial_Item = 400208;

	private readonly int Tutorial_Role110 = 400209;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 12 },
		{ 1, 10 },
		{ 10, 6 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_Left, CommonRouteID_Left, 5, new List<int> { MonsterID_CommonMonster }, -90, 8);
		AddGroupToWave(1, 2, SpawnPointID_Up, CommonRouteID_Up, 3, new List<int> { MonsterID_CommonMonster }, 180, 8);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_Elite, CommonRouteID_Elite, 2, new List<int> { MonsterID_YinYing }, -90, 15);
		AddGroupToWave(2, 2, SpawnPointID_Up, CommonRouteID_Up, 10, new List<int> { MonsterID_CommonMonster }, 180, 4);
		AddGroupToWave(2, 3, SpawnPointID_Left, CommonRouteID_Left, 7, new List<int> { MonsterID_CommonMonster }, -90, 3);
		PreloadMonster(new List<int> { MonsterID_CommonMonster, MonsterID_YinYing });
		MarkHasDicTopBar();
	}

	internal override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1);
		ShowDicTopbar(Tutorial_Item);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Left, CommonRouteID_Up }, IsSameTime: false));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitTime(17.5);
		ActiveGroup(2);
		yield return WaitUntil_WaveClear();
		yield return WaitTime(3);
		GiveARoleCard();
		ActiveWave(2);
		ShowDicTopbar(Tutorial_Role110);
		yield return WaitTime(1);
		ActiveGroup(1);
		ShowMonsterInfoUI(MonsterID_YinYing);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Left, CommonRouteID_Up }, IsSameTime: false));
		ActiveGroup(2);
		yield return WaitTime(20);
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
