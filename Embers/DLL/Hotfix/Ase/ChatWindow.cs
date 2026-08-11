using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ChatWindow : UGuiWindow
{
	private const string ChatBubblePrefabDir = "ChatBubble";

	[SerializeField]
	private List<GameObject> inputGo;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private Button btnFace;

	[SerializeField]
	private Button btnClose2;

	[SerializeField]
	private Button btnSend;

	[SerializeField]
	private Button btnDisabled;

	[SerializeField]
	private InputField input;

	[SerializeField]
	private TextMeshProUGUI newMsgCount;

	[SerializeField]
	private Button btnNewMsg;

	[SerializeField]
	private TextMeshProUGUI waitTimeTextOnBtn;

	[SerializeField]
	private Scrollbar verticalBar;

	[SerializeField]
	private LoopListView2 chatList;

	[SerializeField]
	private LoopListView2 channelList;

	[SerializeField]
	private GameObject changeChildChannelRootRoot;

	[SerializeField]
	private InputField inputChildChannel;

	[SerializeField]
	private TextMeshProUGUI curChildChannel;

	[SerializeField]
	private Text placeHolderText;

	[SerializeField]
	private ChatImageView chatImageView;

	private bool showImgView;

	private bool canInput;

	private ChatViewModel viewModel;

	private readonly Dictionary<string, GameObject> bubbleTemplateCache = new Dictionary<string, GameObject>();

	private readonly Dictionary<string, Task<GameObject>> bubbleTemplateLoadingTasks = new Dictionary<string, Task<GameObject>>();

	public bool CanInput
	{
		get
		{
			return canInput;
		}
		set
		{
			canInput = value;
			if (inputGo != null && inputGo.Count > 0)
			{
				for (int i = 0; i < inputGo.Count; i++)
				{
					inputGo[i].SetActive(canInput);
				}
			}
		}
	}

	public bool ShowImgView
	{
		get
		{
			return showImgView;
		}
		set
		{
			showImgView = value;
			if (showImgView)
			{
				chatImageView.InitOpen();
			}
			chatImageView.gameObject.SetActive(showImgView);
		}
	}

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ChatViewModel>();
		BindingSet<ChatWindow, ChatViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((ChatWindow v) => v.OpenUguiWindow).To((ChatViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((ChatWindow v) => v.OnDismissRequest).To((ChatViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((ChatWindow v) => v.RefreshChatList).To((ChatViewModel vm) => vm.RefreshChatListRequest);
		bindingSet.Bind(changeChildChannelRootRoot).For((GameObject v) => v.activeSelf).To((ChatViewModel vm) => vm.ShowChangeChildChannel);
		bindingSet.Bind<TextMeshProUGUI>(curChildChannel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ChatViewModel vm) => vm.CurChildChannel);
		bindingSet.Bind(this).For((ChatWindow v) => v.CanInput).To((ChatViewModel vm) => vm.CanInput);
		bindingSet.Bind(btnFace).For((Button v) => v.onClick).To((ChatViewModel vm) => vm.OnOpenFace);
		bindingSet.Bind(this).For((ChatWindow v) => v.ShowImgView).To((ChatViewModel vm) => vm.ShowImgView);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((ChatViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(btnClose2).For((Button v) => v.onClick).To((ChatViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(btnSend).For((Button v) => v.onClick).To((ChatViewModel vm) => vm.SendCommand);
		bindingSet.Bind(btnDisabled).For((Button v) => v.onClick).To((ChatViewModel vm) => vm.OnSendDisableClick);
		bindingSet.Bind(btnNewMsg).For((Button v) => v.onClick).To((ChatViewModel vm) => vm.OnNewMsgClick);
		bindingSet.Bind<TextMeshProUGUI>(newMsgCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ChatViewModel vm) => $"{vm.NewMsgCount}");
		bindingSet.Bind(btnNewMsg.gameObject).For((GameObject v) => v.activeSelf).ToExpression((ChatViewModel vm) => vm.NewMsgCount > 0);
		bindingSet.Bind(btnSend.gameObject).For((GameObject v) => v.activeSelf).ToExpression((ChatViewModel vm) => vm.WaitTime == 0 && vm.CanInput);
		bindingSet.Bind(btnDisabled.gameObject).For((GameObject v) => v.activeSelf).ToExpression((ChatViewModel vm) => vm.WaitTime > 0 && vm.CanInput);
		bindingSet.Bind<TextMeshProUGUI>(waitTimeTextOnBtn).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ChatViewModel vm) => vm.WaitTime);
		bindingSet.Bind(input).For((InputField v) => v.text, (InputField v) => v.onEndEdit).To((ChatViewModel vm) => vm.Msg);
		bindingSet.Bind(input).For((InputField v) => v.text).To((ChatViewModel vm) => vm.Msg)
			.TwoWay();
		bindingSet.Bind(verticalBar).For((Scrollbar v) => v.value, (Scrollbar v) => v.onValueChanged).To((ChatViewModel vm) => vm.VerticalBarVal);
		bindingSet.Bind(placeHolderText).For((Text v) => v.text).ToExpression((ChatViewModel vm) => $"请输入1-{vm.MaxChildChannelCount}频道");
		bindingSet.Build();
		channelList.InitListView(viewModel.OpenChatChannels.Count, OnGetChannelItemByIndex);
		chatList.InitListView(viewModel.ChatList.Count, OnGetChatItemByIndex);
		btnNewMsg.gameObject.SetActive(value: false);
		if (inputChildChannel != null)
		{
			inputChildChannel.onEndEdit.AddListener(EndChildChannelEdit);
		}
		chatImageView.Init(viewModel.ChatImageVM);
	}

	protected override void OnDestroy()
	{
		ClearChatBubbleTemplateCache();
		base.OnDestroy();
	}

	private void ClearChatBubbleTemplateCache()
	{
		if (bubbleTemplateCache != null)
		{
			foreach (KeyValuePair<string, GameObject> item in bubbleTemplateCache)
			{
				GameEntry.Resource.UnloadAsset(item.Key);
			}
			bubbleTemplateCache.Clear();
		}
		if (bubbleTemplateLoadingTasks == null)
		{
			return;
		}
		foreach (Task<GameObject> value in bubbleTemplateLoadingTasks.Values)
		{
			value.Dispose();
		}
		bubbleTemplateLoadingTasks.Clear();
	}

	private void EndChildChannelEdit(string input)
	{
		viewModel.InputChildChannel = input;
		inputChildChannel.text = "";
	}

	private async void RefreshChatList(object sender, InteractionEventArgs e)
	{
		AdjustScrollArgs args = (AdjustScrollArgs)e.Context;
		if (args.moveIndex > 0 && args.toNew)
		{
			viewModel.CheckRemoveHistory();
			chatList.SetListItemCount(viewModel.ChatList.Count);
			chatList.RefreshAllShownItem();
			await UniTask.WaitForSeconds(0.1f);
			chatList.MovePanelToItemIndex(args.moveIndex, 0f);
		}
		else
		{
			chatList.SetListItemCount(viewModel.ChatList.Count, resetPos: false);
			if (args.toNew)
			{
				chatList.MovePanelToItemIndex(args.moveIndex, 0f);
			}
			chatList.RefreshAllShownItem();
		}
	}

	private LoopListViewItem2 OnGetChannelItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.OpenChatChannels.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("ChatChannelItem");
		if (loopListViewItem != null)
		{
			ChatChannelItemView component = loopListViewItem.GetComponent<ChatChannelItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.GetChannelItem(viewModel.OpenChatChannels[index]));
			}
			else
			{
				component.RefreshData(viewModel.GetChannelItem(viewModel.OpenChatChannels[index]));
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetChatItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ChatList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		loopListViewItem = (viewModel.ChatList[index].IsSend ? ((viewModel.ChatList[index].Data.ArgId > 0) ? listView2.NewListViewItem("MessageSendItemButton") : ((viewModel.ChatList[index].Data.emojiId <= 0) ? listView2.NewListViewItem("MessageSendItem") : listView2.NewListViewItem("MessageSendImageItem"))) : ((viewModel.ChatList[index].Data.argTypeEnum == ChatMessageArgEnum.System) ? listView2.NewListViewItem("MessageRecItemSystem") : ((viewModel.ChatList[index].Data.ArgId > 0) ? listView2.NewListViewItem("MessageRecItemButton") : ((viewModel.ChatList[index].Data.emojiId <= 0) ? listView2.NewListViewItem("MessageRecItem") : listView2.NewListViewItem("MessageRecImageItem")))));
		if (loopListViewItem != null)
		{
			ChatMessageItemView component = loopListViewItem.GetComponent<ChatMessageItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ChatList[index]);
				component.SetFitter();
			}
			else
			{
				component.RefreshData(viewModel.ChatList[index]);
				component.SetFitter();
			}
			ApplyChatBubble(component, viewModel.ChatList[index]);
		}
		return loopListViewItem;
	}

	private void ApplyChatBubble(ChatMessageItemView itemView, ChatMessageItemViewModel itemVm)
	{
		if (itemView == null)
		{
			return;
		}
		if (itemVm == null || itemVm.Data == null)
		{
			itemView.ClearChatBubble();
		}
		else if (itemVm.Data.ArgEnum == ChatMessageArgEnum.System)
		{
			itemView.ClearChatBubble();
		}
		else if (!(itemView.chatBubbleRoot == null))
		{
			int num = itemVm.Data.Bubble;
			if (num < 0)
			{
				num = 0;
			}
			if (itemVm.Data.emojiId > 0)
			{
				num = 0;
			}
			bool isSend = itemVm.IsSend;
			bool useResPath = true;
			itemView.SyncChatBubbleRootToMsgBg();
			LoadAndApplyBubbleAsync(itemView, itemVm.Data, num, isSend, useResPath);
		}
	}

	private async void LoadAndApplyBubbleAsync(ChatMessageItemView itemView, ChatData data, int bubbleId, bool isSend, bool useResPath1)
	{
		GameObject gameObject = await GetBubbleTemplateAsync(bubbleId);
		if (!(itemView == null) && itemView.ViewModel != null && itemView.ViewModel.Data == data)
		{
			if (gameObject == null)
			{
				itemView.ClearChatBubble();
				return;
			}
			itemView.SyncChatBubbleRootToMsgBg();
			itemView.ApplyChatBubbleTemplate(gameObject, bubbleId, isSend, useResPath1);
		}
	}

	private static string GetBubblePrefabPath(int bubbleId)
	{
		return AssetUtility.GetUIItemAsset(string.Format("{0}/MsgBubble{1}", "ChatBubble", bubbleId));
	}

	private UniTask<GameObject> GetBubbleTemplateAsync(int bubbleId)
	{
		string bubblePrefabPath = GetBubblePrefabPath(bubbleId);
		if (bubbleTemplateCache.TryGetValue(bubblePrefabPath, out var value) && value != null)
		{
			return UniTask.FromResult(value);
		}
		if (bubbleTemplateLoadingTasks.TryGetValue(bubblePrefabPath, out var value2) && value2 != null)
		{
			return value2.AsUniTask();
		}
		Task<GameObject> task = LoadBubbleTemplateInternal(bubbleId).AsTask();
		bubbleTemplateLoadingTasks[bubblePrefabPath] = task;
		return AwaitAndCache(bubbleId, task);
	}

	private async UniTask<GameObject> AwaitAndCache(int bubbleId, Task<GameObject> task)
	{
		string path = GetBubblePrefabPath(bubbleId);
		GameObject gameObject = await task.AsUniTask();
		bubbleTemplateLoadingTasks.Remove(path);
		if (gameObject != null && !bubbleTemplateCache.ContainsKey(path))
		{
			bubbleTemplateCache[path] = gameObject;
		}
		return gameObject;
	}

	private async UniTask<GameObject> LoadBubbleTemplateInternal(int bubbleId)
	{
		string bubblePrefabPath = GetBubblePrefabPath(bubbleId);
		GameObject gameObject = await GameEntry.Resource.LoadAssetAsync<GameObject>(bubblePrefabPath);
		if (gameObject == null)
		{
			return null;
		}
		return gameObject;
	}

	public void RefreshData(ChatViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
