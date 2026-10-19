using ACT.Battle;
using ACT.DialogueSystem;
using ACT.Drama;
using ACT.Sound.Management;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoConversationStoryPanel : MonoBehaviour
{
	public MonoConversationView conversationView;

	public GameObject storyPanelContainer;

	public ScrollRect storyPanelScrollView;

	public ActButton btnClose;

	public ViewControlLayer viewControlLayer;

	public OperateBtnPrompt playTip;

	public Color contentColor_Normal = Color.white;

	public Color contentColor_PB = new Color(0.8431373f, 0.7843137f, 0.5843138f);

	private ConversationImageBlur blur;

	private void Awake()
	{
		btnClose.OnClick.AddListener(Hide);
		blur = GetComponent<ConversationImageBlur>();
		playTip?.gameObject.SetActive(value: false);
	}

	private void OnDisable()
	{
		Singleton<DramaVoiceManager>.instance.StopCurrentVoice();
	}

	private void Update()
	{
		if ((bool)blur)
		{
			blur.intensity = 1f;
		}
	}

	public void Show()
	{
		for (int i = 0; i < storyPanelContainer.transform.childCount; i++)
		{
			storyPanelContainer.transform.GetChild(i).gameObject.SetActive(value: false);
		}
		Transform transform = null;
		for (int j = 0; j < Singleton<ConversationManager>.instance.RecordedHistory.Count; j++)
		{
			ConversationManager.HistoryItem historyItem = Singleton<ConversationManager>.instance.RecordedHistory[j];
			Transform transform2 = null;
			transform2 = ((j >= storyPanelContainer.transform.childCount) ? Object.Instantiate(storyPanelContainer.transform.GetChild(0), storyPanelContainer.transform) : storyPanelContainer.transform.GetChild(j));
			transform2.gameObject.SetActive(value: true);
			transform = transform2;
			bool flag = historyItem.speakerId != 0;
			bool haveVoice = historyItem.type == ConversationManager.HistoryItemType.Normal && Singleton<DramaVoiceManager>.instance.HaveVoice($"event:/Vo/CN/Dialogue/{historyItem.dialogueId}");
			string nameText = string.Empty;
			if (flag)
			{
				nameText = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, historyItem.speakerId);
				nameText = LuminDialogueUtility.ProcessPlayerName(nameText);
			}
			bool flag2 = historyItem.contentId != 0;
			string contentText = string.Empty;
			if (flag2)
			{
				contentText = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_MainStory, historyItem.contentId);
				contentText = LuminDialogueUtility.ProcessPlayerName(contentText);
			}
			transform2.gameObject.GetComponent<ConversationReviewCell>().Init(historyItem.storyGroupId, historyItem.isPlayer, flag, nameText, flag2, contentText, contentColor_Normal, haveVoice, historyItem.dialogueId, historyItem.voiceIndex);
		}
		ScrollRect componentInParent = storyPanelContainer.GetComponentInParent<ScrollRect>();
		if (componentInParent != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(storyPanelContainer.transform as RectTransform);
			componentInParent.verticalNormalizedPosition = 0f;
		}
		playTip?.gameObject.SetActive(value: false);
		gameObject.SetActive(value: true);
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			viewControlLayer.SetDefaultSelect(transform?.gameObject.GetComponent<ACT.ViewControl.SelectableEx>());
			viewControlLayer.Focus();
		}
		else
		{
			viewControlLayer.SetDefaultSelect(null);
			viewControlLayer.Focus(autoFindSelectable: false);
		}
		conversationView.RefreshTips();
	}

	public void Hide()
	{
		gameObject.SetActive(value: false);
		conversationView.RefreshTips();
		viewControlLayer.UnFocus();
	}

	public bool IsVisible()
	{
		return gameObject.activeSelf;
	}
}
