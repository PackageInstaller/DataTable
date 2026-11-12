using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_1_8 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_CommonMonster = 8069901;

	private readonly int MonsterID_CommonMonster_Plus = 8069902;

	private readonly int MonsterID_FastMonster = 8069903;

	private readonly int MonsterID_FastMonster_Plus = 8069904;

	private readonly int MonsterID_HardMonster = 8079901;

	private readonly int MonsterID_SpeedUpMonster = 8079902;

	private readonly int MonsterID_BuffJingLingMonster = 8089901;

	private readonly int SpawnPointID_UpLeft = 64;

	private readonly int SpawnPointID_UpRight = 67;

	private readonly int SpawnPointID_DownLeft = 4;

	private readonly int SpawnPointID_DownRight = 7;

	private readonly int BossRouteID_1 = 91;

	private readonly int BossRouteID_2 = 92;

	private readonly int RouteID_UpLeftToRight_Far;

	private readonly int RouteID_DownRightToLeft_Far = 1;

	private readonly int RouteID_UpRightToLeft_Near = 10;

	private readonly int RouteID_DownLeftToRight_Near = 11;

	private readonly int RouteID_UpRightToLeft_Patrol = 20;

	private readonly int RouteID_DownLeftToRight_Patrol = 21;

	private Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 0, 13 },
		{ 1, 11 },
		{ 10, 8 },
		{ 11, 10 },
		{ 20, 24 },
		{ 21, 22 },
		{ 91, 12 },
		{ 92, 10 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(0);
		AddGroupToWave(0, 1, 52, BossRouteID_1, 1, new List<int> { MonsterID_BuffJingLingMonster }, 180, 5);
		AddGroupToWave(0, 2, 19, BossRouteID_2, 1, new List<int> { MonsterID_BuffJingLingMonster }, 0, 4);
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_UpLeft, RouteID_UpLeftToRight_Far, 12, new List<int> { MonsterID_CommonMonster }, 180, 3);
		AddGroupToWave(1, 2, SpawnPointID_DownRight, RouteID_DownRightToLeft_Far, 10, new List<int> { MonsterID_FastMonster }, 0, 3);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_UpRight, RouteID_UpRightToLeft_Near, 20, new List<int> { MonsterID_FastMonster }, 180, 2.5f);
		AddGroupToWave(2, 2, SpawnPointID_DownLeft, RouteID_DownLeftToRight_Near, 20, new List<int> { MonsterID_CommonMonster }, 0, 2.5f);
		AddGroupToWave(2, 3, SpawnPointID_UpRight, RouteID_UpRightToLeft_Near, 2, new List<int> { MonsterID_SpeedUpMonster }, 180, 30);
		AddGroupToWave(2, 4, SpawnPointID_DownLeft, RouteID_DownLeftToRight_Near, 1, new List<int> { MonsterID_SpeedUpMonster }, 0, 30);
		AddWave(3);
		AddGroupToWave(3, 1, SpawnPointID_UpRight, RouteID_UpRightToLeft_Patrol, 13, new List<int> { MonsterID_HardMonster }, 180, 4);
		PreloadMonster(new List<int> { MonsterID_CommonMonster, MonsterID_CommonMonster_Plus, MonsterID_FastMonster, MonsterID_FastMonster_Plus, MonsterID_SpeedUpMonster, MonsterID_HardMonster, MonsterID_BuffJingLingMonster });
	}

	internal override IEnumerator DoMainLogic()
	{
		ShowMonsterInfoUI(MonsterID_BuffJingLingMonster);
		ActiveWave(0);
		ActiveGroup(1);
		ActiveGroup(2);
		yield return WaitTime(2);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { RouteID_UpLeftToRight_Far, RouteID_DownRightToLeft_Far }, IsSameTime: true));
		ActiveWave(1);
		ActiveGroup(1);
		yield return WaitTime(15);
		ActiveGroup(2);
		yield return WaitUntil_WaveClear();
		yield return WaitTime(7);
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { RouteID_UpRightToLeft_Near, RouteID_DownLeftToRight_Near }, IsSameTime: true));
		ActiveWave(2);
		ActiveGroup(1);
		ActiveGroup(2);
		yield return WaitTime(15);
		ActiveGroup(3);
		yield return WaitTime(15);
		ActiveGroup(4);
		yield return WaitUntil_WaveClear();
		yield return WaitTime(7);
		GiveARoleCard();
		GiveARoleCard();
		yield return StartCoroutine(ShowRouteFlows(new List<int> { RouteID_UpRightToLeft_Patrol }, IsSameTime: true));
		yield return WaitTime(2);
		ActiveWave(3);
		ActiveGroup(1);
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
