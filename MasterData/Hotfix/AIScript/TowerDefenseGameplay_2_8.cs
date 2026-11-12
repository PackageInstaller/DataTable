using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript;

internal class TowerDefenseGameplay_2_8 : TowerDefenseGameplayBase
{
	private readonly int MonsterID_CommonMonster = 8069901;

	private readonly int MonsterID_FastMonster = 8069903;

	private readonly int MonsterID_CommonMonster_Plus = 8069902;

	private readonly int MonsterID_FastMonster_Plus = 8069904;

	private readonly int MonsterID_YinYing = 8079903;

	private readonly int MonsterID_HardMonster = 8079901;

	private readonly int MonsterID_ChuanSongGuai = 8089902;

	private readonly int CommonRouteID_LUtoRD = 10;

	private readonly int CommonRouteID_RUtoLD = 11;

	private readonly int CommonRouteID_LDtoRU = 12;

	private readonly int CommonRouteID_RDtoLU = 13;

	private readonly int CommonRouteID_LUtoRD_Elite = 14;

	private readonly int CommonRouteID_RUtoLD_Elite = 15;

	private readonly int CommonRouteID_LDtoRU_Elite = 16;

	private readonly int CommonRouteID_RDtoLU_Elite = 17;

	private readonly int CommonRouteID_Boss_Up;

	private readonly int CommonRouteID_Boss_Down = 1;

	private readonly int SpawnPointID_LeftUp = 52;

	private readonly int SpawnPointID_RightUp = 55;

	private readonly int SpawnPointID_LeftDown = 16;

	private readonly int SpawnPointID_RightDown = 19;

	private readonly int SpawnPointID_BossUp = 53;

	private readonly int SpawnPointID_BossDown = 18;

	private readonly Dictionary<int, int> RouteDic = new Dictionary<int, int>
	{
		{ 10, 11 },
		{ 11, 11 },
		{ 12, 13 },
		{ 13, 11 }
	};

	protected override void InitSpawnContainer()
	{
		AddWave(0);
		AddGroupToWave(0, 1, SpawnPointID_BossUp, CommonRouteID_Boss_Up, 1, new List<int> { MonsterID_ChuanSongGuai }, -90, 1);
		AddGroupToWave(0, 2, SpawnPointID_BossDown, CommonRouteID_Boss_Down, 1, new List<int> { MonsterID_ChuanSongGuai }, 90, 1);
		AddWave(1);
		AddGroupToWave(1, 1, SpawnPointID_LeftUp, CommonRouteID_LUtoRD, 9, new List<int> { MonsterID_CommonMonster, MonsterID_CommonMonster, MonsterID_FastMonster }, -90, 4);
		AddGroupToWave(1, 2, SpawnPointID_RightDown, CommonRouteID_RDtoLU, 4, new List<int> { MonsterID_FastMonster, MonsterID_CommonMonster, MonsterID_FastMonster }, 90, 9);
		AddWave(2);
		AddGroupToWave(2, 1, SpawnPointID_LeftDown, CommonRouteID_LDtoRU, 8, new List<int> { MonsterID_CommonMonster_Plus }, -90, 6);
		AddGroupToWave(2, 2, SpawnPointID_RightUp, CommonRouteID_RUtoLD, 5, new List<int> { MonsterID_FastMonster_Plus }, 90, 10);
		AddGroupToWave(2, 3, SpawnPointID_LeftDown, CommonRouteID_LDtoRU_Elite, 1, new List<int> { MonsterID_HardMonster }, -90, 15);
		AddGroupToWave(2, 4, SpawnPointID_RightUp, CommonRouteID_RUtoLD_Elite, 1, new List<int> { MonsterID_YinYing }, 90, 15);
		AddWave(3);
		AddGroupToWave(3, 1, SpawnPointID_LeftUp, CommonRouteID_LUtoRD, 6, new List<int> { MonsterID_CommonMonster_Plus, MonsterID_CommonMonster_Plus, MonsterID_FastMonster_Plus }, -90, 9);
		AddGroupToWave(3, 2, SpawnPointID_RightDown, CommonRouteID_RDtoLU, 6, new List<int> { MonsterID_FastMonster_Plus, MonsterID_CommonMonster_Plus, MonsterID_FastMonster_Plus }, 90, 9);
		AddGroupToWave(3, 3, SpawnPointID_LeftDown, CommonRouteID_LDtoRU, 6, new List<int> { MonsterID_CommonMonster_Plus, MonsterID_CommonMonster_Plus, MonsterID_FastMonster_Plus }, -90, 9);
		AddGroupToWave(3, 4, SpawnPointID_RightUp, CommonRouteID_RUtoLD, 6, new List<int> { MonsterID_FastMonster_Plus, MonsterID_CommonMonster_Plus, MonsterID_FastMonster_Plus }, 90, 9);
		AddGroupToWave(3, 5, SpawnPointID_LeftUp, CommonRouteID_LUtoRD_Elite, 1, new List<int> { MonsterID_HardMonster }, -90, 8);
		AddGroupToWave(3, 6, SpawnPointID_RightDown, CommonRouteID_RDtoLU_Elite, 1, new List<int> { MonsterID_YinYing }, 90, 8);
		PreloadMonster(new List<int> { MonsterID_ChuanSongGuai, MonsterID_CommonMonster, MonsterID_CommonMonster_Plus, MonsterID_FastMonster, MonsterID_FastMonster_Plus, MonsterID_YinYing, MonsterID_HardMonster });
	}

	internal override IEnumerator DoMainLogic()
	{
		ActiveWave(0);
		ActiveGroup(1);
		ActiveGroup(2);
		yield return WaitTime(2);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_LUtoRD, CommonRouteID_RDtoLU }, IsSameTime: true));
		ActiveWave(1);
		ActiveGroup(1);
		ActiveGroup(2);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		GiveARoleCard();
		yield return WaitTime(2);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_LDtoRU, CommonRouteID_RUtoLD }, IsSameTime: true));
		ActiveWave(2);
		ActiveGroup(1);
		ActiveGroup(2);
		yield return WaitTime(30);
		ActiveGroup(3);
		ActiveGroup(4);
		yield return WaitUntil_WaveClear();
		GiveARoleCard();
		yield return WaitTime(1);
		yield return StartCoroutine(ShowRouteFlows(new List<int> { CommonRouteID_LUtoRD, CommonRouteID_RDtoLU, CommonRouteID_LDtoRU, CommonRouteID_RUtoLD }, IsSameTime: true));
		ActiveWave(3);
		ActiveGroup(1);
		ActiveGroup(2);
		ActiveGroup(3);
		ActiveGroup(4);
		yield return WaitTime(35);
		ActiveGroup(5);
		ActiveGroup(6);
		ActiveGroup(7);
		ActiveGroup(8);
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
