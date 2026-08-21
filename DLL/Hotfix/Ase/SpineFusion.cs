using System;
using System.Collections.Generic;
using System.Linq;
using FMOD.Studio;
using Sirenix.OdinInspector;
using Spine;
using Spine.Unity;
using UnityEngine;

namespace Ase;

[RequireComponent(typeof(SkeletonGraphic))]
public class SpineFusion : SerializedMonoBehaviour, ISpineFusion
{
	private class AudioPlayerEntry
	{
		public SpineGraphicController controller;

		public SpineAudioPlayerCore player;
	}

	[SerializeField]
	[HideInInspector]
	private bool openMix;

	[SerializeField]
	[HideInInspector]
	private float touchInterval;

	[SerializeField]
	[HideInInspector]
	private FusionData _idleFusionData;

	[SerializeField]
	[HideInInspector]
	private List<FusionData> _fusionDatas;

	private List<SpineGraphicController> graphicControllers = new List<SpineGraphicController>();

	public bool developMode;

	private bool touchEnableByTimer = true;

	private bool touchEnable = true;

	private BoardPartController boardPartController;

	private readonly List<IBoardPartContextSource> boardPartSources = new List<IBoardPartContextSource>();

	private readonly SpineEventHandler eventHandler = new SpineEventHandler();

	private SkeletonGraphic skeletonGraphic;

	private List<AudioPlayerEntry> audioPlayers = new List<AudioPlayerEntry>();

	private readonly System.Random developRandom = new System.Random();

	private Func<BoardPartState, bool, ISpinePlayCommand, bool> _handleBoardPartResolved;

	public bool TouchEnable
	{
		get
		{
			if (touchEnableByTimer)
			{
				return touchEnable;
			}
			return false;
		}
	}

	public SkeletonGraphic SkeletonGraphic => GetSkeleton();

	private void Start()
	{
		RefreshGraphicControllers();
		InitializeBoardPartController();
	}

	private void OnDestroy()
	{
		UnsubscribeAllControllerEventHandlers();
		UnsubscribeBoardPartSources();
		eventHandler.Clear();
	}

	public SkeletonGraphic GetSkeleton()
	{
		if ((UnityEngine.Object)(object)skeletonGraphic == null)
		{
			skeletonGraphic = ((Component)this).gameObject.GetOrAddComponent<SkeletonGraphic>();
		}
		return skeletonGraphic;
	}

	public void PlayAudio(BoardPartActionEntry entry)
	{
		if (entry != null)
		{
			GetOrCreateMasterAudioPlayer()?.PlayAudio(entry.Audios, entry.AudioParameters);
		}
	}

	public void StopAllAudio()
	{
		if (audioPlayers != null && audioPlayers.Count != 0)
		{
			for (int i = 0; i < audioPlayers.Count; i++)
			{
				audioPlayers[i]?.player?.StopAllAudio();
			}
		}
	}

	public void StopAll()
	{
		StopAnimation();
		StopAllAudio();
	}

	public void AddAudioPlayAction(Action<int, EventInstance> action)
	{
		GetOrCreateMasterAudioPlayer()?.AddAudioPlayAction(action);
	}

	public void Init(Func<BoardPartState, bool, ISpinePlayCommand, bool> handler)
	{
		_handleBoardPartResolved = handler;
	}

	private void InitializeBoardPartController()
	{
		if (!(((Component)this).transform.parent == null))
		{
			if (boardPartController == null)
			{
				boardPartController = new BoardPartController();
			}
			GameObject gameObject = ((Component)this).transform.parent?.parent?.gameObject;
			if (!(gameObject == null))
			{
				boardPartController.Init(gameObject);
				SubscribeBoardPartSources(gameObject);
			}
		}
	}

