using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.Core;
using ACT.EventTrack;
using ACT.LipSync;
using ACT.MultiPlayer;
using ACT.Rendering;
using ACT.Sound;
using ACT.Sound.Management;
using ACT.Timeline;
using ACT.UI;
using ACT.Utility;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Unity.Mathematics;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Rendering.Universal;
using UnityEngine.Timeline;

namespace ACT.Drama;

public class TimelineConversationManager : Singleton<TimelineConversationManager>
{
	public struct TimelinePlayState
	{
		public bool lightModeSceneChanged;

		public bool robotOperate;

		public bool letterBox;

		public bool conversationView;

		public bool conversationViewLetterBox;

		public bool loadChunkAndNPC;

		public bool registerFmodLipSync;

		public bool playTimeline;
	}

	private TimelineDialogue m_PlayingDialogue;

	private MonoConversationView m_SubTitle;

	private CancellationTokenSource m_CancellationTokenSource;

	private GameRenderScene.Scene m_PreviousRenderScene;

	private bool m_PauseInputPushed;

	private const string LeftModelAdmissionLayerName = "Admission";

	private const int LeftModelScreenLayer = 25;

	private const float LeftModelFadeOutDuration = 0.2f;

	private const float LeftModelFadeInDuration = 0.2f;

	private static readonly int LeftModelDitherGroupShaderId = Shader.PropertyToID("_DitherGroup");

	private static readonly int LeftModelDitherValueShaderId = Shader.PropertyToID("_DitherValue");

	private static readonly int LeftModelDissolveCutShaderId = Shader.PropertyToID("_Cut");

	private static readonly int LeftModelCharacterMainLightDirectionOverrideShaderId = Shader.PropertyToID("_CharacterMainLightDirectionOverride");

	private static readonly Quaternion LeftModelCharacterMainLightRotation = Quaternion.Euler(10f, -30f, 0f);

	private static readonly int Show = Animator.StringToHash("Show");

	private LeftModelScene m_LeftModelScene;

	private int m_CurrentLeftModelSpeakerId;

	private readonly Dictionary<int, GameObject> m_LeftModelCache = new Dictionary<int, GameObject>();

	private readonly MaterialPropertyBlock m_LeftModelCharacterLightPropertyBlock = new MaterialPropertyBlock();

	private readonly List<Material> m_LeftModelSharedMaterials = new List<Material>();

	private static bool m_LeftModelNativeRenderPassOverrideEnabled;

	private Dictionary<int, CancellationTokenSource> m_ModelTasks = new Dictionary<int, CancellationTokenSource>();

	private List<CancellationTokenSource> conversationClipCancels;

	public bool Playing { get; private set; }

	public bool DialogPlaying { get; private set; }

	public bool CanSkip
	{
		get
		{
			if (m_PlayingDialogue != null)
			{
				return m_PlayingDialogue.canSkip;
			}
			return false;
		}
	}

	public bool InSkip
	{
		get
		{
			if (m_PlayingDialogue != null)
			{
				return m_PlayingDialogue.inSkip;
			}
			return false;
		}
	}

	public MonoConversationView ConversationView => m_SubTitle;

	private static void ForEachConversationCG(TimelineAsset timelineAsset, Action<ConversationCGClip> action)
	{
		if (!timelineAsset)
		{
			return;
		}
		foreach (TrackAsset outputTrack in timelineAsset.GetOutputTracks())
		{
			if (!(outputTrack is ConversationCGTrack { mutedInHierarchy: false } conversationCGTrack))
			{
				continue;
			}
			foreach (TimelineClip clip in conversationCGTrack.GetClips())
			{
				if (clip.asset is ConversationCGClip { cgId: >0 } conversationCGClip)
				{
					action(conversationCGClip);
				}
			}
		}
	}

