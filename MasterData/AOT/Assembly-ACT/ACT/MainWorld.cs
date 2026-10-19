using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.MultiPlayer;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.Utility;

namespace ACT;

internal class MainWorld : WorldBase
{
	internal override SceneStatus SceneStatus => SceneStatus.Main;

	internal override void InitWorldData(WorldData data)
	{
		_worldData = data;
		SceneInfo sceneInfo = G.localPlayer.Profile.SceneInfos[0];
		_worldData.WorldID = sceneInfo.WorldID;
		GameWorld data2 = CoreUtils.GetData(sceneInfo.WorldID, RuntimeConfigs.data.gameWorlds);
		_worldData.WorldConfigId = data2?.config ?? sceneInfo.WorldID;
		_worldData.SpawnPosition = sceneInfo.LastPos.ToUnity();
		_worldData.ChunkId = sceneInfo.ChunkID;
		PresetTeam presetTeam = G.localPlayer.teamInfo.PresetTeams[G.localPlayer.teamInfo.MainTeamIdx];
		if (!G.localPlayer.teamInfo.Teams.TryGetValue((int)SceneStatus, out var value))
		{
			value = new TeamList();
			G.localPlayer.teamInfo.Teams.Add((int)SceneStatus, value);
			value.Teams.Add(new Team());
		}
		_worldData.TeamInfo = G.localPlayer.teamInfo.Teams[(int)SceneStatus].Teams[0];
		ResetTeamCharacters(presetTeam.CharacterIds.ToList());
		ResetTeamPotion(presetTeam.EquipPotionId);
		_worldData.TeamInfo.BattleCharacterIdx = ResolveBattleCharacterIndex(presetTeam);
	}

	internal override void UninitWorldData()
	{
		G.localPlayer.teamInfo.Teams.Remove((int)SceneStatus);
	}

	internal override void Update()
	{
	}

	protected override void AddListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AllCharacterDieEnd, AllCharacterDie);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Team_RespawnCompelete, RespawnCompelete);
	}

	protected override void RemoveListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AllCharacterDieEnd, AllCharacterDie);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Team_RespawnCompelete, RespawnCompelete);
	}

	protected override async void OnFail()
	{
		await Singleton<RespawnManager>.instance.CoRespawn(RuntimeConfigs.data.game.mainArchiveRevivalHp);
	}

	internal override Character GetCharacter(int characterId)
	{
		CharacterDataHelper.TryGetCharacter(SceneStatus, characterId, out var character);
		return character;
	}

	protected override bool NeedRemoveBeahve()
	{
		return false;
	}

	private void AllCharacterDie(BaseEventContent evt)
	{
		WorldChallengeState = WorldChallengeState.Fail;
	}

	private void RespawnCompelete(BaseEventContent evt)
	{
		WorldChallengeState = WorldChallengeState.Normal;
	}

	private int ResolveBattleCharacterIndex(PresetTeam presetTeam)
	{
		RepeatedField<int> characterIds = presetTeam.CharacterIds;
		int battleCharacterIdx = presetTeam.BattleCharacterIdx;
		int num = ((MPPlayer.local != null) ? MPPlayer.local.GetNormalRuntimeBattleIndex(battleCharacterIdx) : battleCharacterIdx);
		return MPPlayer.local.SelectAliveMemberIndex(characterIds?.Count ?? 0, num, battleCharacterIdx, num, (int index) => IsAliveBattleCharacter(characterIds, index));
	}

	private bool IsAliveBattleCharacter(IList<int> characterIds, int index)
	{
		if (characterIds == null || index < 0 || index >= characterIds.Count || characterIds[index] == 0)
		{
			return false;
		}
		if (CharacterDataHelper.TryGetCharacter(SceneStatus, characterIds[index], out var character))
		{
			return character.IsRuntimeAlive();
		}
		return false;
	}
}
