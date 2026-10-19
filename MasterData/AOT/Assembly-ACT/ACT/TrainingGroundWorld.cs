using System;
using System.Linq;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT;

internal class TrainingGroundWorld : WorldBase
{
	internal override SceneStatus SceneStatus => SceneStatus.Trainingground;

	internal override void InitWorldData(WorldData data)
	{
		_worldData = data;
		_worldData.WorldID = Model<TrainingGroundModel>.Interface.enemyConfig.worldId;
		_worldData.WorldConfigId = (RuntimeConfigs.data.gameWorlds.TryGetValue(_worldData.WorldID, out var value) ? value.config : _worldData.WorldID);
		_worldData.UseWorldSpawnPosition = true;
		PresetTeam presetTeam = G.localPlayer.teamInfo.PresetTeams[G.localPlayer.teamInfo.MainTeamIdx];
		if (!G.localPlayer.teamInfo.Teams.TryGetValue((int)SceneStatus, out var value2))
		{
			value2 = new TeamList();
			G.localPlayer.teamInfo.Teams.Add((int)SceneStatus, value2);
			value2.Teams.Add(new Team());
		}
		_worldData.TeamInfo = value2.Teams[0];
		ResetTeamCharacters(presetTeam.CharacterIds.ToList());
		ResetTeamPotion(presetTeam.EquipPotionId);
		_worldData.TeamInfo.BattleCharacterIdx = 0;
	}

	internal override void UninitWorldData()
	{
		G.localPlayer.teamInfo.Teams.Remove((int)SceneStatus);
	}

	internal override void Update()
	{
		base.Update();
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
		G.localPlayer.Profile.SceneInfos[(int)SceneStatus].SpawnInfo = new SceneSpawnInfo
		{
			Pos = _worldData.SpawnPosition.ToPB(),
			ChunkID = _worldData.ChunkId,
			InteractionObjUID = -1
		};
		await Singleton<RespawnManager>.instance.CoRespawn(1f, SceneStatus);
	}

	protected override async UniTask OnBeforeEnterWorld()
	{
		base.OnBeforeEnterWorld();
	}

	protected override async UniTask OnAfterEnterWorld()
	{
		MonoECS.instance.PopPause();
		EnterTrainingGround();
	}

	protected override async UniTask OnBeforeLeaveWorld()
	{
		await MonoECS.instance.KillAllTrainingGroundEnemy(immediately: true);
		Model<TrainingGroundModel>.Interface.ResetOrginalConfig();
	}

	protected override async UniTask OnAfterLeaveWorld()
	{
		LeaveTrainingGround();
	}

	internal override Character GetCharacter(int characterId)
	{
		if (CharacterDataHelper.TryGetCharacter(SceneStatus, characterId, out var character))
		{
			return character;
		}
		CharacterDataHelper.TryGetExtraCharacter(SceneStatus, characterId, out character);
		return character;
	}

	private void EnterTrainingGround()
	{
		FreeTrainGround evt = EventTrackSolver.Instance.GetEvt<FreeTrainGround>();
		evt.status = 1;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private void LeaveTrainingGround()
	{
		FreeTrainGround evt = EventTrackSolver.Instance.GetEvt<FreeTrainGround>();
		evt.status = 3;
		evt.eventDuration = (float)(DateTime.Now - _worldStartTime).TotalSeconds;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private void AllCharacterDie(BaseEventContent evt)
	{
		WorldChallengeState = WorldChallengeState.Fail;
	}

	private void RespawnCompelete(BaseEventContent evt)
	{
		WorldChallengeState = WorldChallengeState.Normal;
	}
}
