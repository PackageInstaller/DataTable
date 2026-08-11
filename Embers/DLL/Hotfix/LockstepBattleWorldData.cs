using System;
using System.Collections.Generic;
using Ase;

public class LockstepBattleWorldData : BattleWorldData
{
	public Action<int, int> UpdateProgressAction;

	public Action GameStartAction;

	public Action LostConnectAction;

	public LockStepWorldType LockStepWorldType;

	public string Ip;

	public int Port;

	public long UserId;

	public long RoomKey;

	public uint LocalConnectId;

	public static WorldData CreateSyncWorldData(uint serialId, string sceneName, int copyId, int bossId, string mapDataName, string bonfireKey, int navMeshId, List<PeripheryHeroData> teamList, List<TeamMember> teamMembers, PreloadBattleData preloadBattleData, int randomSeed, long roomId, long roomKey, LockStepWorldType lockStepWorldType, long userId, int selfIndex, string ip, int port, uint localConnectId, List<AchievementMedal> battleAchievementMedalList)
	{
		return new LockstepBattleWorldData
		{
			WorldId = serialId,
			WorldName = sceneName,
			SceneLoadPath = "Copy/" + sceneName,
			MapDataName = mapDataName,
			TeamListConfig = teamList,
			TeamMemberList = teamMembers,
			NavMeshId = navMeshId,
			RandomSeed = randomSeed,
			CopyId = copyId,
			BossId = bossId,
			PreloadBattleData = preloadBattleData,
			SelfIndex = selfIndex,
			LockStepWorldType = lockStepWorldType,
			Ip = ip,
			Port = port,
			RoomId = roomId,
			UserId = userId,
			RoomKey = roomKey,
			BattleAchievementMedalList = battleAchievementMedalList,
			LocalConnectId = localConnectId
		};
	}
}
