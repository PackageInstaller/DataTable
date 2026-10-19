using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using UnityEngine;

namespace ACT.Game;

public class LocalPlayerProfile : ScriptableObject
{
	private const int AvatarId = 10001;

	private const string NickName = "玩家";

	private const string Signature = "这是测试场景";

	public int worldUid;

	public int world;

	public int chunkId;

	public Vector3 spawnPos;

	public Vector3 lastPos;

	public int checkPosUid = -1;

	public int battleTeamIdx;

	public LocalTeam[] teams;

	private bool TryGetGameWorldConfigByConfigId(int configId, out GameWorld config)
	{
		config = null;
		foreach (KeyValuePair<int, GameWorld> gameWorld in RuntimeConfigs.data.gameWorlds)
		{
			if (gameWorld.Value.config == configId)
			{
				config = gameWorld.Value;
				break;
			}
		}
		return config != null;
	}

	public PlayerProfile ToPB()
	{
		PlayerProfile playerProfile = new PlayerProfile();
		SceneInfo value = new SceneInfo
		{
			WorldID = worldUid,
			ChunkID = chunkId,
			SpawnInfo = new SceneSpawnInfo
			{
				Pos = spawnPos.ToPB(),
				InteractionObjUID = -1
			},
			LastPos = lastPos.ToPB(),
			CheckPosUid = checkPosUid
		};
		EscInfo escInfo = new EscInfo
		{
			AccountId = 0L,
			NickName = "玩家",
			Signature = "这是测试场景",
			CurAvatarId = 10001
		};
		playerProfile.SceneInfos.Add(0, value);
		playerProfile.PlayingMusic = 0;
		playerProfile.EscInfo = escInfo;
		return playerProfile;
	}
}
