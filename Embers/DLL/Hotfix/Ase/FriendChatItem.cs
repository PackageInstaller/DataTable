#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class FriendChatItem : UGuiView
{
	[SerializeField]
	private Image friendIcon;

	[SerializeField]
	private Image iconFrame;

	[SerializeField]
	private Text friendName;

	[SerializeField]
	private Text friendLevel;

	[SerializeField]
	private GameObject msgGo;

	[SerializeField]
	private Image chatBubble;

	[SerializeField]
	public RectTransform bubblePrefabRoot;

	[SerializeField]
	private Text chatText;

	[SerializeField]
	private GameObject emojiGo;

	[SerializeField]
	private Image emoji;

	private int curBubbleId = -1;

	private GameObject bubbleInstance;

	private Color? originChatColor;

	private PlayerChatData _viewModel;

	public PlayerChatData ViewModel => _viewModel;

	public void Init(PlayerChatData viewModel)
	{
		_viewModel = viewModel;
		BindingSet<FriendChatItem, PlayerChatData> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(friendIcon).For((Image v) => v.sprite).ToExpression((PlayerChatData vm) => vm.PlayerData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(iconFrame).For((Image v) => v.sprite).ToExpression((PlayerChatData vm) => $"HeadAdorn{vm.PlayerData.IconFrame}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(friendName).For((Text v) => v.text).To((PlayerChatData vm) => vm.PlayerData.Name);
		if (msgGo != null)
		{
			bindingSet.Bind(msgGo).For((GameObject v) => v.activeSelf).To((PlayerChatData vm) => vm.IsMsg);
		}
		bindingSet.Bind(chatText).For((Text v) => v.text).To((PlayerChatData vm) => vm.ChatText);
		if (emojiGo != null && emoji != null)
		{
			bindingSet.Bind(emojiGo).For((GameObject v) => v.activeSelf).To((PlayerChatData vm) => vm.IsEmoji);
			bindingSet.Bind(emoji).For((Image v) => v.sprite).ToExpression((PlayerChatData vm) => vm.Emoji)
				.WithConversion("ItemIcon");
		}
		bindingSet.Build();
		if (chatText != null)
		{
			originChatColor = chatText.color;
		}
	}

	public void RefreshData(PlayerChatData viewModel)
	{
		_viewModel = viewModel;
		this.SetDataContext(viewModel);
	}

	public void ApplyChatBubbleTemplate(GameObject bubbleTemplate, int bubbleId, bool isSend, bool useResPath1)
	{
		if (bubblePrefabRoot == null)
		{
			return;
		}
		if (bubbleId < 0)
		{
			bubbleId = 0;
		}
		if (bubbleTemplate == null)
		{
			ClearChatBubble();
			return;
		}
		if (curBubbleId == bubbleId && bubbleInstance != null)
		{
			ApplyBubbleStyle(bubbleInstance, isSend, useResPath1);
			return;
		}
		ClearChatBubble();
		bubbleInstance = Object.Instantiate(bubbleTemplate, bubblePrefabRoot);
		bubbleInstance.name = $"MsgBubble{bubbleId}";
		bubbleInstance.SetActive(value: true);
		bubbleInstance.transform.SetAsFirstSibling();
		RectTransform component = bubbleInstance.GetComponent<RectTransform>();
		if (component != null)
		{
			component.anchorMin = Vector2.zero;
			component.anchorMax = Vector2.one;
			component.offsetMin = Vector2.zero;
			component.offsetMax = Vector2.zero;
			component.localScale = Vector3.one;
		}
		ApplyBubbleStyle(bubbleInstance, isSend, useResPath1);
		curBubbleId = bubbleId;
		DRChatBox dataRow = GameEntry.DataTable.GetDataRow<DRChatBox>(bubbleId);
		if (dataRow != null)
		{
			string text = (useResPath1 ? dataRow.FontColor1 : dataRow.FontColor2);
			if (!string.IsNullOrEmpty(text) && !text.StartsWith("#"))
			{
				text = "#" + text;
			}
			if (!string.IsNullOrEmpty(text) && ColorUtility.TryParseHtmlString(text, out var color) && chatText != null)
			{
				chatText.color = color;
			}
			else if (chatText != null && originChatColor.HasValue)
			{
				chatText.color = originChatColor.Value;
			}
		}
		else if (chatText != null && originChatColor.HasValue)
		{
			chatText.color = originChatColor.Value;
		}
	}

	private static void ApplyBubbleStyle(GameObject bubbleGo, bool isSend, bool useResPath1)
	{
		if (!(bubbleGo == null))
		{
			MsgBubble componentInChildren = bubbleGo.GetComponentInChildren<MsgBubble>(includeInactive: true);
			if (componentInChildren == null)
			{
				Log.Error("Chat bubble prefab missing MsgBubble component: " + bubbleGo.name);
			}
			else
			{
				componentInChildren.ApplyStyle(isSend, useResPath1);
			}
		}
	}

	public void ClearChatBubble()
	{
		curBubbleId = -1;
		if (bubbleInstance != null)
		{
			Object.Destroy(bubbleInstance);
			bubbleInstance = null;
		}
	}

	protected override void OnDestroy()
	{
		ClearChatBubble();
		base.OnDestroy();
	}
}
