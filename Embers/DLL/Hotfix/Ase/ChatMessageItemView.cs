#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ChatMessageItemView : UGuiView
{
	[SerializeField]
	private new Text name;

	[SerializeField]
	private Text msg;

	[SerializeField]
	private TextMeshProUGUI level;

	[SerializeField]
	private Image head;

	[SerializeField]
	private Image frame;

	[SerializeField]
	private Image title;

	[SerializeField]
	private Image icon;

	public RectTransform chatBubbleRoot;

	[SerializeField]
	private RectTransform msgBg;

	[SerializeField]
	private Button btnInfo;

	[SerializeField]
	private TextMeshProUGUI btnText;

	[SerializeField]
	private Button btnOperate;

	[SerializeField]
	private GameObject btnOperateObj;

	[SerializeField]
	private ButtonLong btnReport;

	public ChatMsgFitter chatMsgFitter;

	private ChatMessageItemViewModel viewModel;

	private int curBubbleId = -1;

	private GameObject bubbleInstance;

	private Color? originMsgColor;

	private GameObject titlePrefabGo;

	private int titlePrefabLoadVersion;

	private int titleId;

	private Color defaultBtnTextColor;

	public int TitleId
	{
		get
		{
			return titleId;
		}
		set
		{
			if (titleId != value)
			{
				titleId = value;
				RefreshTitlePrefab().Forget();
			}
		}
	}

	public ChatMessageItemViewModel ViewModel => viewModel;

	public void Init(ChatMessageItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<ChatMessageItemView, ChatMessageItemViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(name).For((Text v) => v.text).To((ChatMessageItemViewModel vm) => vm.Data.Name);
		if (msg != null)
		{
			bindingSet.Bind(msg).For((Text v) => v.text).To((ChatMessageItemViewModel vm) => vm.Data.Msg);
		}
		bindingSet.Bind<TextMeshProUGUI>(level).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ChatMessageItemViewModel vm) => vm.Data.Level);
		bindingSet.Bind(btnInfo).For((Button v) => v.onClick).To((ChatMessageItemViewModel vm) => vm.ShowUserInfo);
		bindingSet.Bind(head).For((Image v) => v.sprite).ToExpression((ChatMessageItemViewModel vm) => vm.Data.Avatar)
			.WithConversion("ItemIcon");
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((ChatMessageItemViewModel vm) => vm.Data.Icon)
				.WithConversion("ItemIcon");
		}
		bindingSet.Bind(frame).For((Image v) => v.sprite).ToExpression((ChatMessageItemViewModel vm) => $"HeadAdorn{vm.Data.FrameId}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(title.gameObject).For((GameObject v) => v.activeSelf).ToExpression((ChatMessageItemViewModel vm) => vm.Data.TitleId > 0);
		bindingSet.Bind(this).For((ChatMessageItemView v) => v.TitleId).ToExpression((ChatMessageItemViewModel vm) => vm.Data.TitleId);
		bindingSet.Bind<TextMeshProUGUI>(btnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ChatMessageItemViewModel vm) => vm.BtnText);
		bindingSet.Bind(btnOperate).For((Button v) => v.onClick).To((ChatMessageItemViewModel vm) => vm.OnOperateBtnClick);
		bindingSet.Bind(btnOperateObj).For((GameObject v) => v.activeSelf).ToExpression((ChatMessageItemViewModel vm) => vm.Data.ArgId > 0);
		if (btnReport != null)
		{
			bindingSet.Bind(btnReport).For((ButtonLong v) => v.onPress).To((ChatMessageItemViewModel vm) => vm.OnReport);
		}
		bindingSet.Build();
		if (msg != null)
		{
			originMsgColor = msg.color;
		}
		defaultBtnTextColor = ((Graphic)(object)btnText).color;
	}

	private async UniTaskVoid RefreshTitlePrefab()
	{
		int loadVersion = ++titlePrefabLoadVersion;
		ClearTitlePrefab();
		if (title == null)
		{
			return;
		}
		title.sprite = null;
		Color color = title.color;
		title.color = new Color(color.r, color.g, color.b, 0f);
		if (titleId <= 0)
		{
			return;
		}
		DRTitle dataRow = GameEntry.DataTable.GetDataRow<DRTitle>(titleId);
		if (dataRow == null || string.IsNullOrEmpty(dataRow.Icon))
		{
			return;
		}
		GameObject gameObject = await InstantiateAsync(AssetUtility.GetDynamicDecorationPrefab(dataRow.Icon), title.transform);
		if (!(gameObject == null))
		{
			if (loadVersion != titlePrefabLoadVersion)
			{
				UnityEngine.Object.Destroy(gameObject);
				return;
			}
			titlePrefabGo = gameObject;
			titlePrefabGo.transform.localScale = Vector3.one;
			titlePrefabGo.transform.localRotation = Quaternion.identity;
		}
	}

	private void ClearTitlePrefab()
	{
		if (titlePrefabGo != null)
		{
			UnityEngine.Object.Destroy(titlePrefabGo);
			titlePrefabGo = null;
		}
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		titlePrefabLoadVersion++;
		ClearTitlePrefab();
	}

	public void RefreshData(ChatMessageItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		this.SetDataContext(viewModel);
	}

	public void SetFitter()
	{
		if (viewModel != null && !(chatMsgFitter == null))
		{
			chatMsgFitter.SetBGSize(viewModel.Data.Msg, viewModel.IsSend);
			chatMsgFitter.SetCurItemHeight(RectTransform);
		}
	}

	public void ClearChatBubble()
	{
		curBubbleId = -1;
		if (bubbleInstance != null)
		{
			UnityEngine.Object.Destroy(bubbleInstance);
			bubbleInstance = null;
		}
	}

	private void RefreshBtnTextColor(bool useResPath1)
	{
		int id = ((curBubbleId > 0) ? curBubbleId : 0);
		DRChatBox dataRow = GameEntry.DataTable.GetDataRow<DRChatBox>(id);
		if (dataRow == null)
		{
			((Graphic)(object)btnText).color = defaultBtnTextColor;
			return;
		}
		string text = (useResPath1 ? dataRow.LinkColor1 : dataRow.LinkColor2);
		if (!string.IsNullOrEmpty(text) && !text.StartsWith("#"))
		{
			text = "#" + text;
		}
		if (!string.IsNullOrEmpty(text) && ColorUtility.TryParseHtmlString(text, out var color))
		{
			((Graphic)(object)btnText).color = color;
		}
		else
		{
			((Graphic)(object)btnText).color = defaultBtnTextColor;
		}
	}

	public void SyncChatBubbleRootToMsgBg()
	{
		if (chatBubbleRoot == null || chatMsgFitter != null)
		{
			return;
		}
		RectTransform rectTransform = null;
		if (msgBg != null)
		{
			rectTransform = msgBg;
		}
		else
		{
			HorizontalLayoutGroup componentInChildren = GetComponentInChildren<HorizontalLayoutGroup>();
			if (componentInChildren != null)
			{
				rectTransform = componentInChildren.GetComponent<RectTransform>();
			}
		}
		if (!(rectTransform == null))
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform);
			Canvas.ForceUpdateCanvases();
			if (rectTransform.parent is RectTransform layoutRoot)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(layoutRoot);
			}
			chatBubbleRoot.anchorMin = rectTransform.anchorMin;
			chatBubbleRoot.anchorMax = rectTransform.anchorMax;
			chatBubbleRoot.pivot = rectTransform.pivot;
			chatBubbleRoot.anchoredPosition = rectTransform.anchoredPosition;
			chatBubbleRoot.sizeDelta = rectTransform.sizeDelta;
			chatBubbleRoot.localScale = Vector3.one;
		}
	}

	public void ApplyChatBubbleTemplate(GameObject bubbleTemplate, int bubbleId, bool isSend, bool useResPath1)
	{
		if (chatBubbleRoot == null)
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
			RefreshBtnTextColor(useResPath1);
			return;
		}
		ClearChatBubble();
		bubbleInstance = UnityEngine.Object.Instantiate(bubbleTemplate, chatBubbleRoot);
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
			if (!string.IsNullOrEmpty(text) && ColorUtility.TryParseHtmlString(text, out var color) && msg != null)
			{
				msg.color = color;
			}
			else if (msg != null && originMsgColor.HasValue)
			{
				msg.color = originMsgColor.Value;
			}
		}
		else if (msg != null && originMsgColor.HasValue)
		{
			msg.color = originMsgColor.Value;
		}
		RefreshBtnTextColor(useResPath1);
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
}
