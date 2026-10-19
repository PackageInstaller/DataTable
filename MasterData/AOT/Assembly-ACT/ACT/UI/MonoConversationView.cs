using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.DialogueSystem;
using ACT.Drama;
using ACT.Game;
using ACT.Sound;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoConversationView : BaseUIView<ConversationViewInputController>
{
	public new enum UIType
	{
		DELAY,
		WAITCLICK,
		CHOICE_HIDE,
		CHOICE_SHOW
	}

	public enum TimelineLeftModelMode
	{
		NonTimeline,
		TimelineShow,
		TimelineHide
	}

	public struct InitModeArg
	{
		public ConversationViewMode mode;
	}

	public class ConversationViewInitArg
	{
		public ConversationViewMode? mode;

		public bool DeferredOpenAnimation;
	}

	public class ConversationStatics
	{
		public int localSpeakerId = -1;

		public int localContentId = -1;

		public TimelineLeftModelMode leftModelMode;

		public bool hideLeftModelOnEnd;

		public int ContentTypeSpeed = -1;

		public float AutoNextDelay = -1f;

		public int emojiId = -1;

		public int emotionPitch = 1;

		public Action onEventsOver;

		[Obsolete("弃用")]
		public List<int> options;

		public List<InteractEvent> interactEvents;

		public object context;
	}

	public class DialogueArg
	{
		public long ID { get; set; }

		public int StoryGroupId { get; set; }

		public int StorySummaryContentId { get; set; }

		public int SpeakerId { get; set; }

		public int SpeakerNameId { get; set; }

		public int SpeakerHeadId { get; set; }

		public TimelineLeftModelMode LeftModelMode { get; set; }

		public bool HideLeftModelOnEnd { get; set; }

		public int SpeakerType { get; set; }

		public int ContentId { get; set; } = -1;

		public bool IsSubtitle { get; set; }

		public List<int> KeyWords { get; set; }

		public int VoiceIndex { get; set; }

		public float ImageOffset { get; set; }

		public int ContentTypeSpeed { get; set; } = 50;

		public bool IsMainCharacter => SpeakerType == 1;

		public bool AutoNext { get; set; }

		public float AutoNextDelay { get; set; } = 0.5f;

		public List<OptionData> OptionDatas { get; set; }

		public bool HideUI { get; set; }

		public bool CanSkip { get; set; }
	}

	public struct OptionData
	{
		public int OptionIndex { get; set; }

		public long OptionId { get; set; }

		public int ContentId { get; set; }

		public int IconId { get; set; }
	}

	public enum ConversationViewMode
	{
		DialogueStory,
		NormalDialog
	}

	public enum SubtitleType
	{
		Normal,
		Movie
	}

	public ViewControlRoot viewControlRoot;

	public ViewControlLayer choiceControlLayer;

	[Header("特效")]
	public MonoConversationColorScreen colorScreen;

	[Header("控制")]
	public Button btnNext;

	public Animator autoPlayAnimator;

	public ActButtonEx skip;

	public ActButtonEx hide;

	public ActButtonEx autoPlayToggle;

	public Button hideTrigger;

	public ActButtonEx btnOpenStoryPanel;

	public List<Behaviour> contents = new List<Behaviour>();

	public GameObject mainPanel;

	public float minClickInterval;

	[NonSerialized]
	public int result;

	[Header("各个模块")]
	public MonoConversationNormal normalView;

	public MonoConversationCG cg;

	public MonoConversationStoryPanel storyPanel;

	public MonoConversationBubbles bubbles;

	public MonoConversationEmojiLayer emoji;

	public MonoConversationLetterBox letterbox;

	public MonoConversationLetterBox2 letterbox2;

	public MonoConversationBlackScreen blackScreen;

	public MonoConversationCenterText centerText;

	[Header("AVG Caption")]
	public Transform captionPrefabRoot;

	public BetterAnimation wake;

	public GameObject conversation;

	public GameObject topControl;

	public TextLibraryPropPickComponent textLibraryPropPick;

	public AudioEventReference soundTextLibraryShow;

	public List<GameObject> tips;

	[Header("场景模糊退出覆盖")]
	public GameObject sceneBlurSnapshotOverlay;

	private float m_Timer;

	private bool m_DeferredOpenAnimation;

	private bool m_DeferredOpenCallbackPending;

	private const string SceneBlurSnapshotOverlayFadeOutState = "CaptureFadeOut";

	private const string SceneBlurSnapshotOverlayFadeOutLayer = "FadeOutLayer";

	private AnimationBuilder wakeAnimationBuilder;

	private int curImageId;

	private static readonly int IsPlay = Animator.StringToHash("IsPlay");

	private void Awake()
	{
		btnOpenStoryPanel.Source.OnClick.AddListener(ShowStoryPanel);
		autoPlayToggle.Source.OnClick.AddListener(OnAutoPlayClick);
		hide.Source.OnClick.AddListener(OnBtnHideClick);
		hideTrigger.onClick.AddListener(OnBtnShowClick);
	}

	public override UniTask PreInit()
	{
		return UniTask.CompletedTask;
	}

	protected override void Init()
	{
		base.Init();
		blackScreen.Init();
		Singleton<ConversationManager>.instance.conversationView = this;
		ConversationSettings.OnAutoPlayChanged += OnAutoPlayChanged;
		normalView.Init();
		colorScreen?.Init();
		letterbox?.Init();
		centerText?.Init();
		btnOpenStoryPanel.interactable = false;
		btnOpenStoryPanel.gameObject.SetActive(!(Singleton<ConversationManager>.instance.PlayingDialogue is TimelineDialogue));
		OnAutoPlayChanged(ConversationSettings.AutoPlay);
		skip.gameObject.SetActive(value: true);
		skip.interactable = Singleton<TimelineConversationManager>.instance.CanSkip;
		MonoECS.instance.PushPauseInteract();
		InitSceneBlurSnapshotOverlay();
		m_DeferredOpenAnimation = uiViewData is ConversationViewInitArg conversationViewInitArg && conversationViewInitArg.DeferredOpenAnimation;
		m_DeferredOpenCallbackPending = false;
		if (uiViewData is InitModeArg initModeArg)
		{
			if (initModeArg.mode == ConversationViewMode.DialogueStory)
			{
				skip.interactable = true;
			}
		}
		else if (uiViewData is ConversationViewInitArg { mode: var mode } && mode.HasValue && mode.GetValueOrDefault() == ConversationViewMode.DialogueStory)
		{
			skip.interactable = true;
		}
	}

	protected override void UnInit()
	{
		if (m_DeferredOpenCallbackPending)
		{
			m_DeferredOpenCallbackPending = false;
			m_DeferredOpenAnimation = false;
			FinishOpenEffect();
		}
		base.UnInit();
		Singleton<ConversationManager>.instance.conversationView = null;
		ConversationSettings.OnAutoPlayChanged -= OnAutoPlayChanged;
		normalView.UnInit();
		colorScreen?.UnInit();
		letterbox?.UnInit();
		centerText?.UnInit();
		if (Singleton<TimelineConversationManager>.HasInstance())
		{
			TimelineConversationManager instance = Singleton<TimelineConversationManager>.instance;
			if (!instance.Playing)
			{
				instance.EndLeftModels();
			}
			else if (instance.ConversationView == this)
			{
				instance.HideLeftModel();
			}
		}
		blackScreen.UnInit();
	}

	protected override void OnPushStack()
	{
		base.OnPushStack();
		normalView.Pause();
	}

	protected override void OnPopStack()
	{
		base.OnPopStack();
		normalView.Resume();
	}

	protected override void PlayOpenAnimation()
	{
		if (m_DeferredOpenAnimation)
		{
			SetDeferredOpenHiddenState();
			m_DeferredOpenCallbackPending = true;
			OpenEffectFinishNew();
		}
		else
		{
			uiEffectAnimator.Play("Show");
		}
	}

	protected override void PlayCloseAnimation()
	{
		uiEffectAnimator.Play("Hide");
	}

	protected override void OpenEffectCallback()
	{
		if (!m_DeferredOpenAnimation)
		{
			FinishOpenEffect();
		}
	}

	private void FinishOpenEffect()
	{
		MonoECS.instance.PopPauseInteract();
	}

	private void SetDeferredOpenHiddenState()
	{
		if (!(uiEffectAnimator == null))
		{
			uiEffectAnimator.Play("Hide", 0, 1f);
			uiEffectAnimator.Update(0f);
		}
	}

	public async UniTask PlayDeferredOpenAnimationAsync(CancellationToken token)
	{
		if (m_DeferredOpenAnimation)
		{
			m_DeferredOpenAnimation = false;
			if (uiEffectAnimator != null)
			{
				uiEffectAnimator.Play("Show", 0, 0f);
				await UniTask.Yield(PlayerLoopTiming.Update, token);
				AnimatorStateInfo currentAnimatorStateInfo = uiEffectAnimator.GetCurrentAnimatorStateInfo(0);
				await UniTask.Delay(TimeSpan.FromSeconds(GetSafeAnimatorStateLength(currentAnimatorStateInfo, 0.3f)), ignoreTimeScale: false, PlayerLoopTiming.Update, token);
			}
			if (m_DeferredOpenCallbackPending)
			{
				m_DeferredOpenCallbackPending = false;
				FinishOpenEffect();
			}
		}
	}

	private float GetSafeAnimatorStateLength(AnimatorStateInfo stateInfo, float fallback)
	{
		float length = stateInfo.length;
		if (float.IsNaN(length) || float.IsInfinity(length) || length <= 0f || length > 10f)
		{
			return fallback;
		}
		return length;
	}

	private void InitSceneBlurSnapshotOverlay()
	{
		if (sceneBlurSnapshotOverlay != null)
		{
			sceneBlurSnapshotOverlay.SetActive(value: false);
		}
	}

	public void ShowSceneBlurSnapshotOverlay()
	{
		if (sceneBlurSnapshotOverlay != null)
		{
			sceneBlurSnapshotOverlay.SetActive(value: true);
		}
	}

	public async UniTask PlaySceneBlurSnapshotOverlayFadeOutAsync(CancellationToken token)
	{
		ShowSceneBlurSnapshotOverlay();
		int layerIndex = uiEffectAnimator.GetLayerIndex("FadeOutLayer");
		uiEffectAnimator.Play("CaptureFadeOut", layerIndex, 0f);
		uiEffectAnimator.Update(0f);
		await UniTask.WaitUntil(() =>
		{
			AnimatorStateInfo currentAnimatorStateInfo = uiEffectAnimator.GetCurrentAnimatorStateInfo(layerIndex);
			return currentAnimatorStateInfo.IsName("CaptureFadeOut") && currentAnimatorStateInfo.normalizedTime >= 1f;
		}, PlayerLoopTiming.Update, token);
		if (sceneBlurSnapshotOverlay != null)
		{
			sceneBlurSnapshotOverlay.SetActive(value: false);
		}
	}

	protected override void CloseEffectCallback()
	{
		normalView.OnHidden();
	}

	public void OnAutoPlayChanged(bool newValue)
	{
		autoPlayAnimator.SetBool(IsPlay, newValue);
	}

	public void OnBtnHideClick()
	{
		foreach (Behaviour content in contents)
		{
			content.enabled = false;
		}
		hideTrigger.gameObject.SetActive(value: true);
		uiEffectAnimator.SetBool("ShowHUD", value: false);
	}

	public void OnBtnShowClick()
	{
		foreach (Behaviour content in contents)
		{
			content.enabled = true;
		}
		hideTrigger.gameObject.SetActive(value: false);
		uiEffectAnimator.SetBool("ShowHUD", value: true);
	}

	public void ShowStoryPanel()
	{
		if (Singleton<ConversationManager>.instance.PlayingDialogue is IAVGDialogue)
		{
			storyPanel.Show();
		}
	}

	public bool IsStoryPanelVisible()
	{
		return storyPanel.IsVisible();
	}

	public void RefreshTips()
	{
		if (IsStoryPanelVisible())
		{
			normalView.gameObject.SetActive(value: false);
			topControl.SetActive(value: false);
			SwitchTips("ReviewTip");
			return;
		}
		normalView.gameObject.SetActive(value: true);
		topControl.SetActive(value: true);
		if (blackScreen.Visible)
		{
			SwitchTips(string.Empty);
		}
		else if (normalView.gameObject.activeSelf)
		{
			switch (normalView.CurrentType)
			{
			case UIType.DELAY:
			case UIType.WAITCLICK:
				SwitchTips("NormalTip");
				break;
			case UIType.CHOICE_HIDE:
			case UIType.CHOICE_SHOW:
				SwitchTips("ChoicesTip");
				break;
			}
		}
	}

	private void SwitchTips(string tipsName)
	{
		for (int i = 0; i < tips.Count; i++)
		{
			GameObject gameObject = tips[i];
			gameObject.SetActive(gameObject.name == tipsName);
		}
	}

	public bool CanAutoNext()
	{
		if (UIController.State != UIState.Opened)
		{
			return false;
		}
		if (NewUIManager.IsUIStateBusy(Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_TEXTPANEL)))
		{
			return false;
		}
		if (storyPanel.IsVisible())
		{
			return false;
		}
		return true;
	}

	public void OnClicked()
	{
		if (!(Time.time - m_Timer <= minClickInterval))
		{
			m_Timer = Time.time;
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Conversation_Selection_Click");
			if (Singleton<ConversationManager>.instance.PlayingDialogue is TimelineDialogue { TimelineType: not TimelineType.DialogueStory })
			{
				normalView.ManualClicked();
			}
			else
			{
				Singleton<ConversationManager>.instance.TryNext();
			}
		}
	}

	[Obsolete]
	public void SetActive(bool isOpen)
	{
		mainPanel.SetActive(isOpen);
	}

	public async UniTask ShowView(UIType type, CancellationToken cancellationToken = default(CancellationToken))
	{
		ConversationStatics oldData = (ConversationStatics)uiViewData;
		DialogueArg newData = new DialogueArg
		{
			AutoNextDelay = ((oldData.AutoNextDelay < 0f) ? normalView.autoNextTime : oldData.AutoNextDelay),
			ContentTypeSpeed = ((oldData.ContentTypeSpeed < normalView.typerSpeed) ? normalView.typerSpeed : oldData.ContentTypeSpeed),
			CanSkip = Singleton<TimelineConversationManager>.instance.CanSkip,
			ID = oldData.localContentId
		};
		if (Singleton<ConversationManager>.instance.PlayingDialogue is TimelineDialogue timelineDialogue)
		{
			newData.StoryGroupId = timelineDialogue.TimelineId;
		}
		if (RuntimeConfigs.data.dramaDialogDatas.TryGetValue(oldData.localContentId, out var value))
		{
			newData.ContentId = value.content;
		}
		newData.VoiceIndex = oldData.localContentId % 100;
		newData.SpeakerId = oldData.localSpeakerId;
		newData.LeftModelMode = oldData.leftModelMode;
		newData.HideLeftModelOnEnd = oldData.hideLeftModelOnEnd;
		newData.SpeakerType = 1;
		newData.SpeakerHeadId = 1;
		if (newData.SpeakerId == 0)
		{
			newData.SpeakerType = 0;
		}
		else if (newData.SpeakerId == 10001)
		{
			newData.SpeakerType = 1;
		}
		else
		{
			newData.SpeakerType = 0;
		}
		DialogueCharacterData value3;
		DramaCharacterData value5;
		if (newData.SpeakerId == 10001)
		{
			int[] array;
			if (false)
			{
				array = ((G.detailUserInfo.Brief.Gender == 1) ? LuminDialogueSettings.GoldMalePlayerAvatarIds : LuminDialogueSettings.GoldFemalePlayerAvatarIds);
			}
			else
			{
				array = ((G.detailUserInfo.Brief.Gender == 1) ? LuminDialogueSettings.MalePlayerAvatarIds : LuminDialogueSettings.FemalePlayerAvatarIds);
			}
			newData.SpeakerHeadId = array[0];
			newData.SpeakerNameId = 0;
			if (RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(10001, out var value2))
			{
				newData.SpeakerNameId = value2.nameLocal;
			}
		}
		else if (RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(oldData.localSpeakerId, out value3))
		{
			newData.SpeakerId = oldData.localSpeakerId;
			newData.SpeakerHeadId = 1;
			newData.SpeakerNameId = 0;
			if (RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(oldData.localSpeakerId, out var value4))
			{
				newData.SpeakerNameId = value4.nameLocal;
				newData.SpeakerHeadId = (value4.icon ? newData.SpeakerId : newData.SpeakerHeadId);
			}
		}
		else if (RuntimeConfigs.data.dramaCharacterDatas.TryGetValue(oldData.localSpeakerId, out value5))
		{
			newData.SpeakerNameId = value5.nameLocal;
			if (value5.icon)
			{
				FieldInfo[] fields = typeof(DramaCharacterData).GetFields();
				newData.SpeakerHeadId = (int)fields[oldData.emojiId].GetValue(value5);
				newData.SpeakerHeadId = ((newData.SpeakerHeadId == 0) ? 1 : newData.SpeakerHeadId);
			}
		}
		if (oldData.options != null)
		{
			newData.OptionDatas = new List<OptionData>(oldData.options.Count);
			for (int i = 0; i < oldData.options.Count; i++)
			{
				int content = RuntimeConfigs.data.dramaDialogDatas[oldData.options[i]].content;
				OptionData item = new OptionData
				{
					OptionIndex = i,
					OptionId = oldData.options[i],
					ContentId = content
				};
				newData.OptionDatas.Add(item);
			}
		}
		else if (oldData.interactEvents != null)
		{
			newData.OptionDatas = new List<OptionData>(oldData.interactEvents.Count);
			for (int j = 0; j < oldData.interactEvents.Count; j++)
			{
				int content2 = CoreUtils.GetData(oldData.interactEvents[j].contentId, RuntimeConfigs.data.dramaDialogDatas).content;
				OptionData item2 = new OptionData
				{
					OptionIndex = j,
					OptionId = oldData.interactEvents[j].contentId,
					ContentId = content2
				};
				newData.OptionDatas.Add(item2);
			}
		}
		ConversationTaskContext choiceTaskContext = new ConversationTaskContext();
		await normalView.Show(newData, choiceTaskContext);
		if (newData.OptionDatas.Count > 0 && choiceTaskContext.Finished)
		{
			result = choiceTaskContext.Choice;
			if ((oldData.options == null || oldData.options.Count <= 0) && oldData.interactEvents != null && oldData.interactEvents.Count > 0)
			{
				await oldData.interactEvents[choiceTaskContext.Choice].OnInteract(((ConversationStatics)uiViewData).context);
				oldData.onEventsOver?.Invoke();
			}
		}
	}

	public UniTask ShowView_V2(ConversationTaskContext conversationTaskContext)
	{
		btnOpenStoryPanel.interactable = true;
		return normalView.Show((DialogueArg)uiViewData, conversationTaskContext);
	}

	public UniTask ImageTask(int imageId, float imageOffset)
	{
		return normalView.ImageTask(imageId, imageOffset);
	}

	public async UniTask WakeFxTask()
	{
		wake.gameObject.SetActive(value: true);
		wakeAnimationBuilder = wake.GetSequenceLastPlayPause("Wake");
		await wakeAnimationBuilder.Play().OnComplete((AnimationBuilder _) =>
		{
			wakeAnimationBuilder = null;
			Singleton<ConversationManager>.instance.conversationView.wake.gameObject.SetActive(value: false);
		}).AwaitComplete();
	}

	public void FinishWakeFx()
	{
		wakeAnimationBuilder?.Complete();
		wakeAnimationBuilder = null;
	}

	public void SkipConversation()
	{
		if (UIController.State != UIState.Opened)
		{
			return;
		}
		TextPanel.Param param = new TextPanel.Param();
		param.onlyClickOnce = true;
		param.Titletexts = new string[1] { "" };
		param.commonId = 0;
		param.texts = new string[1] { "是否跳过该段剧情？" };
		TextPanel.Param param2 = param;
		IDialogueWrapper playingDialogue = Singleton<ConversationManager>.instance.PlayingDialogue;
		if (!(playingDialogue is IAVGDialogue iAVGDialogue))
		{
			if (playingDialogue is TimelineDialogue timelineDialogue)
			{
				try
				{
					int skipText = CoreUtils.GetData(timelineDialogue.TimelineId, RuntimeConfigs.data.dramaTimelineDatas).skipText;
					if (skipText != 0)
					{
						param2.texts = new string[1] { LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, skipText) };
					}
				}
				catch (Exception exception)
				{
					_ = LuminApplication.LogEnabled;
					if (LuminApplication.LogEnabled)
					{
						Debug.LogException(exception);
					}
				}
			}
		}
		else
		{
			int num = 0;
			if (RuntimeConfigs.data.dialogueStoryGroupDatas.TryGetValue(iAVGDialogue.StoryGroupId, out var value))
			{
				num = value.storySummary;
			}
			if (num != 0)
			{
				param2.texts = new string[1] { LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_MainStory, num) };
			}
		}
		param2.OnConfirm = () =>
		{
			Singleton<ConversationManager>.instance.PlayingDialogue?.Skip();
		};
		param2.OnCancel = () =>
		{
			choiceControlLayer.ReFocus();
		};
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEXTPANEL, param2);
	}

	public void OnAutoPlayClick()
	{
		ConversationSettings.AutoPlay = !ConversationSettings.AutoPlay;
	}

	public void OpenTextLibraryPropPick(List<int> ids)
	{
		if (ids == null || ids.Count <= 0)
		{
			return;
		}
		TextLibraryManager instance = Singleton<TextLibraryManager>.instance;
		List<TextLibraryContent> list = ListPool<TextLibraryContent>.Get();
		foreach (int id in ids)
		{
			list.Add(CoreUtils.GetData(id, RuntimeConfigs.data.textLibraryContents));
		}
		if (instance.HasData)
		{
			instance.AddTextLibraryData(list.ToList());
		}
		else
		{
			instance.AddTextLibraryData(list.ToList());
			if (!soundTextLibraryShow.IsNull())
			{
				Singleton<GameManager>.instance.audioManager.PlaySound(soundTextLibraryShow);
			}
			textLibraryPropPick?.Init(new TextLibraryPropPickData
			{
				seatLimit = 5,
				isAvgTextLibrariesDats = true
			}, null);
		}
		ListPool<TextLibraryContent>.Release(list);
	}

	public Transform GetCaptionPrefabRoot()
	{
		if (captionPrefabRoot != null)
		{
			return captionPrefabRoot;
		}
		return transform;
	}
}