	private static async UniTask BeginConversationCGs(TimelineAsset timelineAsset, CancellationToken token)
	{
		if (!timelineAsset || token.IsCancellationRequested)
		{
			return;
		}
		try
		{
			List<UniTask> preloadTasks = ListPool<UniTask>.Get();
			try
			{
				ForEachConversationCG(timelineAsset, (ConversationCGClip clip) =>
				{
					preloadTasks.Add(clip.PreloadAsync(token));
				});
				if (preloadTasks.Count > 0)
				{
					await UniTask.WhenAll(preloadTasks);
				}
			}
			finally
			{
				ListPool<UniTask>.Release(preloadTasks);
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"Timeline CG 预加载失败\n{arg}");
			}
		}
	}

	private static void EndConversationCGs(TimelineAsset timelineAsset)
	{
		ForEachConversationCG(timelineAsset, (ConversationCGClip clip) =>
		{
			clip.ReleasePreloaded();
		});
	}

	public UniTask<bool> PlayTimeline(int id, Vector3 position = default(Vector3), PlayTimelineConfig config = default(PlayTimelineConfig))
	{
		return PlayTimelineById_Internal(id, null, position, config);
	}

	public UniTask<bool> PlayTimeline(int id, GameObject timelineInstance, Vector3 position = default(Vector3), PlayTimelineConfig config = default(PlayTimelineConfig))
	{
		timelineInstance?.SetActive(value: false);
		return PlayTimelineById_Internal(id, timelineInstance, position, config);
	}

	private async UniTask<bool> PlayTimelineById_Internal(int id, GameObject externalTimelineInstance, Vector3 position = default(Vector3), PlayTimelineConfig config = default(PlayTimelineConfig))
	{
		if (!RuntimeConfigs.data.dramaTimelineDatas.TryGetValue(id, out var value))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"错误的DramaTimelineId {id}");
			}
			return false;
		}
		string path = value.content;
		if (string.IsNullOrEmpty(path))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"空的dramaConversationData！ id {id}");
			}
			return false;
		}
		TimelineDialogue dialogue = new TimelineDialogue(id);
		dialogue.PlayLogic = async (CancellationToken token) =>
		{
			await PlayTimelineAsync(dialogue, token);
		};
		dialogue.StopLogic = () =>
		{
			EndLeftModels();
		};
		dialogue.BeginSkipLogic = () =>
		{
			HideLeftModel().Forget();
		};
		m_PlayingDialogue = dialogue;
		bool result = await Singleton<ConversationManager>.instance.BeginConversation(dialogue);
		if (m_PlayingDialogue == dialogue)
		{
			m_PlayingDialogue = null;
		}
		return result;
		async UniTask<bool> PlayTimelineAsync(TimelineDialogue timelineDialogue, CancellationToken token)
		{
			bool isExternalInstance = externalTimelineInstance != null;
			GameObject timelineInstance = externalTimelineInstance;
			long startTime = TimeManager.LocalTime.NowTimestamp;
			PlayTimelineConfig playingTimelineConfig = config;
			if (config.BlackScreenLoading)
			{
				Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreenText(0, 0f);
				await Singleton<NewUIManager>.instance.BlackScreen.Enable(new FrameworkBlackScreenData
				{
					fadeInTime = TimeSpan.FromSeconds(config.FadeInTime),
					fadeOutTime = TimeSpan.FromSeconds(config.FadeOutTime)
				});
				if (token.IsCancellationRequested)
				{
					return false;
				}
			}
			if (!token.IsCancellationRequested)
			{
				Entity mainEntity = MonoECS.instance.mainEntity;
				GameManager.behaveSystem.TimelineStop(mainEntity, playingTimelineConfig.BlackScreenLoading);
			}
			try
			{
				if (!timelineInstance)
				{
					AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(path, position, Quaternion.identity, (AssetLoadHandle loadHandle) =>
					{
						if (loadHandle.IsValid)
						{
							GameObject gameObject = loadHandle.AsGameObject();
							if ((bool)gameObject)
							{
								gameObject.SetActive(value: false);
							}
						}
					});
					await handle;
					timelineInstance = handle.AsGameObject();
				}
			}
			catch (Exception)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("找不到 " + path + " 对话Timeline");
				}
			}
			timelineDialogue.SetTimelineInstance(timelineInstance);
			if (!token.IsCancellationRequested)
			{
				MonoTimelineConfig component = timelineInstance.GetComponent<MonoTimelineConfig>();
				timelineDialogue.TimelineType = component.timelineConfig.timelineType;
			}
			if (!token.IsCancellationRequested)
			{
				TrackDramaEvt evt = EventTrackSolver.Instance.GetEvt<TrackDramaEvt>();
				evt.conversationId = timelineDialogue.TimelineId;
				evt.subId = 0L;
				TrackDramaEvt trackDramaEvt = evt;
				trackDramaEvt.type = timelineDialogue.TimelineType switch
				{
					TimelineType.Normal => 8, 
					TimelineType.DialogueStory => 1, 
					_ => throw new ArgumentOutOfRangeException(), 
				};
				evt.status = 1;
				evt.conversationDuration = 0.0;
				evt.isSkip = false;
				EventTrackSolver.Instance.Dispatch(evt);
			}
			try
			{
				_ = 2;
				try
				{
					await PlayTimelineInternal(timelineInstance, Vector3.zero, token);
					if (!isExternalInstance)
					{
						AssetStationManager.BattleStation.ReleaseInstance(timelineInstance);
					}
				}
				catch (Exception arg)
				{
					Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_BATTLEMAIN).Forget();
					if (LuminApplication.LogEnabled)
					{
						Debug.LogError($"播放timeline时出错 {arg}");
					}
				}
				if (!token.IsCancellationRequested)
				{
					Singleton<ConversationManager>.instance.SetKeyPoint(id);
					Singleton<ConversationManager>.instance.SendKeyPoints();
				}
				if (!token.IsCancellationRequested)
				{
					TrackDramaEvt evt2 = EventTrackSolver.Instance.GetEvt<TrackDramaEvt>();
					TrackDramaEvt trackDramaEvt = evt2;
					trackDramaEvt.type = timelineDialogue.TimelineType switch
					{
						TimelineType.Normal => 8, 
						TimelineType.DialogueStory => 1, 
						_ => throw new ArgumentOutOfRangeException(), 
					};
					evt2.status = 2;
					evt2.conversationId = id;
					evt2.subId = 0L;
					evt2.conversationDuration = TimeManager.GetTimeSpan(TimeManager.LocalTime.NowTimestamp - startTime).TotalSeconds;
					evt2.isSkip = InSkip;
					EventTrackSolver.Instance.Dispatch(evt2);
				}
				return true;
			}
			finally
			{
				Reset();
			}
		}
	}

	private void RestorePlayerInput()
	{
		if (m_PauseInputPushed)
		{
			MonoECS.instance?.PopPauseInput();
			m_PauseInputPushed = false;
		}
	}

	public override void Init()
	{
		RestorePlayerInput();
		m_CancellationTokenSource?.Cancel();
		m_CancellationTokenSource = new CancellationTokenSource();
		InitObsolete();
	}

	public override void UnInit()
	{
		try
		{
			RestorePlayerInput();
			EndLeftModels();
			UnInitObsolete();
			m_CancellationTokenSource?.Cancel();
			m_CancellationTokenSource = null;
		}
		finally
		{
			AsideManager.instance.PopPlaybackBlock(this);
		}
	}

	public async UniTask PlayTimeline(GameObject timelineGo)
	{
		CancellationTokenSource cts = new CancellationTokenSource();
		await PlayTimeline(timelineGo, cts.Token);
		cts?.Cancel();
		cts?.Dispose();
	}

	public async UniTask PlayTimeline(GameObject timelineGo, CancellationToken token)
	{
		if (await WaitForPlayerOperationEnd(token))
		{
			return;
		}
		if (Singleton<ConversationManager>.instance.IsPlaying)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("conversation is playing ！");
			}
			return;
		}
		if (Playing || DialogPlaying)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("conversation is playing ！");
			}
			return;
		}
		if (timelineGo == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("空的timeline");
			}
			return;
		}
		try
		{
			_ = 1;
			try
			{
				await PlayTimelineInternal(timelineGo, timelineGo.transform.position, token);
			}
			catch (Exception message)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError(message);
				}
			}
			Singleton<ConversationManager>.instance.SendKeyPoints();
		}
		finally
		{
			Reset();
		}
	}

	public async UniTask PlayTimeline(YooAssetReference assetReference, Vector3 position = default(Vector3), CancellationToken token = default(CancellationToken))
	{
		if (await WaitForPlayerOperationEnd(token))
		{
			return;
		}
		if (Singleton<ConversationManager>.instance.IsPlaying)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("conversation is playing ！");
			}
			return;
		}
		if (Playing)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("conversation is playing ！");
			}
			return;
		}
		try
		{
			AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(assetReference, position, quaternion.identity, (AssetLoadHandle loadHandle) =>
			{
				if (loadHandle.IsValid)
				{
					GameObject gameObject = loadHandle.AsGameObject();
					if ((bool)gameObject)
					{
						gameObject.SetActive(value: false);
					}
				}
			});
			await handle;
			GameObject timelineGo = handle.AsGameObject();
			await PlayTimelineInternal(timelineGo, position, token);
			Singleton<ConversationManager>.instance.SendKeyPoints();
			AssetStationManager.BattleStation.ReleaseInstance(handle);
		}
		catch (Exception message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError(message);
			}
		}
		finally
		{
			Reset();
		}
	}

	private static async UniTask<bool> WaitForPlayerOperationEnd(CancellationToken token)
	{
		if (MonoECS.instance == null || Singleton<GameState>.instance.WorldState == WorldState.Leave)
		{
			return true;
		}
		if (Singleton<GameState>.instance.CanEnterPlayerOperation(MonoECS.PlayerTag.Timeline))
		{
			return false;
		}
		return await UniTask.WaitUntil(() => MonoECS.instance == null || Singleton<GameState>.instance.WorldState == WorldState.Leave || Singleton<GameState>.instance.CanEnterPlayerOperation(MonoECS.PlayerTag.Timeline), PlayerLoopTiming.Update, token).SuppressCancellationThrow() || MonoECS.instance == null || Singleton<GameState>.instance.WorldState == WorldState.Leave;
	}

	private async UniTask PlayTimelineInternal(GameObject timelineGo, Vector3 position, CancellationToken token)
	{
		if (token.IsCancellationRequested)
		{
			return;
		}
		timelineGo.transform.position = position;
		List<int> characterList = ListPool<int>.Get();
		if (await WaitForPlayerOperationEnd(token))
		{
			return;
		}
		PlayableDirector playableDirector = timelineGo.GetComponent<PlayableDirector>();
		TimelineAsset timelineAsset = playableDirector.playableAsset as TimelineAsset;
		MonoTimelineConfig component = timelineGo.GetComponent<MonoTimelineConfig>();
		TimelineConfig timelineConfig = component.timelineConfig;
		TimelinePlayState timelinePlayState = default;
		Prepare(timelineConfig.ShowMonster);
		timelinePlayState.lightModeSceneChanged = true;
		Entity mainEntity = MonoECS.instance.mainEntity;
		GameManager.behaveSystem.TimelineStop(mainEntity, force: false);
		if (timelineConfig?.canOperatRobot ?? false)
		{
			timelinePlayState.robotOperate = true;
			BeginCanOperateRobot();
		}
		switch (timelineConfig.timelineType)
		{
		case TimelineType.Normal:
			if (timelineConfig.hasLetterBoxing)
			{
				timelinePlayState.letterBox = true;
				await OpenLetterBoxing(timelineConfig.hasLetterBoxingDuration, token);
			}
			break;
		case TimelineType.DialogueStory:
		{
			bool flag = true;
			if (timelineAsset != null)
			{
				foreach (TrackAsset outputTrack in timelineAsset.GetOutputTracks())
				{
					if (outputTrack is FullScreenVideoTrack)
					{
						flag = false;
						break;
					}
				}
			}
			if (flag)
			{
				timelinePlayState.conversationView = true;
				MonoConversationView.InitModeArg initModeArg = new MonoConversationView.InitModeArg
				{
					mode = MonoConversationView.ConversationViewMode.DialogueStory
				};
				await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_CONVERSATION, initModeArg).AttachExternalCancellation(token);
				if (timelineConfig.hasLetterBoxing)
				{
					MonoConversationView obj = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CONVERSATION) as MonoConversationView;
					timelinePlayState.conversationViewLetterBox = true;
					obj.letterbox.SetState(new MonoConversationLetterBox.LetterboxState
					{
						display = true,
						duration = timelineConfig.hasLetterBoxingDuration
					});
				}
			}
			break;
		}
		}
		if (token.IsCancellationRequested)
		{
			OnTimelineStop();
			return;
		}
		await MonoECS.instance.WaitLoaderState().AttachExternalCancellation(token);
		if (token.IsCancellationRequested)
		{
			OnTimelineStop();
			return;
		}
		timelinePlayState.loadChunkAndNPC = true;
		await LoadChunkAndNPC(timelineConfig, token);
		if (token.IsCancellationRequested)
		{
			OnTimelineStop();
			return;
		}
		await BeginConversationCGs(timelineAsset, token);
		Dictionary<int, string> modelAddresses = CollectLeftModelAddresses(timelineAsset);
		await BeginLeftModels(modelAddresses, token);
		if (token.IsCancellationRequested)
		{
			OnTimelineStop();
			return;
		}
		timelinePlayState.registerFmodLipSync = true;
		RegisterFmodLipSync(timelineGo, characterList);
		timelinePlayState.playTimeline = true;
		timelineGo?.SetActive(value: true);
		BindingController(timelineGo);
		bool timelineStopped = false;
		playableDirector.stopped += OnPlayableDirectorStopped;
		try
		{
			playableDirector.Play();
			await UniTask.WaitUntil(() => (!playableDirector || !playableDirector.playableGraph.IsValid()) | timelineStopped, PlayerLoopTiming.Update, token).SuppressCancellationThrow();
		}
		finally
		{
			if ((bool)playableDirector)
			{
				playableDirector.stopped -= OnPlayableDirectorStopped;
			}
		}
		Singleton<CGAudioManager>.instance?.ClearTexts();
		if (token.IsCancellationRequested)
		{
			OnTimelineStop();
			return;
		}
		timelinePlayState.playTimeline = false;
		timelinePlayState.registerFmodLipSync = false;
		UnregisterFmodLipSync(characterList);
		timelinePlayState.loadChunkAndNPC = false;
		UnloadChunkAndNPC(timelineConfig);
		switch (timelineConfig.timelineType)
		{
		case TimelineType.Normal:
			timelinePlayState.letterBox = false;
			if (timelineConfig.hasLetterBoxing)
			{
				await CloseLetterBoxing().AttachExternalCancellation(token);
			}
			break;
		case TimelineType.DialogueStory:
			if (timelinePlayState.conversationView)
			{
				timelinePlayState.conversationViewLetterBox = false;
				if (timelineConfig.hasLetterBoxing)
				{
					(Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CONVERSATION) as MonoConversationView).letterbox.SetState(new MonoConversationLetterBox.LetterboxState
					{
						display = false,
						duration = timelineConfig.hasLetterBoxingDuration
					});
					await UniTask.Delay(TimeSpan.FromSeconds(timelineConfig.hasLetterBoxingDuration), ignoreTimeScale: false, PlayerLoopTiming.Update, token).SuppressCancellationThrow();
				}
				timelinePlayState.conversationView = false;
				await Singleton<NewUIManager>.instance.CloseUIAsync(UI_TYPE.UI_CONVERSATION);
			}
			break;
		}
		if (token.IsCancellationRequested)
		{
			OnTimelineStop();
			return;
		}
		timelinePlayState.conversationView = false;
		await Singleton<NewUIManager>.instance.CloseUIAsync(UI_TYPE.UI_CONVERSATION);
		if (token.IsCancellationRequested)
		{
			OnTimelineStop();
			return;
		}
		if (timelineConfig.canOperatRobot)
		{
			timelinePlayState.robotOperate = false;
			EndCanOperateRobot();
		}
		OnTimelineStop();
		void OnPlayableDirectorStopped(PlayableDirector _)
		{
			timelineStopped = true;
		}
		void OnTimelineStop()
		{
			EndLeftModels();
			EndConversationCGs(timelineAsset);
			Singleton<BGMManager>.instance.ClearBGM(BGMType.AVG);
			Singleton<CGAudioManager>.instance?.ClearTexts();
			if (timelinePlayState.registerFmodLipSync)
			{
				timelinePlayState.registerFmodLipSync = false;
				UnregisterFmodLipSync(characterList);
			}
			if (timelinePlayState.playTimeline && (bool)playableDirector)
			{
				playableDirector.Stop();
			}
			if (timelinePlayState.loadChunkAndNPC)
			{
				timelinePlayState.loadChunkAndNPC = false;
				UnloadChunkAndNPC(timelineConfig);
			}
			if (timelinePlayState.letterBox)
			{
				timelinePlayState.letterBox = false;
				CloseLetterBoxing().Forget();
			}
			timelinePlayState.conversationView = false;
			if (Singleton<NewUIManager>.HasInstance())
			{
				Singleton<NewUIManager>.instance.CloseUIAsync(UI_TYPE.UI_CONVERSATION).Forget();
			}
			if (timelinePlayState.robotOperate)
			{
				timelinePlayState.robotOperate = false;
				EndCanOperateRobot();
			}
			if (timelineConfig.openUIOnEnd != UI_TYPE.UI_NONE && Singleton<NewUIManager>.instance.GetFirstUIExpectedState(UI_TYPE.UI_CONVERSATION) != UIExpectedState.Open)
			{
				if (timelineConfig.openUIOnEnd == UI_TYPE.UI_BATTLEMAIN)
				{
					if (!Singleton<NewUIManager>.instance.TryGetFirstUIController(UI_TYPE.UI_BATTLEMAIN, out var ui) || ui.State != UIState.Opened)
					{
						Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEMAIN);
					}
				}
				else
				{
					Singleton<NewUIManager>.instance.CloseAllUI();
					Singleton<NewUIManager>.instance.OpenUI(timelineConfig.openUIOnEnd);
				}
			}
		}
	}

	private void BindingController(GameObject timelineInstance)
	{
		timelineInstance.SetActive(value: true);
		MonoTimelineConfig component = timelineInstance.GetComponent<MonoTimelineConfig>();
		PlayableDirector component2 = timelineInstance.GetComponent<PlayableDirector>();
		TimelineConfig timelineConfig = component.timelineConfig;
		if (timelineConfig.useNewAssetsBindings)
		{
			TimelineTrackBinding.SetTrackBinding(component2, timelineConfig.newAssetsBindings);
		}
		else
		{
			OldTimelineTrackBinding.SetTrackBinding(component2, timelineConfig.assetsBindings);
		}
	}

	private void RegisterFmodLipSync(GameObject timelineInstance, List<int> result)
	{
		result.Clear();
		ConversationController component = timelineInstance.GetComponent<ConversationController>();
		if (!component)
		{
			return;
		}
		foreach (CharacterInfo characterInfo in component.CharacterInfos)
		{
			if ((bool)characterInfo.character)
			{
				NewFMODLipSyncBakeDataPlayer component2 = characterInfo.character.GetComponent<NewFMODLipSyncBakeDataPlayer>();
				if ((bool)component2)
				{
					Singleton<ULipSyncManager>.instance.RegisterCharacter(characterInfo.id, component2);
					result.Add(characterInfo.id);
				}
			}
		}
	}

	private void UnregisterFmodLipSync(List<int> characterList)
	{
		foreach (int character in characterList)
		{
			Singleton<ULipSyncManager>.instance.UnregisterCharacter(character);
		}
		ListPool<int>.Release(characterList);
	}

	private async UniTask LoadChunkAndNPC(TimelineConfig timelineConfig, CancellationToken token)
	{
		if (timelineConfig.bindingChunkList == null || timelineConfig.bindingChunkList.Count <= 0)
		{
			return;
		}
		List<UniTask> chunkTasks = ListPool<UniTask>.Get();
		for (int i = 0; i < timelineConfig.bindingChunkList.Count; i++)
		{
			TimelineBindingChunk timelineBindingChunk = timelineConfig.bindingChunkList[i];
			if (timelineBindingChunk.loadNPC)
			{
				Singleton<RuntimeNpcManager>.instance.AddSupportShowChunkId(Singleton<GameManager>.instance.worldManager.ActiveWorldId, timelineBindingChunk.chunkId);
			}
			chunkTasks.Add(Singleton<GameManager>.instance.worldManager.ChunkModule.LoadTempChunk(timelineBindingChunk.chunkId, timelineBindingChunk.chunkState, timelineBindingChunk.loadInteractStateObject, timelineBindingChunk.loadMonster));
		}
		await UniTask.WhenAll(chunkTasks).AttachExternalCancellation(token).SuppressCancellationThrow();
		ListPool<UniTask>.Release(chunkTasks);
	}

	private void UnloadChunkAndNPC(TimelineConfig timelineConfig)
	{
		if (timelineConfig.bindingChunkList == null || timelineConfig.bindingChunkList.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < timelineConfig.bindingChunkList.Count; i++)
		{
			TimelineBindingChunk timelineBindingChunk = timelineConfig.bindingChunkList[i];
			if (timelineBindingChunk.loadNPC)
			{
				Singleton<RuntimeNpcManager>.instance.RemoveSupportShowChunkId(Singleton<GameManager>.instance.worldManager.ActiveWorldId, timelineBindingChunk.chunkId);
			}
			Singleton<GameManager>.instance.worldManager.ChunkModule.UnloadTempChunk(timelineBindingChunk.chunkId);
		}
	}

	private async UniTask OpenLetterBoxing(float duration, CancellationToken token)
	{
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_LETTERBOXINGPANEL, true).AttachExternalCancellation(token);
		MonoLetterBoxingView monoLetterBoxingView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_LETTERBOXINGPANEL) as MonoLetterBoxingView;
		if (monoLetterBoxingView != null)
		{
			monoLetterBoxingView.duration = duration;
			monoLetterBoxingView.EnterLetterBoxing("LetterBoxing_Fade");
		}
		await UniTask.Delay(TimeSpan.FromSeconds(duration), ignoreTimeScale: false, PlayerLoopTiming.Update, token).SuppressCancellationThrow();
	}

	private async UniTask CloseLetterBoxing()
	{
		MonoLetterBoxingView uiView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_LETTERBOXINGPANEL) as MonoLetterBoxingView;
		if (uiView != null)
		{
			await uiView.ExitLetterBoxing("LetterBoxing");
			await uiView.CloseAsync();
		}
	}

	private void BeginCanOperateRobot()
	{
		MonoECS.instance.RobotActive(value: true, effect: false);
		MPPlayer localPlayer = MonoECS.instance.localPlayer;
		if (localPlayer != null)
		{
			Entity robotEntity = localPlayer.robotEntity;
			ActBehaviorTree bTree = robotEntity.GetBTree();
			Transform modelTrans = robotEntity.GetModelTrans();
			if (modelTrans != null)
			{
				modelTrans.localPosition = Vector3.zero;
			}
			if (bTree != null)
			{
				bTree.enabled = false;
				bTree.GetVariable("停止移动").SetValue(true);
			}
		}
	}

	private void EndCanOperateRobot()
	{
		MonoECS monoECS = MonoECS.instance;
		MPPlayer localPlayer = monoECS.localPlayer;
		if (localPlayer != null)
		{
			Entity robotEntity = localPlayer.robotEntity;
			ActBehaviorTree bTree = robotEntity.GetBTree();
			Transform rootTransform = robotEntity.GetRootTransform();
			Transform modelTrans = robotEntity.GetModelTrans();
			if (bTree != null)
			{
				bTree.enabled = true;
				bTree.EnableBehavior();
				bTree.GetVariable("停止移动").SetValue(false);
			}
			if (rootTransform != null)
			{
				rootTransform.GetChild(0).gameObject.SetActive(value: true);
			}
			if (modelTrans != null)
			{
				modelTrans.localPosition = Vector3.zero;
			}
		}
		monoECS?.RobotActive(value: false, effect: false);
	}

	public async UniTask TimelineConversationDialog(TimelineConversationData data, double startTime, Action<int> onSelect, CancellationToken token = default(CancellationToken))
	{
		m_PlayingDialogue.dialoguePlayTime = startTime;
		m_PlayingDialogue.canSkip = data.canSkip;
		if (m_PlayingDialogue.canSkip && m_PlayingDialogue.inSkip)
		{
			return;
		}
		DialogPlaying = true;
		m_PlayingDialogue.inSkip = false;
		((MonoECS.instance?.mainEntity)?.GetCompCharacter())?.characterSource?.Id();
		MonoConversationView.ConversationStatics conversationParam = new MonoConversationView.ConversationStatics
		{
			options = new List<int>()
		};
		conversationParam.localContentId = data.content;
		conversationParam.localSpeakerId = data.speaker;
		conversationParam.emojiId = data.emoji;
		conversationParam.ContentTypeSpeed = data.contentTypeSpeed;
		conversationParam.AutoNextDelay = data.autoNextDelay;
		conversationParam.leftModelMode = GetLeftModelMode(data);
		conversationParam.hideLeftModelOnEnd = data.hideLeftModelOnEnd;
		if (data.hasBranch)
		{
			foreach (TimelineConversationBranch branch in data.branchs)
			{
				conversationParam.options.Add(branch.content);
			}
			if (!data.branchHasContent)
			{
				conversationParam.localSpeakerId = -1;
				conversationParam.localContentId = -1;
			}
		}
		if (m_SubTitle == null)
		{
			m_SubTitle = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CONVERSATION) as MonoConversationView;
		}
		if (m_SubTitle == null)
		{
			await ShowConversation(conversationParam, token);
		}
		else
		{
			if (m_SubTitle.UIController.State == UIState.Closing)
			{
				await UniTask.WaitUntil(() => Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_CONVERSATION) == UIState.Closed, PlayerLoopTiming.Update, token);
			}
			if (token.IsCancellationRequested)
			{
				return;
			}
			if (m_SubTitle == null || m_SubTitle.UIController.State == UIState.Closed)
			{
				await ShowConversation(conversationParam, token);
			}
			if (token.IsCancellationRequested)
			{
				return;
			}
			m_SubTitle.SetUIViewData(conversationParam);
		}
		if (data.hasBranch)
		{
			if (!data.branchHasContent)
			{
				await m_SubTitle.ShowView(MonoConversationView.UIType.CHOICE_HIDE, token);
			}
			else
			{
				await m_SubTitle.ShowView(MonoConversationView.UIType.CHOICE_SHOW, token);
			}
			if (token.IsCancellationRequested)
			{
				return;
			}
			if (!m_SubTitle)
			{
				m_SubTitle = null;
				DialogPlaying = false;
				return;
			}
			onSelect?.Invoke(m_SubTitle.result);
		}
		else
		{
			if (!data.needClick)
			{
				await m_SubTitle.ShowView(MonoConversationView.UIType.DELAY, token);
			}
			else
			{
				await m_SubTitle.ShowView(MonoConversationView.UIType.WAITCLICK, token);
			}
			if (token.IsCancellationRequested)
			{
				return;
			}
			if (!m_SubTitle)
			{
				m_SubTitle = null;
				DialogPlaying = false;
				return;
			}
		}
		m_PlayingDialogue.canSkip = true;
		if (data.isEnd)
		{
			_ = LuminApplication.LogEnabled;
			await m_SubTitle.normalView.HideAndClearContent();
			m_SubTitle = null;
			DialogPlaying = false;
			_ = LuminApplication.LogEnabled;
		}
	}

	private async UniTask ShowConversation(MonoConversationView.ConversationStatics param, CancellationToken token)
	{
		_ = LuminApplication.LogEnabled;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CONVERSATION, param);
		if (!m_SubTitle || m_SubTitle.UIController.State == UIState.Closed)
		{
			await UniTask.WaitUntil(() =>
			{
				if (!(Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_CONVERSATION) is MonoConversationView monoConversationView) || monoConversationView.UIController.State != UIState.Opened)
				{
					return false;
				}
				monoConversationView.SetUIViewData(param);
				m_SubTitle = monoConversationView;
				return true;
			}, PlayerLoopTiming.Update, token);
		}
		else
		{
			m_SubTitle.SetUIViewData(param);
		}
		_ = LuminApplication.LogEnabled;
	}

	public bool SkipConversation()
	{
		Singleton<ConversationManager>.instance.PlayingDialogue?.Skip();
		return false;
	}

	private void Prepare(bool showMonster)
	{
		AsideManager.instance.PushPlaybackBlock(this);
		Playing = true;
		m_PreviousRenderScene = GameRenderScene.Current;
		GameRenderScene.Set(GameRenderScene.Scene.TimelineConversation);
		MonoECS monoECS = MonoECS.instance;
		Entity? entity = monoECS?.mainEntity;
		EntityTags entityTags = (entity?.GetCompBehave())?.EntityTags;
		entityTags?.AddTag(EntityTag.IgnoreAttack);
		entityTags?.AddTag(EntityTag.IgnoreTrap);
		entityTags?.AddTag(EntityTag.UnHatable);
		entityTags?.AddTag(EntityTag.SystemControl);
		if (!showMonster)
		{
			GameManager.monsterSystem?.ClearAllMonsterHatredAndHide();
		}
		Singleton<NewUIManager>.instance?.CloseAllUI();
		if (monoECS != null && !m_PauseInputPushed)
		{
			monoECS.PushPauseInput();
			m_PauseInputPushed = true;
		}
		monoECS?.ClearMainEntityInput();
		monoECS?.SetPlayerTag(MonoECS.PlayerTag.Timeline);
		entity?.SetBool("InTimeline", value: true);
		GameUtility.SetCameraLayerDialog(isTimeline: true);
	}

	private void Reset()
	{
		try
		{
			if (Playing)
			{
				GameRenderScene.Set(m_PreviousRenderScene);
			}
			EndLeftModels();
			Singleton<DramaVoiceManager>.instance.Release();
			Singleton<CGAudioManager>.instance?.ClearTexts();
			MonoECS monoECS = MonoECS.instance;
			Entity? entity = monoECS?.mainEntity;
			EntityTags entityTags = (entity?.GetCompBehave())?.EntityTags;
			entityTags?.RemoveTag(EntityTag.IgnoreAttack);
			entityTags?.RemoveTag(EntityTag.IgnoreTrap);
			entityTags?.RemoveTag(EntityTag.UnHatable);
			entityTags?.RemoveTag(EntityTag.SystemControl);
			GameManager.monsterSystem?.ShowAllMonsterRenderer();
			Playing = false;
			DialogPlaying = false;
			m_SubTitle = null;
			conversationClipCancels.Clear();
			monoECS?.RemovePlayerTag(MonoECS.PlayerTag.Timeline);
			entity?.SetBool("InTimeline", value: false);
			GameUtility.SetCameraLayerDialog(isTimeline: false);
			RestorePlayerInput();
		}
		finally
		{
			AsideManager.instance.PopPlaybackBlock(this);
		}
	}

	public async UniTask BeginLeftModels(Dictionary<int, string> modelAddresses, CancellationToken token)
	{
		foreach (KeyValuePair<int, CancellationTokenSource> modelTask in m_ModelTasks)
		{
			modelTask.Value?.Cancel();
			modelTask.Value?.Dispose();
		}
		m_ModelTasks.Clear();
		m_CurrentLeftModelSpeakerId = 0;
		ReleaseModels();
		ReleaseLeftScene();
		SetLeftModelNativeRendering(enabled: false);
		try
		{
			SetLeftModelSpecialRendering(enabled: true);
			await LoadLeftScene(token);
			if (modelAddresses.Count <= 0)
			{
				return;
			}
			List<UniTask> preloadTasks = ListPool<UniTask>.Get();
			try
			{
				foreach (KeyValuePair<int, string> modelAddress in modelAddresses)
				{
					preloadTasks.Add(PreloadLeftModel(modelAddress.Key, modelAddress.Value, token));
				}
				await UniTask.WhenAll(preloadTasks);
			}
			finally
			{
				ListPool<UniTask>.Release(preloadTasks);
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"Timeline左侧对话模型预载失败\n{arg}");
			}
			EndLeftModels();
		}
	}

	public void EndLeftModels()
	{
		foreach (KeyValuePair<int, CancellationTokenSource> modelTask in m_ModelTasks)
		{
			modelTask.Value?.Cancel();
			modelTask.Value?.Dispose();
		}
		m_ModelTasks.Clear();
		m_CurrentLeftModelSpeakerId = 0;
		ReleaseModels();
		SetLeftModelSpecialRendering(enabled: false);
		ReleaseLeftScene();
	}

	private async UniTask PreloadLeftModel(int speakerId, string address, CancellationToken token)
	{
		if (token.IsCancellationRequested)
		{
			return;
		}
		if (!GameUtility.mainCamera)
		{
			LogLeftModelLoadError(speakerId, address, "Main Camera不存在");
			return;
		}
		GameObject modelInstance = null;
		try
		{
			Transform parent = (m_LeftModelScene ? m_LeftModelScene.modelRoot.transform : GameUtility.mainCamera.transform);
			AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(address, parent, instantiateInWorldSpace: false, (AssetLoadHandle loadHandle) =>
			{
				if (loadHandle.IsValid)
				{
					GameObject gameObject = loadHandle.AsGameObject();
					if ((bool)gameObject)
					{
						gameObject.SetActive(value: false);
					}
				}
			});
			await handle;
			modelInstance = handle.AsGameObject();
			if (!modelInstance)
			{
				LogLeftModelLoadError(speakerId, address, "实例为空");
				return;
			}
			if (token.IsCancellationRequested)
			{
				AssetStationManager.BattleStation.ReleaseInstance(modelInstance);
				return;
			}
			if (!GameUtility.mainCamera)
			{
				LogLeftModelLoadError(speakerId, address, "Main Camera不存在");
				AssetStationManager.BattleStation.ReleaseInstance(modelInstance);
				return;
			}
			Transform transform = modelInstance.transform;
			transform.SetParent(parent, worldPositionStays: false);
			transform.localPosition = Vector3.up * GetLeftModelHeightOffset(speakerId);
			transform.localEulerAngles = Vector3.zero;
			transform.localScale = Vector3.one;
			if (m_LeftModelCache.ContainsKey(speakerId))
			{
				AssetStationManager.BattleStation.ReleaseInstance(modelInstance);
				return;
			}
			SetLeftModelLayer(modelInstance.transform);
			SetLeftModelCharacterLightDirection(modelInstance);
			CharacterHDShadow characterHDShadow = modelInstance.GetComponent<CharacterHDShadow>() ?? modelInstance.AddComponent<CharacterHDShadow>();
			characterHDShadow.SetObjectType(CharacterHDShadowObjectType.UnBattle);
			characterHDShadow.SetMainLightRotation(LeftModelCharacterMainLightRotation);
			PrepareLeftModelForFade(modelInstance);
			modelInstance.SetActive(value: false);
			m_LeftModelCache.Add(speakerId, modelInstance);
			RegisterLeftModelLipSync(speakerId, address, modelInstance);
		}
		catch (Exception ex)
		{
			if ((bool)modelInstance)
			{
				AssetStationManager.BattleStation.ReleaseInstance(modelInstance);
			}
			LogLeftModelLoadError(speakerId, address, ex.ToString());
		}
	}

	private void SetLeftModelCharacterLightDirection(GameObject modelInstance)
	{
		Vector3 vector = -(LeftModelCharacterMainLightRotation * Vector3.forward);
		Vector4 value = new Vector4(vector.x, vector.y, vector.z, 1f);
		Renderer[] componentsInChildren = modelInstance.GetComponentsInChildren<Renderer>(includeInactive: true);
		foreach (Renderer renderer in componentsInChildren)
		{
			if (!(renderer is SkinnedMeshRenderer) && !(renderer is MeshRenderer))
			{
				continue;
			}
			m_LeftModelCharacterLightPropertyBlock.Clear();
			renderer.GetPropertyBlock(m_LeftModelCharacterLightPropertyBlock);
			m_LeftModelCharacterLightPropertyBlock.SetVector(LeftModelCharacterMainLightDirectionOverrideShaderId, value);
			renderer.SetPropertyBlock(m_LeftModelCharacterLightPropertyBlock);
			m_LeftModelSharedMaterials.Clear();
			renderer.GetSharedMaterials(m_LeftModelSharedMaterials);
			for (int j = 0; j < m_LeftModelSharedMaterials.Count; j++)
			{
				m_LeftModelCharacterLightPropertyBlock.Clear();
				renderer.GetPropertyBlock(m_LeftModelCharacterLightPropertyBlock, j);
				if (!m_LeftModelCharacterLightPropertyBlock.isEmpty)
				{
					m_LeftModelCharacterLightPropertyBlock.SetVector(LeftModelCharacterMainLightDirectionOverrideShaderId, value);
					renderer.SetPropertyBlock(m_LeftModelCharacterLightPropertyBlock, j);
				}
			}
		}
	}

	private static void SetLeftModelSpecialRendering(bool enabled)
	{
		int num = 33554432;
		UniversalRenderer universalRenderer = (UniversalRenderer)((UniversalRenderPipelineAsset)QualitySettings.renderPipeline).scriptableRenderer;
		int num2 = universalRenderer.specialCharacterLayerMask;
		if (enabled)
		{
			GameUtility.mainCamera.cullingMask |= num;
			universalRenderer.SetSpecialCharacterLayerMask(num2 | num);
		}
		else
		{
			GameUtility.mainCamera.cullingMask &= ~num;
			universalRenderer.SetSpecialCharacterLayerMask(num2 & ~num);
		}
		if (!enabled)
		{
			SetLeftModelNativeRendering(enabled: false);
		}
	}

	private static void SetLeftModelNativeRendering(bool enabled)
	{
		if (m_LeftModelNativeRenderPassOverrideEnabled != enabled)
		{
			m_LeftModelNativeRenderPassOverrideEnabled = enabled;
			GameRenderScene.SetLeftModelSpecialRenderingEnabled(enabled);
		}
	}

	private static void SetLeftModelLayer(Transform root)
	{
		Renderer[] componentsInChildren = root.GetComponentsInChildren<Renderer>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].gameObject.layer = 25;
		}
	}

	private static float GetLeftModelHeightOffset(int speakerId)
	{
		if (RuntimeConfigs.data != null && RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(speakerId, out var value))
		{
			return value.height;
		}
		return 0f;
	}

	private static void RegisterLeftModelLipSync(int speakerId, string address, GameObject modelInstance)
	{
		NewFMODLipSyncBakeDataPlayer component = modelInstance.GetComponent<NewFMODLipSyncBakeDataPlayer>();
		if (!component)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"Timeline左侧对话模型未配置口型组件，Speaker: {speakerId}，Address: {address}");
			}
		}
		else
		{
			Singleton<ULipSyncManager>.instance.RegisterCharacter(speakerId, component);
		}
	}

	private static void UnregisterLeftModelLipSync(int speakerId, GameObject modelInstance)
	{
		NewFMODLipSyncBakeDataPlayer component = modelInstance.GetComponent<NewFMODLipSyncBakeDataPlayer>();
		if ((bool)component)
		{
			Singleton<ULipSyncManager>.instance.UnregisterCharacter(speakerId, component);
		}
	}

	private static Dictionary<int, string> CollectLeftModelAddresses(TimelineAsset timelineAsset)
	{
		Dictionary<int, string> dictionary = new Dictionary<int, string>();
		foreach (TrackAsset outputTrack in timelineAsset.GetOutputTracks())
		{
			if (!(outputTrack is ConversationTrack { mutedInHierarchy: false } conversationTrack))
			{
				continue;
			}
			foreach (TimelineClip clip in conversationTrack.GetClips())
			{
				if (!(clip.asset is ConversationClip { ConversationBehaviour: var conversationBehaviour }))
				{
					continue;
				}
				List<TimelineConversationData> list = conversationBehaviour?.datas;
				if (list == null)
				{
					continue;
				}
				foreach (TimelineConversationData item in list)
				{
					if (TryGetLeftModelAddress(item, out var address) && !dictionary.ContainsKey(item.speaker))
					{
						dictionary.Add(item.speaker, address);
					}
				}
			}
		}
		return dictionary;
	}

	private static bool TryGetLeftModelAddress(TimelineConversationData data, out string address)
	{
		address = null;
		if (data == null || data.hideLeftModel || data.speaker <= 0 || data.content <= 0)
		{
			return false;
		}
		if (data.speaker == 10001 || data.speaker == 10002)
		{
			return false;
		}
		if (data.hasBranch && !data.branchHasContent)
		{
			return false;
		}
		if (RuntimeConfigs.data == null || !RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(data.speaker, out var value) || string.IsNullOrEmpty(value.model))
		{
			return false;
		}
		address = value.model;
		return true;
	}

	private MonoConversationView.TimelineLeftModelMode GetLeftModelMode(TimelineConversationData data)
	{
		if (!TryGetLeftModelAddress(data, out var _))
		{
			return MonoConversationView.TimelineLeftModelMode.TimelineHide;
		}
		return MonoConversationView.TimelineLeftModelMode.TimelineShow;
	}

	private void PrepareLeftModelForFade(GameObject modelInstance)
	{
		Animator component = modelInstance.GetComponent<Animator>();
		if ((bool)component)
		{
			int layerIndex = component.GetLayerIndex("Admission");
			if (layerIndex >= 0)
			{
				component.SetLayerWeight(layerIndex, 0f);
			}
		}
		DissolveControl[] componentsInChildren = modelInstance.GetComponentsInChildren<DissolveControl>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].enabled = false;
		}
	}

	public async UniTask ChangeLeftModel(int speakerId)
	{
		if (m_CurrentLeftModelSpeakerId != speakerId)
		{
			await HideLeftModel(speakerId == 0 || !m_LeftModelCache.ContainsKey(speakerId));
			ShowLeftModel(speakerId).Forget();
		}
	}

	public async UniTask HideLeftModel(bool hideMask = false)
	{
		int currentLeftModelSpeakerId = m_CurrentLeftModelSpeakerId;
		if (m_CurrentLeftModelSpeakerId == 0)
		{
			return;
		}
		m_CurrentLeftModelSpeakerId = 0;
		if (m_LeftModelCache.TryGetValue(currentLeftModelSpeakerId, out var currentLeftModel))
		{
			if (m_ModelTasks.TryGetValue(currentLeftModelSpeakerId, out var value))
			{
				value.Cancel();
				value.Dispose();
				m_ModelTasks.Remove(currentLeftModelSpeakerId);
			}
			CancellationTokenSource cancellationTokenSource = new CancellationTokenSource();
			CancellationToken token = cancellationTokenSource.Token;
			m_ModelTasks[currentLeftModelSpeakerId] = cancellationTokenSource;
			Animator animator = currentLeftModel?.GetComponent<Animator>();
			animator?.SetBool(Show, value: false);
			if (hideMask)
			{
				m_LeftModelScene?.FadeHideRoleBg();
			}
			await UniTask.WaitForSeconds(0.3f, ignoreTimeScale: false, PlayerLoopTiming.Update, token);
			currentLeftModel?.SetActive(value: false);
			animator?.SetBool(Show, value: true);
		}
	}

	private async UniTask ShowLeftModel(int speakerId)
	{
		if (m_LeftModelCache.TryGetValue(speakerId, out var value))
		{
			m_CurrentLeftModelSpeakerId = speakerId;
			if (m_ModelTasks.TryGetValue(speakerId, out var value2))
			{
				value2.Cancel();
				value2.Dispose();
				m_ModelTasks.Remove(speakerId);
			}
			CancellationToken token = new CancellationTokenSource().Token;
			SetLeftModelNativeRendering(enabled: true);
			value.SetActive(value: true);
			value.GetComponent<Animator>()?.SetBool(Show, value: true);
			m_LeftModelScene?.gameObject.SetActive(value: true);
			m_LeftModelScene?.FadeShowRoleBg();
			await UniTask.WaitForSeconds(0.3f, ignoreTimeScale: false, PlayerLoopTiming.Update, token);
		}
	}

	private async UniTask LoadLeftScene(CancellationToken token)
	{
		AssetLoadHandle leftModelSceneHandle = AssetStationManager.BattleStation.InstantiateAsync("UI/LeftModelScene", GameUtility.mainCamera.transform, instantiateInWorldSpace: false, (AssetLoadHandle loadHandle) =>
		{
			if (loadHandle.IsValid)
			{
				GameObject gameObject2 = loadHandle.AsGameObject();
				if ((bool)gameObject2)
				{
					gameObject2.SetActive(value: false);
				}
			}
		});
		await leftModelSceneHandle;
		GameObject gameObject = leftModelSceneHandle.AsGameObject();
		if ((bool)gameObject)
		{
			m_LeftModelScene = gameObject.GetComponent<LeftModelScene>();
		}
		if (token.IsCancellationRequested)
		{
			AssetStationManager.BattleStation.ReleaseInstance(m_LeftModelScene.gameObject);
		}
	}

	private void ReleaseLeftScene()
	{
		if ((bool)m_LeftModelScene)
		{
			AssetStationManager.BattleStation.ReleaseInstance(m_LeftModelScene.gameObject);
		}
		m_LeftModelScene = null;
	}

	private void ReleaseModels()
	{
		try
		{
			foreach (KeyValuePair<int, GameObject> item in m_LeftModelCache)
			{
				GameObject value = item.Value;
				if ((bool)value)
				{
					value.SetActive(value: false);
					UnregisterLeftModelLipSync(item.Key, value);
					AssetStationManager.BattleStation.ReleaseInstance(value);
				}
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		finally
		{
			m_LeftModelCache.Clear();
		}
	}

	private static void LogLeftModelLoadError(int speakerId, string address, string reason)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"Timeline左侧对话模型加载失败，Speaker: {speakerId}，Address: {address}，原因: {reason}");
		}
	}

	[Obsolete]
	private void InitObsolete()
	{
		conversationClipCancels = new List<CancellationTokenSource>();
	}

	[Obsolete]
	private void UnInitObsolete()
	{
		conversationClipCancels = new List<CancellationTokenSource>();
	}

	[Obsolete]
	public void ConversationClipCancelRegister(CancellationTokenSource source)
	{
		conversationClipCancels.Add(source);
	}

	[Obsolete]
	public void SetActiveContent(bool active)
	{
	}

	public void StopConversation()
	{
		Singleton<ConversationManager>.instance.PlayingDialogue?.Stop();
	}
}
