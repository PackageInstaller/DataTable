using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_2_1 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_CommonMonster = 8069901;

	private readonly int CommonRouteID_Left;

	private readonly int CommonRouteID_Right = 1;

	private readonly int CommonRouteID_Left_Wait_1 = 10;

	private readonly int CommonRouteID_Right_Wait_1 = 11;

	private readonly int CommonRouteID_Left_Wait_2 = 20;

	private readonly int CommonRouteID_Right_Wait_2 = 21;

	private readonly int DieRouteID = 30;

	private readonly int SpawnPointID_1 = 25;

	private readonly int SpawnPointID_2 = 29;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 3 },
		{ 1, 3 }
	};

	private readonly int Tutorial_Water = 400205;

	private readonly int Tutorial_Pull = 400211;

	protected override void InitSpawnContainer()
	{
		AddWave(0);
		AddGroupToWave(0, 1, SpawnPointID_1, DieRouteID, 2, new List<int> { MonsterID_CommonMonster }, 180, 2);
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_1, CommonRouteID_Left_Wait_1, 1, new List<int> { MonsterID_CommonMonster }, 180, 9);
		AddGroupToWave(1, 2, SpawnPointID_2, CommonRouteID_Right_Wait_1, 1, new List<int> { MonsterID_CommonMonster }, 180, 9);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_1, CommonRouteID_Left_Wait_1, 1, new List<int> { MonsterID_CommonMonster }, 180, 8);
		AddGroupToWave(2, 2, SpawnPointID_2, CommonRouteID_Right_Wait_1, 1, new List<int> { MonsterID_CommonMonster }, 180, 8);
		AddGroupToWave(2, 3, SpawnPointID_1, CommonRouteID_Left_Wait_2, 1, new List<int> { MonsterID_CommonMonster }, 180, 8);
		AddGroupToWave(2, 4, SpawnPointID_2, CommonRouteID_Right_Wait_2, 1, new List<int> { MonsterID_CommonMonster }, 180, 8);
		AddWave(3);
		AddGroupToWave(3, 1, SpawnPointID_1, CommonRouteID_Left, 5, new List<int> { MonsterID_CommonMonster }, 180, 0.25f);
		AddGroupToWave(3, 2, SpawnPointID_2, CommonRouteID_Right, 5, new List<int> { MonsterID_CommonMonster }, 180, 0.25f);
		PreloadMonster(new List<int> { MonsterID_CommonMonster });
		MarkHasDicTopBar();
	}

	internal override IEnumerator DoMainLogic()
	{
		ShowOperateUI(showOrClose: false);
		yield return WaitTime(1);
		ShowDicTopbar(Tutorial_Water);
		yield return WaitTime(1);
		ActiveWave(0);
		ActiveGroup(1);
		yield return WaitUntil_WaveClear();
		yield return WaitTime(1);
		ShowDicTopbar(Tutorial_Pull);
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Left, CommonRouteID_Right }, IsSameTime: false));
		ShowUITip("TowerDefense_Tutorial_Tips_2_1", 15f);
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitTime(6);
		ActiveGroup(2);
		yield return WaitUntil_WaveClear();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_Left, CommonRouteID_Right }, IsSameTime: true));
		ActiveWave(2);
		ActiveGroup(1);
		ActiveGroup(2);
		ActiveGroup(3);
		ActiveGroup(4);
		yield return WaitUntil_WaveClear();
		yield return WaitTime(2);
		ActiveWave(3);
		ActiveGroup(1);
		yield return WaitTime(5);
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
