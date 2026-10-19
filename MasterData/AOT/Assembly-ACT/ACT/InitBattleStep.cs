using System;
using ACT.Battle;
using ACT.Game;
using ACT.Game.Data;
using ACT.Utility;
using UnityEngine;

namespace ACT;

internal class InitBattleStep : WorldLoadStepOperation
{
	internal override void OnStart()
	{
		MonoECS.instance.playerStateChange += new Action<PlayState, PlayState>(MonoECS.instance.BttleStateChange);
		GameManager.abilitySystem.PreloadVolume();
		SceneInfo sceneInfo = G.localPlayer.Profile.SceneInfos[(int)G.localPlayer.Profile.SceneStatus];
		bool flag = MonoECS.instance.CharacterRecovery();
		int chunkID = sceneInfo.ChunkID;
		Vector3 me;
		if (flag)
		{
			me = G.localPlayer.GetSpawnPos(MonoECS.instance.sceneStatus);
			chunkID = G.localPlayer.GetSpawnChunkId(MonoECS.instance.sceneStatus);
		}
		else
		{
			me = G.localPlayer.GetLastPos(MonoECS.instance.sceneStatus);
		}
		SceneInfo sceneInfo2 = G.localPlayer.Profile.SceneInfos[(int)MonoECS.instance.sceneStatus];
		sceneInfo2.LastPos = me.ToPB();
		sceneInfo2.ChunkID = chunkID;
		Vector3 spawnPos = G.localPlayer.GetSpawnPos(MonoECS.instance.sceneStatus);
		MonoECS.instance.InitializePlayerSyncPosition(spawnPos);
		State = OptionState.Succeed;
	}

	internal override void OnUpdate()
	{
	}
}
