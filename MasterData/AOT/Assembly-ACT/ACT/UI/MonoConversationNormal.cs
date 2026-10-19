using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using ACT.Config;
using ACT.DialogueSystem;
using ACT.Drama;
using ACT.Game;
using ACT.Model;
using ACT.Sound;
using ACT.Sound.Management;
using ACT.UI.InputController;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using DG.Tweening;
using DG.Tweening.Core;
using DG.Tweening.Plugins.Options;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.Settings;
using UnityEngine.Pool;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoConversationNormal : MonoBehaviour
{
	public class Context
	{
		public MonoConversationView.DialogueArg DialogueArg;

		public bool CanOperate;

		public bool PassiveFinish;

		public MonoConversationView.UIType CurrentType = MonoConversationView.UIType.WAITCLICK;

		public List<(Button btn, InteractBtn)> ChoiceBtns;
	}

	public enum SubtitlePosition
	{
		Top,
		Center,
		Bottom
	}

	public enum SubtitleAnimType
	{
		None,
		TypeWriter,
		FadeInOut
	}

	private sealed class SubtitleItem
	{
		public readonly GameObject GameObject;

		public readonly RectTransform RectTransform;

		public readonly TextMeshProUGUI Text;

		public readonly MonoTypeWriterEffect TypeWriter;

		public SubtitleItem(GameObject gameObject)
		{
			GameObject = gameObject;
			RectTransform = gameObject.transform as RectTransform;
			Text = gameObject.GetComponent<TextMeshProUGUI>();
			TypeWriter = gameObject.GetComponent<MonoTypeWriterEffect>();
		}
	}

	private bool m_Hidden;

	private int m_SpeakerId;

	private int m_SpeakerHeadId;

	private int m_SpeakerNameId;

	private CancellationTokenSource m_ContentAnimCTS;

	private List<(Button, InteractBtn)> m_ChoiceBtns;

	private Sprite m_BtnOptionDefaultSprite;

	[Header("对话选项文字普通字色")]
	private Color btnTextNormalColor;

	[Header("所在的View")]
	public MonoConversationView conversationView;

	[Header("说话人")]
	public TMP_Text speakerText;

	public LocalizeStringEvent speaker;

	public HorizontalLayoutGroup speakerRootLayout;

	[Header("说话人头像")]
	public GameObject head;

	public BImage headImage;

	[Header("说话内容")]
	public MonoTypeWriterEffect contentTypeWriter;

	public TMP_Text subtitleContent;

	[Header("选项相关")]
	public GameObject btnPrefab;

	public GameObject btnGroup;

	public AudioEventReference soundChoicesShow;

	[Header("插图")]
	public ConversationImageBlur imageBlur;

	public UIRelativeEffect imageBlur2;

	public ConversationImage imageTemplate;

	public AudioEventReference soundImageShow;

	[Header("字幕")]
	public TextMeshProUGUI subtitleTop;

	public TextMeshProUGUI subtitleBottom;

	public TextMeshProUGUI subtitleCenter;

	public MonoTypeWriterEffect subtitleTopTypeWriter;

	public MonoTypeWriterEffect subtitleBottomTypeWriter;

	public MonoTypeWriterEffect subtitleCenterTypeWriter;

	public float autoNextTime = 0.5f;

	public int typerSpeed = 50;

	[Header("暂时没有注释的字段，后面补充")]
	public GameObject nextButton;

	[Header("字出完之后选项延迟出现的事件")]
	public float optionDelayTime = 0.3f;

	private Context m_currentContext;

	private CancellationTokenSource m_ContentCTS;

	private int m_ImageId;

	private CancellationTokenSource m_ImageCTS;

	private readonly List<ConversationImage> m_ImagePool = new List<ConversationImage>(4);

	private readonly List<ConversationImage> m_ActiveImages = new List<ConversationImage>(4);

	private ConversationImage m_CurrentImage;

	private readonly Dictionary<SubtitlePosition, Vector2> m_InitialSubtitlePositions = new Dictionary<SubtitlePosition, Vector2>();

	private readonly Dictionary<long, SubtitleItem> m_ActiveSubtitles = new Dictionary<long, SubtitleItem>();

	private readonly HashSet<SubtitleItem> m_RentedSubtitles = new HashSet<SubtitleItem>();

	private UnityEngine.Pool.ObjectPool<SubtitleItem> m_SubtitlePool;

	private GameObject m_SubtitleTemplate;

	private Transform m_SubtitleParent;

	public MonoConversationView.UIType CurrentType => m_currentContext.CurrentType;

	public Context CurrentContext => m_currentContext;

	private void OnDestroyChatBox()
	{
		m_ContentAnimCTS?.Cancel();
		m_ContentAnimCTS?.Dispose();
		m_ContentAnimCTS = null;
	}

	private void InitChatBox()
	{
		m_Hidden = !conversationView.uiEffectAnimator.GetBool("NormalDialog");
		ClearSpeaker();
		ClearContent();
		m_SpeakerId = 0;
		m_SpeakerHeadId = 0;
		m_SpeakerNameId = 0;
	}

	private void UnInitChatBox()
	{
		m_ContentAnimCTS?.Cancel();
		m_ContentAnimCTS?.Dispose();
		m_ContentAnimCTS = null;
		ClearSpeaker();
		ClearContent();
		m_SpeakerId = 0;
		m_SpeakerHeadId = 0;
		m_SpeakerNameId = 0;
	}

	private void ClearContent()
	{
		contentTypeWriter.text = string.Empty;
	}

	private void ClearSpeaker()
	{
		speakerText.text = string.Empty;
		speakerRootLayout.gameObject.SetActive(value: false);
		headImage.UnLoad();
		head.gameObject.SetActive(value: false);
		m_SpeakerId = 0;
		m_SpeakerHeadId = 0;
		m_SpeakerNameId = 0;
	}

	private void PauseChatBox()
	{
		contentTypeWriter.Pause();
	}

	private void ResumeChatBox()
	{
		contentTypeWriter.Resume();
	}

	private async UniTask UpdateChatBox(int speakerId, int speakerNameId, int speakerHeadId, bool isMainCharacter, int contentId, int contentSpeed, MonoConversationView.TimelineLeftModelMode leftModelMode)
	{
		ApplyTimelineLeftModelMode(leftModelMode, speakerId, isMainCharacter);
		if (speakerId == 0 && contentId == 0)
		{
			if (await HideChatBox(hideBg: true))
			{
				ClearContent();
				ClearSpeaker();
			}
		}
		else if (m_SpeakerId == speakerId && m_SpeakerNameId == speakerNameId && m_SpeakerHeadId == speakerHeadId)
		{
			if (await ShowChatBox())
			{
				UpdateContent(contentId, contentSpeed);
			}
		}
		else if (await HideChatBox())
		{
			ClearContent();
			await UpdateSpeaker(speakerId, speakerNameId, speakerHeadId, isMainCharacter, leftModelMode);
			if (await ShowChatBox())
			{
				UpdateContent(contentId, contentSpeed);
			}
		}
	}

	private void ApplyTimelineLeftModelMode(MonoConversationView.TimelineLeftModelMode leftModelMode, int speakerId, bool isMainCharacter)
	{
		switch (leftModelMode)
		{
		case MonoConversationView.TimelineLeftModelMode.NonTimeline:
			break;
		case MonoConversationView.TimelineLeftModelMode.TimelineShow:
			head.SetActive(value: false);
			Singleton<TimelineConversationManager>.instance.ChangeLeftModel(speakerId).Forget();
			break;
		case MonoConversationView.TimelineLeftModelMode.TimelineHide:
			head.SetActive(value: false);
			Singleton<TimelineConversationManager>.instance.HideLeftModel(hideMask: true).Forget();
			break;
		default:
			head.SetActive(value: false);
			Singleton<TimelineConversationManager>.instance.HideLeftModel(hideMask: true).Forget();
			break;
		}
	}

	private void UpdateContent(int contentId, int contentTypeSpeed)
	{
		if ((bool)contentTypeWriter)
		{
			contentTypeWriter.TimeSpace = contentTypeSpeed;
			if (contentId == 0)
			{
				contentTypeWriter.text = string.Empty;
				return;
			}
			string localizeString = LocalizationUtility.GetLocalizeString("MainStory", contentId);
			localizeString = LuminDialogueUtility.ProcessPlayerName(localizeString);
			contentTypeWriter.text = localizeString;
		}
	}

	private async UniTask UpdateSpeaker(int speakerId, int speakerNameId, int speakerHeadId, bool isMainCharacter, MonoConversationView.TimelineLeftModelMode leftModelMode)
	{
		bool flag = (leftModelMode == MonoConversationView.TimelineLeftModelMode.NonTimeline) & isMainCharacter;
		head.SetActive(flag);
		if (m_SpeakerId == speakerId && m_SpeakerNameId == speakerNameId && m_SpeakerHeadId == speakerHeadId)
		{
			return;
		}
		ClearSpeaker();
		m_SpeakerId = speakerId;
		m_SpeakerNameId = speakerNameId;
		m_SpeakerHeadId = speakerHeadId;
		CancellationToken token = gameObject.GetCancellationTokenOnDestroy();
		string localizedString = LocalizationSettings.StringDatabase.GetLocalizedString(speaker.StringReference.TableReference, speakerNameId, null, speaker.StringReference.LocaleOverride, speaker.StringReference.FallbackState);
		localizedString = LuminDialogueUtility.ProcessPlayerName(localizedString);
		speakerText.text = localizedString;
		speakerRootLayout.gameObject.SetActive(speakerNameId != 0);
		LayoutRebuilder.ForceRebuildLayoutImmediate(speakerText.transform as RectTransform);
		LayoutRebuilder.MarkLayoutForRebuild(speakerRootLayout.transform as RectTransform);
		if (flag)
		{
			await this.GetImageStation().LoadSpriteAsync(GameLoader.meta.dramaConversationAtalasNameAssetID, speakerHeadId, headImage);
			if (!token.IsCancellationRequested)
			{
				head.SetActive(value: true);
			}
		}
	}

	private bool SpeakerChanged(MonoConversationView.DialogueArg newData)
	{
		if (!newData.HideUI && newData.SpeakerId == m_SpeakerId)
		{
			return newData.SpeakerHeadId != m_SpeakerHeadId;
		}
		return true;
	}

	public async UniTask HideAndClearContent()
	{
		if (await HideChatBox(hideBg: true))
		{
			ClearSpeaker();
			ClearContent();
		}
	}

	private async UniTask<bool> HideChatBox(bool hideBg = false, bool hideIcon = false)
	{
		if ((object)conversationView != null && !conversationView)
		{
			return false;
		}
		Animator animator = conversationView.uiEffectAnimator;
		if ((object)animator != null && !animator)
		{
			return false;
		}
		if (hideBg)
		{
			animator.SetBool("NormalBG", value: false);
			animator.SetBool("NormalDialog", value: false);
		}
		if (m_Hidden)
		{
			return true;
		}
		m_Hidden = true;
		m_ContentAnimCTS?.Cancel();
		m_ContentAnimCTS?.Dispose();
		m_ContentAnimCTS = new CancellationTokenSource();
		int roleChangeLayerIndex = animator.GetLayerIndex("NormalContent");
		CancellationToken token = m_ContentAnimCTS.Token;
		animator.Play("RoleExchangeHide", roleChangeLayerIndex);
		await UniTask.WaitUntil(() => !animator || animator.GetCurrentAnimatorStateInfo(roleChangeLayerIndex).normalizedTime >= 1f, PlayerLoopTiming.Update, token).SuppressCancellationThrow();
		return (bool)animator && !token.IsCancellationRequested;
	}

	private async UniTask<bool> ShowChatBox()
	{
		if ((object)conversationView != null && !conversationView)
		{
			return false;
		}
		Animator animator = conversationView.uiEffectAnimator;
		if ((object)animator != null && !animator)
		{
			return false;
		}
		gameObject.SetActive(value: true);
		if (!m_Hidden)
		{
			return true;
		}
		m_Hidden = false;
		int roleChangeLayerIndex = animator.GetLayerIndex("NormalContent");
		animator.SetBool("NormalBG", value: true);
		animator.SetBool("NormalDialog", value: true);
		animator.Play("RoleExchangeShow", roleChangeLayerIndex, 0f);
		m_ContentAnimCTS?.Cancel();
		m_ContentAnimCTS?.Dispose();
		m_ContentAnimCTS = new CancellationTokenSource();
		CancellationToken token = m_ContentAnimCTS.Token;
		await UniTask.WaitUntil(() => !animator || (animator.GetCurrentAnimatorStateInfo(roleChangeLayerIndex).IsName("RoleExchangeShow") && animator.GetCurrentAnimatorStateInfo(roleChangeLayerIndex).normalizedTime >= 1f), PlayerLoopTiming.Update, token).SuppressCancellationThrow();
		return (bool)animator && !token.IsCancellationRequested;
	}

	private void InitChoices()
	{
		ColorUtility.TryParseHtmlString("#EFF0E1", out btnTextNormalColor);
		if (m_ChoiceBtns == null)
		{
			m_ChoiceBtns = ListPool<(Button, InteractBtn)>.Get();
		}
		RecycleButtonsImmediate(m_ChoiceBtns);
	}

	private void UnInitChoices()
	{
		RecycleButtonsImmediate(m_ChoiceBtns);
	}

	private async UniTask<int> OpenChoices(List<MonoConversationView.OptionData> optionsData, CancellationToken cancellationToken)
	{
		if (cancellationToken.IsCancellationRequested)
		{
			return 0;
		}
		if (!soundChoicesShow.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(soundChoicesShow);
		}
		List<(Button btn, InteractBtn interactBtn)> buttons = await GenButtons(optionsData, cancellationToken);
		if (cancellationToken.IsCancellationRequested)
		{
			if (m_currentContext.ChoiceBtns == buttons)
			{
				RecycleButtonsImmediate(buttons);
			}
			return 0;
		}
		bool hasResult = false;
		int result = 0;
		for (int i = 0; i < buttons.Count; i++)
		{
			(Button btn, InteractBtn interactBtn) tuple = buttons[i];
			MonoConversationView.OptionData optionData = optionsData[i];
			tuple.btn.onClick.RemoveAllListeners();
			tuple.btn.onClick.AddListener(() =>
			{
				hasResult = true;
				result = optionData.OptionIndex;
			});
		}
		await UniTask.WaitUntil(() => hasResult, PlayerLoopTiming.Update, cancellationToken).SuppressCancellationThrow();
		if (cancellationToken.IsCancellationRequested)
		{
			if (m_currentContext.ChoiceBtns == buttons)
			{
				RecycleButtonsImmediate(buttons);
			}
			return 0;
		}
		await RecycleButtons(buttons, cancellationToken);
		return result;
	}

	private async UniTask<List<(Button btn, InteractBtn interactBtn)>> GenButtons(List<MonoConversationView.OptionData> options, CancellationToken cancellationToken)
	{
		Context currentContext = m_currentContext;
		if (currentContext.ChoiceBtns == null)
		{
			currentContext.ChoiceBtns = new List<(Button, InteractBtn)>();
		}
		List<(Button btn, InteractBtn)> btns = m_currentContext.ChoiceBtns;
		btns.Clear();
		ColorUtility.TryParseHtmlString("#7C7C7C", out var onSelected);
		for (int i = 0; i < options.Count; i++)
		{
			if (cancellationToken.IsCancellationRequested)
			{
				continue;
			}
			MonoConversationView.OptionData optionData = options[i];
			(Button btn, InteractBtn interactBtn) btn = GetButton();
			btn.btn.interactable = true;
			btns.Add(btn);
			if (m_BtnOptionDefaultSprite == null && btn.interactBtn.graphics[1] is Image image)
			{
				m_BtnOptionDefaultSprite = image.sprite;
			}
			bool isNewChoice = !Singleton<ConversationManager>.instance.RecordedUsedChoices.Contains(optionData.OptionId);
			btn.interactBtn.localizeStringEvent.SetTable("MainStory");
			btn.interactBtn.localizeStringEvent.StringReference.TableEntryReference = optionData.ContentId;
			if (optionData.IconId >= 0)
			{
				NPCHeadIconConfig.IconConfig iconConfig = GameLoader.meta.npcOrInteractObjectIconConfig.FindConfigById(optionData.IconId);
				if (iconConfig != null)
				{
					Sprite sprite = await this.GetImageStation().LoadSpriteAsync(GameLoader.meta.interactIconNameAssetID, iconConfig.icon);
					if (btn.interactBtn.graphics[1] is Image image2)
					{
						image2.sprite = sprite;
					}
				}
			}
			else if (btn.interactBtn.graphics[1] is Image image3)
			{
				image3.sprite = m_BtnOptionDefaultSprite;
			}
			if (!cancellationToken.IsCancellationRequested)
			{
				if (isNewChoice)
				{
					btn.interactBtn.selected.color = btnTextNormalColor;
					btn.interactBtn.text.color = btnTextNormalColor;
				}
				else
				{
					btn.interactBtn.selected.color = onSelected;
					btn.interactBtn.text.color = btnTextNormalColor;
				}
				btn.interactBtn.Apply(btn.interactBtn.selected);
			}
		}
		foreach (var item in btns)
		{
			item.btn.gameObject.SetActive(value: true);
		}
		if (btns.Count > 0 && Singleton<NewUIManager>.instance.GetTopActiveUI().UIType == UI_TYPE.UI_CONVERSATION)
		{
			btns[0].btn.Select();
		}
		return btns;
	}

	private async UniTask RecycleButtons(List<(Button btn, InteractBtn interactBtn)> buttons, CancellationToken cancellationToken)
	{
		if (!this || buttons == null)
		{
			return;
		}
		List<UniTask> tasks = ListPool<UniTask>.Get();
		foreach (var b in buttons)
		{
			b.btn.onClick.RemoveAllListeners();
			b.interactBtn.anim.Play("Hide");
			UniTask item = UniTask.WaitUntil(() =>
			{
				bool result = !b.btn.isActiveAndEnabled || b.btn.animator.GetCurrentAnimatorStateInfo(0).normalizedTime >= 1f;
				b.btn.gameObject.SetActive(value: false);
				b.btn.interactable = false;
				return result;
			}, PlayerLoopTiming.Update, cancellationToken);
			tasks.Add(item);
		}
		await UniTask.WhenAll(tasks).SuppressCancellationThrow();
		ListPool<UniTask>.Release(tasks);
	}

	private void RecycleButtonsImmediate(List<(Button btn, InteractBtn interactBtn)> buttons)
	{
		if (!this || buttons == null)
		{
			return;
		}
		foreach (var button in buttons)
		{
			button.btn.onClick.RemoveAllListeners();
			button.btn.gameObject.SetActive(value: false);
			button.btn.interactable = false;
		}
	}

	private (Button btn, InteractBtn interactBtn) GetButton()
	{
		for (int i = 0; i < m_ChoiceBtns.Count; i++)
		{
			(Button, InteractBtn) result = m_ChoiceBtns[i];
			if (!result.Item1.gameObject.activeSelf && !result.Item1.interactable)
			{
				result.Item1.interactable = true;
				return result;
			}
		}
		GameObject gameObject = UnityEngine.Object.Instantiate(btnPrefab, btnGroup.transform);
		InteractBtn component = gameObject.GetComponent<InteractBtn>();
		Button component2 = gameObject.GetComponent<Button>();
		m_ChoiceBtns.Add((component2, component));
		return (btn: component2, interactBtn: component);
	}

	public void OnSelect()
	{
		if ((CurrentContext.CurrentType != MonoConversationView.UIType.CHOICE_HIDE && CurrentContext.CurrentType != MonoConversationView.UIType.CHOICE_SHOW) || CurrentContext.ChoiceBtns == null)
		{
			return;
		}
		for (int i = 0; i < CurrentContext.ChoiceBtns.Count; i++)
		{
			(Button, InteractBtn) tuple = CurrentContext.ChoiceBtns[i];
			if (EventSystemHelper.CurrentSelected != tuple.Item1.gameObject)
			{
				tuple.Item1.onClick.Invoke();
				break;
			}
		}
	}

	private void OnDestroy()
	{
		OnDestroyChatBox();
		m_ContentCTS?.Cancel();
		m_ContentCTS?.Dispose();
		m_ContentCTS = null;
	}

	public void Init()
	{
		conversationView.uiEffectAnimator.speed = 1f;
		ResumeChatBox();
		m_Hidden = true;
		m_currentContext = new Context();
		InitChoices();
		InitImage();
		InitChatBox();
		InitSound();
		InitSubtitle2();
	}

	public void UnInit()
	{
		conversationView.uiEffectAnimator.speed = 1f;
		ResumeChatBox();
		m_currentContext = new Context();
		UnInitSound();
		UnInitChoices();
		UnInitImage();
		UnInitChatBox();
		UnInitSubtitle2();
		CloseTextLibraryPropPick();
		m_ContentCTS?.Cancel();
		m_ContentCTS?.Dispose();
		m_ContentCTS = null;
	}

	public void Pause()
	{
		conversationView.uiEffectAnimator.speed = 0f;
		if ((bool)UIConversationScene.Instance)
		{
			UIConversationScene.Instance.Pause();
		}
		PauseVoice();
		PauseChatBox();
	}

	public void Resume()
	{
		conversationView.uiEffectAnimator.speed = 1f;
		if ((bool)UIConversationScene.Instance)
		{
			UIConversationScene.Instance.Resume();
		}
		ResumeVoice();
		ResumeChatBox();
	}

	public void OnHidden()
	{
	}

	public void OnRelease()
	{
		ListPool<(Button, InteractBtn)>.Release(m_ChoiceBtns);
	}

	public async UniTask PreShow(MonoConversationView.DialogueArg newData)
	{
		if (newData.IsSubtitle)
		{
			await HideChatBox(hideBg: true);
			ClearSubtitle();
			return;
		}
		bool flag = SpeakerChanged(newData);
		if ((gameObject.activeInHierarchy && m_Hidden) & flag)
		{
			await HideAndClearContent();
		}
	}

	public async UniTask Show(MonoConversationView.DialogueArg newData, ConversationTaskContext choicesTaskContext)
	{
		m_ContentCTS?.Cancel();
		m_ContentCTS?.Dispose();
		m_ContentCTS = new CancellationTokenSource();
		CancellationTokenSource cancellationTokenSource = CancellationTokenSource.CreateLinkedTokenSource(m_ContentCTS.Token, gameObject.GetCancellationTokenOnDestroy());
		CancellationToken token = cancellationTokenSource.Token;
		Context context = new Context
		{
			DialogueArg = newData
		};
		if (newData.OptionDatas.Count > 0)
		{
			context.CurrentType = MonoConversationView.UIType.CHOICE_SHOW;
		}
		else if (newData.AutoNext)
		{
			context.CurrentType = MonoConversationView.UIType.DELAY;
		}
		else
		{
			context.CurrentType = MonoConversationView.UIType.WAITCLICK;
		}
		m_currentContext = context;
		try
		{
			conversationView.RefreshTips();
			conversationView.skip.interactable = newData.CanSkip;
			nextButton.SetActive(newData.OptionDatas.Count <= 0);
			try
			{
				if (newData.IsSubtitle)
				{
					await HideAndClearContent();
					UpdateSubtitle(newData.ContentId);
				}
				else
				{
					ClearSubtitle();
					await UpdateChatBox(newData.SpeakerId, newData.SpeakerNameId, newData.SpeakerHeadId, newData.IsMainCharacter, newData.ContentId, newData.ContentTypeSpeed, newData.LeftModelMode).SuppressCancellationThrow();
				}
				if (token.IsCancellationRequested)
				{
					return;
				}
				context.CanOperate = true;
				TaskContext voiceTaskContext = PlayVoice(newData.StoryGroupId, newData.ID, newData.VoiceIndex, newData.SpeakerId, newData.IsMainCharacter, token);
				int num = ((!Singleton<DramaVoiceManager>.instance.IsPlaying()) ? 2 : 0);
				float totalDelay = ((newData.ContentId == 0) ? 0f : (newData.AutoNextDelay + (float)num));
				UniTask uniTask = UniTask.CompletedTask;
				if (!newData.IsSubtitle)
				{
					uniTask = UniTask.WaitUntil(() => contentTypeWriter.IsFinished, PlayerLoopTiming.Update, token).SuppressCancellationThrow();
				}
				await uniTask;
				if (token.IsCancellationRequested)
				{
					return;
				}
				List<int> keyWords = newData.KeyWords;
				if (keyWords != null && keyWords.Count > 0)
				{
					conversationView.OpenTextLibraryPropPick(newData.KeyWords);
				}
				if (newData.OptionDatas.Count <= 0)
				{
					float timer = 0f;
					await UniTask.WaitUntil(() =>
					{
						if (conversationView.hideTrigger.gameObject.activeSelf)
						{
							return false;
						}
						bool flag = newData.IsSubtitle || contentTypeWriter.IsFinished;
						if (conversationView.CanAutoNext() && flag && voiceTaskContext.Finished)
						{
							timer += Time.unscaledDeltaTime;
						}
						if (context.PassiveFinish)
						{
							return true;
						}
						return (timer >= totalDelay && (ConversationSettings.AutoPlay || newData.AutoNext || newData.HideUI)) ? true : false;
					}, PlayerLoopTiming.Update, token).SuppressCancellationThrow();
					if (token.IsCancellationRequested)
					{
						return;
					}
				}
				else
				{
					await UniTask.WaitForSeconds(optionDelayTime, ignoreTimeScale: false, PlayerLoopTiming.Update, token).SuppressCancellationThrow();
					if (token.IsCancellationRequested)
					{
						return;
					}
					int choice = await OpenChoices(newData.OptionDatas, token);
					if (token.IsCancellationRequested)
					{
						return;
					}
					choicesTaskContext.Choice = choice;
				}
				if (newData.HideLeftModelOnEnd)
				{
					Singleton<TimelineConversationManager>.instance.HideLeftModel(hideMask: true).Forget();
				}
			}
			catch (Exception exception)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception);
				}
			}
		}
		catch (Exception exception2)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception2);
			}
		}
		try
		{
			if ((bool)this && m_currentContext == context)
			{
				ClearVoice();
				ClearContent();
				ClearSubtitle();
			}
		}
		catch (Exception exception3)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception3);
			}
		}
		choicesTaskContext.Finish();
	}

	public void TriggerFinish()
	{
		if (m_currentContext.DialogueArg != null)
		{
			m_currentContext.DialogueArg.KeyWords = null;
		}
		conversationView.textLibraryPropPick?.Uninit();
		m_currentContext.PassiveFinish = true;
	}

	public void ManualClicked()
	{
		if (gameObject.activeSelf && m_currentContext != null && m_currentContext.DialogueArg != null && m_currentContext.CanOperate)
		{
			if (m_currentContext.DialogueArg.IsSubtitle)
			{
				m_currentContext.PassiveFinish = true;
			}
			else if (contentTypeWriter.IsFinished)
			{
				m_currentContext.PassiveFinish = true;
			}
			else
			{
				contentTypeWriter.StopTweenString();
			}
		}
	}

	public void InitImage()
	{
		m_ImageId = 0;
		CancelImageTask();
		ClearImage();
		EnsureImageTemplate();
	}

	public void UnInitImage()
	{
		m_ImageId = 0;
		CancelImageTask();
		ClearImage();
	}

	public async UniTask ImageTask(int imageId, float imageOffset)
	{
		if (imageId == 0)
		{
			imageId = m_ImageId;
		}
		if (m_ImageId == imageId && (bool)m_CurrentImage && m_CurrentImage.IsActive())
		{
			return;
		}
		CancelImageTask();
		m_ImageCTS = new CancellationTokenSource();
		CancellationToken token = m_ImageCTS.Token;
		int imageId2 = m_ImageId;
		ConversationImage currentImage = m_CurrentImage;
		m_ImageId = imageId;
		m_CurrentImage = null;
		UniTask hideOldImageTask = ((imageId2 > 0 && (bool)currentImage) ? HideAndRecycleImage(currentImage, imageId <= 0) : UniTask.CompletedTask);
		if (m_ImageId <= 0)
		{
			await hideOldImageTask;
			await ConversationImage.FadeBlur(imageBlur2, 0f, token).SuppressCancellationThrow();
			return;
		}
		ConversationImage newImage = GetConversationImage();
		if (!newImage)
		{
			await hideOldImageTask;
			await ConversationImage.FadeBlur(imageBlur2, 0f, token).SuppressCancellationThrow();
			return;
		}
		m_CurrentImage = newImage;
		if (!soundImageShow.IsNull())
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(soundImageShow);
		}
		bool flag = await newImage.Show(imageId, imageOffset, conversationView.Station, imageBlur2, token);
		if (token.IsCancellationRequested)
		{
			if (m_CurrentImage == newImage)
			{
				m_CurrentImage = null;
				RecycleConversationImage(newImage);
			}
		}
		else if (!flag)
		{
			if (m_CurrentImage == newImage)
			{
				m_CurrentImage = null;
				RecycleConversationImage(newImage);
			}
			await hideOldImageTask;
			await ConversationImage.FadeBlur(imageBlur2, 0f, token).SuppressCancellationThrow();
		}
		else
		{
			await hideOldImageTask;
		}
	}

	private void CancelImageTask()
	{
		m_ImageCTS?.Cancel();
		m_ImageCTS?.Dispose();
		m_ImageCTS = null;
	}

	private void EnsureImageTemplate()
	{
		if ((bool)imageTemplate)
		{
			imageTemplate.Clear();
			if (!m_ImagePool.Contains(imageTemplate) && !m_ActiveImages.Contains(imageTemplate))
			{
				m_ImagePool.Add(imageTemplate);
			}
		}
	}

	private ConversationImage GetConversationImage()
	{
		EnsureImageTemplate();
		if (!imageTemplate)
		{
			return null;
		}
		int count = m_ImagePool.Count;
		ConversationImage conversationImage = ((count > 0) ? m_ImagePool[count - 1] : UnityEngine.Object.Instantiate(imageTemplate, imageTemplate.transform.parent));
		if (count > 0)
		{
			m_ImagePool.RemoveAt(count - 1);
		}
		else
		{
			conversationImage.name = imageTemplate.name;
		}
		conversationImage.transform.SetAsLastSibling();
		if (!m_ActiveImages.Contains(conversationImage))
		{
			m_ActiveImages.Add(conversationImage);
		}
		return conversationImage;
	}

	private async UniTask HideAndRecycleImage(ConversationImage conversationImage, bool fadeBlur)
	{
		await conversationImage.Hide(conversationView.Station, imageBlur2, fadeBlur);
		RecycleConversationImage(conversationImage);
	}

	private void RecycleConversationImage(ConversationImage conversationImage)
	{
		if ((bool)conversationImage)
		{
			conversationImage.Release(conversationView.Station);
			conversationImage.Clear();
			m_ActiveImages.Remove(conversationImage);
			if (!m_ImagePool.Contains(conversationImage))
			{
				m_ImagePool.Add(conversationImage);
			}
		}
	}

	private void ClearImage()
	{
		for (int num = m_ActiveImages.Count - 1; num >= 0; num--)
		{
			ConversationImage conversationImage = m_ActiveImages[num];
			if ((bool)conversationImage)
			{
				conversationImage.Release(conversationView.Station);
				conversationImage.Clear();
				if (!m_ImagePool.Contains(conversationImage))
				{
					m_ImagePool.Add(conversationImage);
				}
			}
		}
		m_ActiveImages.Clear();
		for (int i = 0; i < m_ImagePool.Count; i++)
		{
			ConversationImage conversationImage2 = m_ImagePool[i];
			if ((bool)conversationImage2)
			{
				conversationImage2.Release(conversationView.Station);
				conversationImage2.Clear();
			}
		}
		if ((bool)imageBlur)
		{
			imageBlur.intensity = 0f;
			imageBlur.gameObject.SetActive(value: false);
		}
		m_CurrentImage = null;
	}

	private void UpdateSubtitle(int contentId)
	{
		if ((bool)subtitleContent)
		{
			if (contentId == 0)
			{
				subtitleContent.text = string.Empty;
				return;
			}
			string localizeString = LocalizationUtility.GetLocalizeString("MainStory", contentId);
			localizeString = LuminDialogueUtility.ProcessPlayerName(localizeString);
			subtitleContent.text = localizeString;
		}
	}

	private void ClearSubtitle()
	{
		if ((bool)subtitleContent)
		{
			subtitleContent.text = string.Empty;
		}
	}

	private void InitSubtitle2()
	{
		m_InitialSubtitlePositions.Clear();
		CacheSubtitlePosition(SubtitlePosition.Top, subtitleTop);
		CacheSubtitlePosition(SubtitlePosition.Center, subtitleCenter);
		CacheSubtitlePosition(SubtitlePosition.Bottom, subtitleBottom);
		if ((bool)subtitleCenter)
		{
			m_SubtitleTemplate = subtitleCenter.gameObject;
			m_SubtitleParent = subtitleCenter.transform.parent;
			subtitleTop?.gameObject.SetActive(value: false);
			subtitleCenter.gameObject.SetActive(value: false);
			subtitleBottom?.gameObject.SetActive(value: false);
			m_SubtitlePool = new UnityEngine.Pool.ObjectPool<SubtitleItem>(CreateSubtitleItem, OnGetSubtitleItem, OnReleaseSubtitleItem, OnDestroySubtitleItem);
		}
	}

	private void UnInitSubtitle2()
	{
		SubtitleItem[] array = m_RentedSubtitles.ToArray();
		foreach (SubtitleItem subtitle in array)
		{
			ReleaseSubtitleItem(subtitle);
		}
		m_ActiveSubtitles.Clear();
		m_SubtitlePool?.Clear();
		m_SubtitlePool = null;
		m_SubtitleTemplate = null;
		m_SubtitleParent = null;
		m_InitialSubtitlePositions.Clear();
	}

	private void CacheSubtitlePosition(SubtitlePosition position, TextMeshProUGUI subtitle)
	{
		if ((bool)subtitle && subtitle.transform is RectTransform rectTransform)
		{
			m_InitialSubtitlePositions[position] = rectTransform.anchoredPosition;
		}
	}

	private SubtitleItem CreateSubtitleItem()
	{
		GameObject gameObject = UnityEngine.Object.Instantiate(m_SubtitleTemplate, m_SubtitleParent, worldPositionStays: false);
		gameObject.name = m_SubtitleTemplate.name + " (Pooled)";
		gameObject.SetActive(value: false);
		return new SubtitleItem(gameObject);
	}

	private static void OnGetSubtitleItem(SubtitleItem subtitle)
	{
		subtitle.GameObject.SetActive(value: false);
	}

	private static void OnReleaseSubtitleItem(SubtitleItem subtitle)
	{
		subtitle.Text.DOKill();
		subtitle.TypeWriter?.Pause();
		subtitle.TypeWriter?.SetProgress(1f);
		subtitle.Text.text = string.Empty;
		subtitle.GameObject.SetActive(value: false);
	}

	private static void OnDestroySubtitleItem(SubtitleItem subtitle)
	{
		UnityEngine.Object.Destroy(subtitle.GameObject);
	}

	private SubtitleItem GetSubtitleItem()
	{
		if (m_SubtitlePool == null)
		{
			return null;
		}
		SubtitleItem subtitleItem = m_SubtitlePool.Get();
		m_RentedSubtitles.Add(subtitleItem);
		return subtitleItem;
	}

	private void ReleaseSubtitleItem(SubtitleItem subtitle)
	{
		if (subtitle != null && m_RentedSubtitles.Remove(subtitle))
		{
			m_SubtitlePool?.Release(subtitle);
		}
	}

	public async UniTask HideAndClearSubtitle2(long subtitleId, float fadeTime, CancellationToken token)
	{
		if (!m_ActiveSubtitles.TryGetValue(subtitleId, out var subtitle))
		{
			return;
		}
		m_ActiveSubtitles.Remove(subtitleId);
		subtitle.TypeWriter?.Pause();
		subtitle.Text.DOKill();
		fadeTime = Mathf.Max(0f, fadeTime);
		if (subtitle.GameObject.activeSelf && fadeTime > 0f)
		{
			TweenerCore<Color, Color, ColorOptions> tween = subtitle.Text.DOFade(0f, fadeTime);
			await LuminDialogueUtility.WaitForSecondsOrForceNext(fadeTime, token, () =>
			{
				tween.Complete();
			});
		}
		ReleaseSubtitleItem(subtitle);
	}

	public async UniTask UpdateSubtitle2(long subtitleId, SubtitlePosition position, int contentId, float fontSize, Color textColor, Vector2 offset, float rotation, SubtitleAnimType animType, float fadeTime, int typeWriterInterval, CancellationToken token)
	{
		ClearSubtitle();
		await HideAndClearContent();
		if (token.IsCancellationRequested)
		{
			return;
		}
		if (m_ActiveSubtitles.TryGetValue(subtitleId, out var value))
		{
			m_ActiveSubtitles.Remove(subtitleId);
			ReleaseSubtitleItem(value);
		}
		SubtitleItem subtitle = GetSubtitleItem();
		if (subtitle == null || subtitle.Text == null || subtitle.RectTransform == null)
		{
			return;
		}
		m_ActiveSubtitles[subtitleId] = subtitle;
		Vector2 vector = (m_InitialSubtitlePositions.TryGetValue(position, out var value2) ? value2 : Vector2.zero);
		subtitle.RectTransform.anchoredPosition = vector + offset;
		subtitle.RectTransform.localRotation = Quaternion.Euler(0f, 0f, rotation);
		string localizeString = LocalizationUtility.GetLocalizeString("MainStory", contentId);
		localizeString = LuminDialogueUtility.ProcessPlayerName(localizeString);
		subtitle.Text.color = textColor;
		subtitle.Text.fontSize = fontSize;
		subtitle.Text.alpha = 0f;
		subtitle.TypeWriter?.Pause();
		if (subtitle.TypeWriter != null)
		{
			subtitle.TypeWriter.text = string.Empty;
		}
		subtitle.GameObject.SetActive(value: true);
		switch (animType)
		{
		case SubtitleAnimType.None:
			subtitle.Text.text = localizeString;
			subtitle.Text.alpha = 1f;
			break;
		case SubtitleAnimType.FadeInOut:
			subtitle.Text.text = localizeString;
			fadeTime = Mathf.Max(0f, fadeTime);
			if (fadeTime > 0f)
			{
				TweenerCore<Color, Color, ColorOptions> tween = subtitle.Text.DOFade(1f, fadeTime);
				await LuminDialogueUtility.WaitForSecondsOrForceNext(fadeTime, token, () =>
				{
					tween.Complete();
				});
			}
			else
			{
				subtitle.Text.alpha = 1f;
			}
			break;
		case SubtitleAnimType.TypeWriter:
		{
			subtitle.Text.alpha = 1f;
			if (subtitle.TypeWriter == null || typeWriterInterval <= 0)
			{
				subtitle.Text.text = localizeString;
				break;
			}
			subtitle.TypeWriter.TimeSpace = typeWriterInterval;
			subtitle.TypeWriter.text = localizeString;
			subtitle.TypeWriter.Resume();
			await LuminDialogueUtility.WaitUntilOrForceNext(() => subtitle.TypeWriter.IsFinished, token, () =>
			{
				subtitle.TypeWriter.StopTweenString();
			});
			if (m_ActiveSubtitles.TryGetValue(subtitleId, out var value3) && value3 == subtitle)
			{
				subtitle.TypeWriter.Pause();
			}
			break;
		}
		}
	}

	private void CloseTextLibraryPropPick()
	{
		if (conversationView.textLibraryPropPick != null && conversationView.textLibraryPropPick.gameObject.activeInHierarchy)
		{
			conversationView.textLibraryPropPick.Uninit();
		}
	}

	private void InitSound()
	{
	}

	private void UnInitSound()
	{
		ClearVoice();
		Singleton<DramaVoiceManager>.instance.Release();
	}

	private void PauseVoice()
	{
		Singleton<DramaVoiceManager>.instance.PauseVoice(pause: true);
	}

	private void ResumeVoice()
	{
		Singleton<DramaVoiceManager>.instance.PauseVoice(pause: false);
	}

	private TaskContext PlayVoice(int storyGroupId, long voiceId, int voiceIndex, int speakerId, bool isMainCharacter, CancellationToken token)
	{
		TaskContext context = new TaskContext();
		if (token.IsCancellationRequested)
		{
			context.Finish();
			return context;
		}
		if (speakerId == 10001)
		{
			speakerId = ((G.detailUserInfo.Brief.Gender == 1) ? 10002 : 10001);
		}
		Model<LoadULipSyncBakeDataFileModel>.Interface.SpeakId = speakerId;
		Model<LoadULipSyncBakeDataFileModel>.Interface.IsMainCharacter = isMainCharacter;
		PlayVoice().Forget();
		return context;
		async UniTask PlayVoice()
		{
			await Singleton<DramaVoiceManager>.instance.PlayVoiceEventAsync($"event:/Vo/CN/Dialogue/{voiceId}", null, $"{storyGroupId}", voiceIndex).AttachExternalCancellation(token);
			context.Finish();
		}
	}

	private void ClearVoice()
	{
		Singleton<DramaVoiceManager>.instance.StopCurrentVoice();
	}
}