	private void SubscribeBoardPartSources(GameObject root)
	{
		UnsubscribeBoardPartSources();
		boardPartSources.Clear();
		if (root == null)
		{
			return;
		}
		MonoBehaviour[] componentsInChildren = root.GetComponentsInChildren<MonoBehaviour>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (componentsInChildren[i] is IBoardPartContextSource boardPartContextSource)
			{
				boardPartContextSource.OnPartClick += HandleBoardPartClick;
				boardPartContextSource.OnPartDrag += HandleBoardPartDrag;
				boardPartSources.Add(boardPartContextSource);
			}
		}
	}

	private void UnsubscribeBoardPartSources()
	{
		for (int i = 0; i < boardPartSources.Count; i++)
		{
			IBoardPartContextSource boardPartContextSource = boardPartSources[i];
			if (boardPartContextSource != null)
			{
				boardPartContextSource.OnPartClick -= HandleBoardPartClick;
				boardPartContextSource.OnPartDrag -= HandleBoardPartDrag;
			}
		}
	}

	private void HandleBoardPartClick(BoardPartClickContext ctx)
	{
		if (TouchEnable && boardPartController != null)
		{
			BoardPartState state = boardPartController.HandlePartClick(ctx);
			HandleBoardPartResolved(state, ctx.CheckFrequentlyUsed, ctx.PlayCommand);
		}
	}

	private void HandleBoardPartDrag(BoardPartDragContext ctx)
	{
		if (TouchEnable && boardPartController != null)
		{
			boardPartController.HandlePartDrag(ctx);
		}
	}

	private void HandleBoardPartResolved(BoardPartState state, bool checkFrequentlyUsed, ISpinePlayCommand spinePlayCommand)
	{
		if (boardPartController == null || state == null || state.LastResolvedEntry == null)
		{
			return;
		}
		if (!developMode)
		{
			Func<BoardPartState, bool, ISpinePlayCommand, bool> handleBoardPartResolved = _handleBoardPartResolved;
			if (handleBoardPartResolved != null && handleBoardPartResolved(state, checkFrequentlyUsed, spinePlayCommand))
			{
				PlayAudio(state.LastResolvedEntry);
			}
			return;
		}
		string text = ResolveDevelopBoardPartActionName(state);
		if (!string.IsNullOrEmpty(text) && PlayAction(text, spinePlayCommand))
		{
			PlayAudio(state.LastResolvedEntry);
			state.AppendResolvedActions(text);
			RecordAnimationPlayed(text);
		}
	}

	private string ResolveDevelopBoardPartActionName(BoardPartState state)
	{
		if (state == null || state.LastResolvedEntry == null)
		{
			return string.Empty;
		}
		return state.GetAndRemoveRandomFromActionPoolCache(developRandom);
	}

	public void RecordAnimationPlayed(string selectedActionName)
	{
		boardPartController.RecordAnimationPlayed(selectedActionName);
	}

	public bool PlayAction(string aniName, ISpinePlayCommand spinePlayCommand, Action onActionFinish = null)
	{
		RefreshGraphicControllers();
		List<SpineGraphicController> targets = new List<SpineGraphicController>();
		foreach (SpineGraphicController validGraphicController in GetValidGraphicControllers())
		{
			if (!(validGraphicController == null) && spinePlayCommand.HasAction(validGraphicController, aniName))
			{
				targets.Add(validGraphicController);
			}
		}
		if (targets.Count == 0)
		{
			return false;
		}
		int completedCount = 0;
		bool callbackInvoked = false;
		foreach (SpineGraphicController item in targets)
		{
			if (!spinePlayCommand.OnExecute(item, aniName, OnControllerFinished))
			{
				OnControllerFinished();
			}
		}
		return true;
		void OnControllerFinished()
		{
			completedCount++;
			if (completedCount >= targets.Count)
			{
				if (!callbackInvoked)
				{
					callbackInvoked = true;
					onActionFinish?.Invoke();
				}
				StartTouchTimer();
			}
		}
	}

	private void StartTouchTimer()
	{
		if (touchInterval > 0f)
		{
			((MonoBehaviour)this).CancelInvoke("CloseTouchTimer");
			touchEnableByTimer = false;
			((MonoBehaviour)this).Invoke("CloseTouchTimer", touchInterval);
		}
	}

	private void CloseTouchTimer()
	{
		touchEnableByTimer = true;
	}

	public void SetTouchEnable(bool enable)
	{
		touchEnable = enable;
	}

	public void StopAnimation()
	{
		RefreshGraphicControllers();
		foreach (SpineGraphicController validGraphicController in GetValidGraphicControllers())
		{
			validGraphicController.StopAnimation();
		}
	}

	public virtual void ResetToIdle()
	{
		RefreshGraphicControllers();
		foreach (SpineGraphicController validGraphicController in GetValidGraphicControllers())
		{
			validGraphicController.ResetToIdle();
		}
	}

	public void PlayIdle(bool playAudio = true)
	{
		RefreshGraphicControllers();
		foreach (SpineGraphicController validGraphicController in GetValidGraphicControllers())
		{
			validGraphicController.PlayIdle(playAudio);
		}
	}

	public void PlayAndResetIdle(FusionData spineData, Action onActionFinish = null)
	{
		if (spineData != null)
		{
			PlayAction(spineData.name, new SpinePlayCommand(), onActionFinish);
		}
	}

	protected void RefreshGraphicControllers()
	{
		if (graphicControllers != null && graphicControllers.Count > 0)
		{
			return;
		}
		List<SpineGraphicController> list = ((Component)this).transform.parent.GetComponentsInChildren<SpineGraphicController>(includeInactive: true).ToList();
		list.AddRange(graphicControllers);
		graphicControllers = list.Where((SpineGraphicController x) => x != null).Distinct().ToList();
		EnsureAudioPlayerEntries(graphicControllers);
		foreach (SpineGraphicController graphicController in graphicControllers)
		{
			SpineAudioPlayerCore orCreateAudioPlayer = GetOrCreateAudioPlayer(graphicController);
			graphicController.InitializeFromMaster(() => openMix, (orCreateAudioPlayer != null) ? new Action<FusionData>(orCreateAudioPlayer.PlayAudio) : null, (orCreateAudioPlayer != null) ? new Action(orCreateAudioPlayer.StopAllAudio) : null, delegate
			{
			});
		}
		SubscribeAllControllerEventHandlers();
		EventHandlerInit();
	}

	protected IEnumerable<SpineGraphicController> GetValidGraphicControllers()
	{
		if (graphicControllers == null)
		{
			yield break;
		}
		for (int i = 0; i < graphicControllers.Count; i++)
		{
			SpineGraphicController spineGraphicController = graphicControllers[i];
			if (!(spineGraphicController == null) && spineGraphicController.isActiveAndEnabled && spineGraphicController.gameObject.activeInHierarchy)
			{
				yield return spineGraphicController;
			}
		}
	}

	private void EnsureAudioPlayerEntries(List<SpineGraphicController> controllers)
	{
		if (audioPlayers == null)
		{
			audioPlayers = new List<AudioPlayerEntry>();
		}
		if (controllers == null)
		{
			return;
		}
		for (int num = audioPlayers.Count - 1; num >= 0; num--)
		{
			AudioPlayerEntry audioPlayerEntry = audioPlayers[num];
			if (audioPlayerEntry == null || audioPlayerEntry.controller == null || !controllers.Contains(audioPlayerEntry.controller))
			{
				audioPlayers.RemoveAt(num);
			}
		}
		for (int i = 0; i < controllers.Count; i++)
		{
			SpineGraphicController spineGraphicController = controllers[i];
			if (!(spineGraphicController == null) && FindAudioEntry(spineGraphicController) == null)
			{
				audioPlayers.Add(new AudioPlayerEntry
				{
					controller = spineGraphicController,
					player = new SpineAudioPlayerCore(() => developMode)
				});
			}
		}
	}

	private AudioPlayerEntry FindAudioEntry(SpineGraphicController controller)
	{
		if (audioPlayers == null)
		{
			return null;
		}
		for (int i = 0; i < audioPlayers.Count; i++)
		{
			AudioPlayerEntry audioPlayerEntry = audioPlayers[i];
			if (audioPlayerEntry != null && audioPlayerEntry.controller == controller)
			{
				return audioPlayerEntry;
			}
		}
		return null;
	}

	private SpineAudioPlayerCore GetOrCreateAudioPlayer(SpineGraphicController controller)
	{
		if (controller == null)
		{
			return null;
		}
		AudioPlayerEntry audioPlayerEntry = FindAudioEntry(controller);
		if (audioPlayerEntry == null)
		{
			bool flag = controller != null && controller.gameObject == ((Component)this).gameObject;
			audioPlayerEntry = new AudioPlayerEntry
			{
				controller = controller,
				player = (flag ? new SpineAudioPlayerCore(() => developMode) : null)
			};
			audioPlayers.Add(audioPlayerEntry);
		}
		return audioPlayerEntry.player;
	}

	private SpineAudioPlayerCore GetOrCreateMasterAudioPlayer()
	{
		if (graphicControllers == null || graphicControllers.Count == 0)
		{
			RefreshGraphicControllers();
		}
		if (graphicControllers == null || graphicControllers.Count == 0)
		{
			return null;
		}
		SpineGraphicController spineGraphicController = null;
		for (int i = 0; i < graphicControllers.Count; i++)
		{
			SpineGraphicController spineGraphicController2 = graphicControllers[i];
			if (spineGraphicController2 != null && spineGraphicController2.gameObject == ((Component)this).gameObject)
			{
				spineGraphicController = spineGraphicController2;
				break;
			}
		}
		if (spineGraphicController == null && graphicControllers.Count > 0)
		{
			spineGraphicController = graphicControllers[0];
		}
		return GetOrCreateAudioPlayer(spineGraphicController);
	}

	private void EventHandlerInit()
	{
		eventHandler.Register(new ChangeToSpineEventHandler(delegate(string aniName, int trackIndex)
		{
			foreach (SpineGraphicController validGraphicController in GetValidGraphicControllers())
			{
				validGraphicController.PlayAction(aniName, trackIndex);
			}
		}));
		eventHandler.Register(new EndSpineEventHandler(delegate(int trackIndex)
		{
			foreach (SpineGraphicController validGraphicController2 in GetValidGraphicControllers())
			{
				SkeletonGraphic obj = validGraphicController2.SkeletonGraphic;
				object obj2;
				if (obj == null)
				{
					obj2 = null;
				}
				else
				{
					AnimationState animationState = obj.AnimationState;
					if (animationState == null)
					{
						obj2 = null;
					}
					else
					{
						ExposedList<TrackEntry> tracks = animationState.Tracks;
						obj2 = ((tracks != null) ? tracks.Items[trackIndex] : null);
					}
				}
				TrackEntry trackEntry = (TrackEntry)obj2;
				if (trackEntry != null)
				{
					trackEntry.Loop = false;
					trackEntry.MixDuration = 0f;
					if (trackEntry.Animation != null)
					{
						trackEntry.TrackTime = trackEntry.Animation.Duration;
					}
					validGraphicController2.SkeletonGraphic.Update(0f);
				}
			}
		}));
	}

	private void SubscribeAllControllerEventHandlers()
	{
		if (graphicControllers == null)
		{
			return;
		}
		for (int i = 0; i < graphicControllers.Count; i++)
		{
			SpineGraphicController spineGraphicController = graphicControllers[i];
			if (!(spineGraphicController == null))
			{
				spineGraphicController.SetEventHandler(() => eventHandler);
			}
		}
	}

	private void UnsubscribeAllControllerEventHandlers()
	{
		if (graphicControllers != null)
		{
			for (int i = 0; i < graphicControllers.Count; i++)
			{
				graphicControllers[i]?.SetEventHandler(null);
			}
		}
	}

	public float GetActionDuration(string aniName)
	{
		float num = 0f;
		RefreshGraphicControllers();
		foreach (SpineGraphicController validGraphicController in GetValidGraphicControllers())
		{
			if (!(validGraphicController == null))
			{
				float aniLength = validGraphicController.GetAniLength(aniName);
				if (aniLength > num)
				{
					num = aniLength;
				}
			}
		}
		return num;
	}
}
