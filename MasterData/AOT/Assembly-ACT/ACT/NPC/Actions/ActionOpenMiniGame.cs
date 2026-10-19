using System;
using ACT.Battle;
using ACT.Config;
using ACT.Event;
using ACT.MissionSystem;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.NPC.Actions;

[Serializable]
[AsyncAction]
public class ActionOpenMiniGame : NpcInteractAction
{
	private const float ConfigWaitSeconds = 5f;

	public MissionMiniGameType miniGameType;

	public int miniGameId;

	public SeparateSegmentConfigs.Difficulty difficulty = SeparateSegmentConfigs.Difficulty.Normal;

	public bool custom;

	public SeparateSegmentConfig separateSegmentConfig;

	private bool _finished;

	private bool _challengeStarted;

	private ChallengeType _startedChallengeType;

	public override int ActionId => NpcInteractActionIds.OpenMiniGame;

	private bool IsConnectionMiniGame()
	{
		return miniGameType == MissionMiniGameType.Connection;
	}

	private bool UseCustomConnectionConfig()
	{
		if (IsConnectionMiniGame())
		{
			return custom;
		}
		return false;
	}

	protected override async UniTask DoAction()
	{
		_finished = false;
		_challengeStarted = false;
		try
		{
			switch (miniGameType)
			{
			case MissionMiniGameType.Connection:
				await OpenConnectionMiniGame();
				break;
			case MissionMiniGameType.RunningChallenge:
				await StartBigWorldChallenge(ChallengeType.Running);
				break;
			case MissionMiniGameType.BattleChallenge:
				await StartBigWorldChallenge(ChallengeType.Battle);
				break;
			default:
				Debug.LogError(string.Format("{0} 不支持的小游戏类型：{1} npc={2}", "ActionOpenMiniGame", miniGameType, _npcId));
				return;
			}
			await UniTask.WaitUntil(() => _finished);
		}
		finally
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BigWorldChallenge_Result, OnBigWorldChallengeResult);
		}
		await base.DoAction();
	}

	private async UniTask OpenConnectionMiniGame()
	{
		SeparateSegmentConfig separateSegmentConfig = ((!custom) ? (await LoadRandomConnectionConfig()) : this.separateSegmentConfig);
		SeparateSegmentConfig separateSegmentConfig2 = separateSegmentConfig;
		if (separateSegmentConfig2 == null)
		{
			Debug.LogError(string.Format("{0} 连线小游戏配置为空：custom={1} difficulty={2} npc={3}", "ActionOpenMiniGame", custom, difficulty, _npcId));
			_finished = true;
		}
		else if (!Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CONNECTIONMINIGAME, new ConnectionMiniGameViewData
		{
			separateSegmentConfig = separateSegmentConfig2,
			callback = OnConnectionMiniGameCompleted
		}).IsValid)
		{
			Debug.LogError(string.Format("{0} 打开连线小游戏界面失败：npc={1}", "ActionOpenMiniGame", _npcId));
			_finished = true;
		}
	}

	private async UniTask<SeparateSegmentConfig> LoadRandomConnectionConfig()
	{
		SeparateSegmentGameModel gameModel = Model<SeparateSegmentGameModel>.Interface;
		if (gameModel == null)
		{
			return null;
		}
		if (!gameModel.IsInitialized)
		{
			try
			{
				await UniTask.WaitUntil(() => gameModel.IsInitialized).Timeout(TimeSpan.FromSeconds(5.0));
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
				return null;
			}
		}
		return gameModel.GetRandomConfigs(difficulty);
	}

	private void OnConnectionMiniGameCompleted(bool failed)
	{
		_finished = true;
	}

	private async UniTask StartBigWorldChallenge(ChallengeType challengeType)
	{
		if (!(await WaitChallengeConfigReady(challengeType)))
		{
			Debug.LogError(string.Format("{0} 挑战配置未就绪：type={1} id={2} npc={3}", "ActionOpenMiniGame", challengeType, miniGameId, _npcId));
			_finished = true;
		}
		else
		{
			_startedChallengeType = challengeType;
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.BigWorldChallenge_Result, OnBigWorldChallengeResult);
			Singleton<BigWorldChallengeManager>.instance.StartChallenge(challengeType, miniGameId, Context.Npc.GetRootTransform());
			_challengeStarted = true;
		}
	}

	private async UniTask<bool> WaitChallengeConfigReady(ChallengeType challengeType)
	{
		if (IsChallengeConfigReady(challengeType))
		{
			return true;
		}
		try
		{
			await UniTask.WaitUntil(() => IsChallengeConfigReady(challengeType)).Timeout(TimeSpan.FromSeconds(5.0));
			return true;
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			return false;
		}
	}

	private bool IsChallengeConfigReady(ChallengeType challengeType)
	{
		switch (challengeType)
		{
		case ChallengeType.Running:
		{
			RunningChallengeConfig runningChallengeConfig = (Singleton<RunningChallengeManager>.instance.IsInitialized ? Singleton<RunningChallengeManager>.instance.GetConfigById(miniGameId) : null);
			if (runningChallengeConfig != null)
			{
				Vector3[] checkpointPositions = runningChallengeConfig.CheckpointPositions;
				if (checkpointPositions != null && checkpointPositions.Length > 0)
				{
					return GameUtility.RuntimeGuidIsValid(runningChallengeConfig.CheckpointModelGuid);
				}
			}
			return false;
		}
		case ChallengeType.Battle:
		{
			BattleChallengeConfig battleChallengeConfig = (Singleton<BattleChallengeManager>.instance.IsInitialized ? Singleton<BattleChallengeManager>.instance.GetConfigById(miniGameId) : null);
			if (battleChallengeConfig != null)
			{
				BattleSpawnPointConfig[] spawnPoints = battleChallengeConfig.SpawnPoints;
				if (spawnPoints != null)
				{
					return spawnPoints.Length > 0;
				}
				return false;
			}
			return false;
		}
		default:
			return false;
		}
	}

	private void OnBigWorldChallengeResult(BaseEventContent eventContent)
	{
		if (_challengeStarted && !_finished && eventContent is BigWorldChallengeResultEvt bigWorldChallengeResultEvt && bigWorldChallengeResultEvt.challengeType == _startedChallengeType && bigWorldChallengeResultEvt.configId == miniGameId)
		{
			_finished = true;
		}
	}
}
