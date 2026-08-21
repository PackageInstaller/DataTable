using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class FriendChatView : UGuiView
{
	[SerializeField]
	private Image friendIcon;

	[SerializeField]
	private Text friendName;

	[SerializeField]
	private Text friendLevel;

	[SerializeField]
	private Image friendHeadFrame;

	[SerializeField]
	private Image friendTitle;

	[SerializeField]
	private Button orderBtn;

	[SerializeField]
	private LoopListView2 chatScrollView;

	[SerializeField]
	private Button voiceBtn;

	[SerializeField]
	private InputField chatInputField;

	[SerializeField]
	private Button emoteBtn;

	[SerializeField]
	private Button sendBtn;

	[SerializeField]
	private ChatImageView chatImageView;

	private bool showImgView;

	private const int ChatTimeInterval = 300;

	[SerializeField]
	private GameObject functionPanel;

	[SerializeField]
	private Button openInfoBtn;

	[SerializeField]
	private Button delFriendBtn;

	[SerializeField]
	private Button blackListBtn;

	[SerializeField]
	private Button joinTeamBtn;

	[SerializeField]
	private Button sendTeamApplyBtn;

	[SerializeField]
	private Button emptyAreaBtn;

	private List<PlayerChatData> _playerChatData = new List<PlayerChatData>();

	private RoleViewModel _roleViewModel;

	private FriendChatViewModel _viewModel;

	private string iconAssetPath;

	private string headFrameAssetPath;

	private string titleAssetPath;

	private string assetTag = "FriendChatView";

	private GameObject friendTitlePrefabGo;

	private int friendTitleLoadVersion;

	private const string ChatBubblePrefabDir = "ChatBubble";

	private Dictionary<string, GameObject> bubbleTemplateCache = new Dictionary<string, GameObject>();

	private Dictionary<string, Task<GameObject>> bubbleTemplateLoadingTasks = new Dictionary<string, Task<GameObject>>();

	public FriendChatViewModel ViewModel => _viewModel;

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

	public void Init(FriendChatViewModel viewModel)
	{
		_viewModel = viewModel;
		BindingSet<FriendChatView, FriendChatViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((FriendChatView v) => v.ShowImgView).ToExpression((FriendChatViewModel vm) => vm.ShowImgView);
		bindingSet.Bind(emoteBtn).For((Button v) => v.onClick).To((FriendChatViewModel vm) => vm.OnOpenFace);
		bindingSet.Build();
		_roleViewModel = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData();
		chatScrollView.InitListView(_playerChatData.Count, OnGetItemByIndex);
		orderBtn.onClick.AddListener(delegate
		{
			SetFunctionPanelVisible(visible: true);
		});
		openInfoBtn.onClick.AddListener(OpenPlayerInfo);
		delFriendBtn.onClick.AddListener(TryDeleteFriend);
		blackListBtn.onClick.AddListener(TryAddToBlackList);
		joinTeamBtn.onClick.AddListener(TryJoinTeam);
		sendTeamApplyBtn.onClick.AddListener(TrySendTeamApply);
		emptyAreaBtn.onClick.AddListener(delegate
		{
			SetFunctionPanelVisible(visible: false);
		});
		sendBtn.onClick.AddListener(OnSendBtnClick);
		chatImageView.Init(_viewModel.ChatImageViewModel);
	}

	public async void Refresh(PlayerData playerData, List<PlayerChatData> playerChatData = null)
	{
		_viewModel.RefreshPlayerData(playerData);
		_playerChatData = RefixChatData(playerChatData);
		Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().SetCurChatPlayer(playerData);
		iconAssetPath = "UserHead/" + playerData.Icon + ".png";
		headFrameAssetPath = $"UserHeadFrame/HeadAdorn{playerData.IconFrame}.png";
		Image image = friendIcon;
		image.sprite = await LoadSpriteAsync(AssetUtility.GetTextureIconSprite(iconAssetPath));
		image = friendHeadFrame;
		image.sprite = await LoadSpriteAsync(AssetUtility.GetTextureIconSprite(headFrameAssetPath));
		LoadTitlePrefab(playerData);
		friendName.text = playerData.Name;
		friendLevel.text = $"{playerData.Level}";
		chatScrollView.SetListItemCount((_playerChatData != null) ? _playerChatData.Count : 0, resetPos: false);
		chatScrollView.RefreshAllShownItem();
		int state = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.State;
		joinTeamBtn.gameObject.SetActive(state == 1 && playerData.State == 2);
		sendTeamApplyBtn.gameObject.SetActive(state == 2 && playerData.State == 1);
	}

	private async void LoadTitlePrefab(PlayerData playerData)
	{
		ClearFriendTitlePrefab();
		Color color = friendTitle.color;
		friendTitle.color = new Color(color.r, color.g, color.b, 0f);
		friendTitle.sprite = null;
		int loadVersion = ++friendTitleLoadVersion;
		string text = ((playerData.Title != 0) ? GameEntry.DataTable.GetDataRow<DRTitle>(playerData.Title).Icon : "Title/UserTitle0");
		if (text == null || string.IsNullOrEmpty(text))
		{
			return;
		}
		GameObject gameObject = await InstantiateAsync(AssetUtility.GetDynamicDecorationPrefab(text), friendTitle.transform);
		if (gameObject != null)
		{
			if (loadVersion != friendTitleLoadVersion)
			{
				Object.Destroy(gameObject);
			}
			else
			{
				friendTitlePrefabGo = gameObject;
			}
		}
	}

	private void ClearFriendTitlePrefab()
	{
		friendTitleLoadVersion++;
		if (friendTitlePrefabGo != null)
		{
			Object.Destroy(friendTitlePrefabGo);
			friendTitlePrefabGo = null;
		}
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (_playerChatData == null)
		{
			return null;
		}
		if (index < 0 || index >= _playerChatData.Count)
		{
			return null;
		}
		PlayerChatData playerChatData = _playerChatData[index];
		if (playerChatData == null)
		{
			return null;
		}
		PlayerChatData playerChatData2 = new PlayerChatData(playerChatData.PlayerData, GetReprintChatText(playerChatData.ChatText), playerChatData.ChatTime, playerChatData.UnRead, playerChatData.Bubble);
		LoopListViewItem2 loopListViewItem;
		if (playerChatData2.PlayerData == null)
		{
			loopListViewItem = chatScrollView.NewListViewItem("TimeTips");
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
			}
			((TMP_Text)loopListViewItem.GetComponent<TextMeshProUGUI>()).text = playerChatData2.ChatText;
		}
		else
		{
			bool flag = playerChatData2.PlayerData.Uid == _roleViewModel.PlayerInfo.Uid;
			loopListViewItem = chatScrollView.NewListViewItem(flag ? "SelfSentence" : "OtherSentence");
			FriendChatItem component = loopListViewItem.GetComponent<FriendChatItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(playerChatData2);
			}
			else
			{
				component.RefreshData(playerChatData2);
			}
			if (playerChatData2.IsEmoji)
			{
				component.ClearChatBubble();
			}
			else
			{
				ApplyChatBubble(component, playerChatData2, flag);
			}
		}
		return loopListViewItem;
	}

	private string GetReprintChatText(string text)
	{
		if (string.IsNullOrEmpty(text))
		{
			return "";
		}
		if (text.Length > 27)
		{
			return text.Insert(27, "\n");
		}
		return text;
	}

	private List<PlayerChatData> RefixChatData(List<PlayerChatData> playerChatData)
	{
		if (playerChatData == null)
		{
			return null;
		}
		List<PlayerChatData> list = new List<PlayerChatData>();
		for (int num = playerChatData.Count - 1; num >= 0; num--)
		{
			list.Add(playerChatData[num]);
			if (num - 1 >= 0 && playerChatData[num].ChatTime - playerChatData[num - 1].ChatTime >= 300)
			{
				list.Add(new PlayerChatData(null, TimeHelper.GetLocalDateTime(playerChatData[num].ChatTime).ToString("yyyy-MM.dd-HH:mm:ss"), 0L, unRead: false));
			}
		}
		return list;
	}

	private void OpenPlayerInfo()
	{
		_viewModel.OpenPlayerInfo();
		SetFunctionPanelVisible(visible: false);
	}

	private void TryDeleteFriend()
	{
		IAsyncResult<int> result = AlertDialog.Show("提示", "是否确认删除该好友", "确定", "取消");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				DeleteFriend();
			}
		});
	}

	private async void DeleteFriend()
	{
		Loading loading = await Loading.Show();
		await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().DelFriend(_viewModel.PlayerData.Uid);
		SetFunctionPanelVisible(visible: false);
		loading.Dispose();
	}

	private void TryAddToBlackList()
	{
		IAsyncResult<int> result = AlertDialog.Show("提示", "是否将该好友加入黑名单", "确定", "取消", autoPause: false);
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				AddToBlackList();
			}
		});
	}

	private async void AddToBlackList()
	{
		Loading loading = await Loading.Show();
		await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().HandleFriendBlackList(_viewModel.PlayerData, ope: true);
		SetFunctionPanelVisible(visible: false);
		loading.Dispose();
	}

	private void TryJoinTeam()
	{
		_viewModel.TryJoinFriendTeam();
		SetFunctionPanelVisible(visible: false);
	}

	private void TrySendTeamApply()
	{
		_viewModel.TrySendTeamApply2Friend();
		SetFunctionPanelVisible(visible: false);
	}

	private async void OnSendBtnClick()
	{
		if (chatInputField.text.Length > 0)
		{
			await _viewModel.SendMessage(chatInputField.text);
			chatInputField.text = string.Empty;
		}
	}

	private void SetFunctionPanelVisible(bool visible)
	{
		functionPanel.SetActive(visible);
	}

	private void ApplyChatBubble(FriendChatItem itemView, PlayerChatData itemVm, bool isSend)
	{
		if (!(itemView == null))
		{
			if (itemVm?.PlayerData == null)
			{
				itemView.ClearChatBubble();
				return;
			}
			int bubbleId = ((itemVm.Bubble >= 0) ? itemVm.Bubble : 0);
			LoadAndApplyBubbleAsync(itemView, bubbleId, isSend, useResPath1: false);
		}
	}

	private async void LoadAndApplyBubbleAsync(FriendChatItem itemView, int bubbleId, bool isSend, bool useResPath1)
	{
		GameObject gameObject = await GetBubbleTemplateAsync(bubbleId);
		if (!(itemView == null) && itemView.ViewModel.Bubble == bubbleId)
		{
			if (gameObject == null)
			{
				itemView.ClearChatBubble();
			}
			else
			{
				itemView.ApplyChatBubbleTemplate(gameObject, bubbleId, isSend, useResPath1);
			}
		}
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

	private static string GetBubblePrefabPath(int bubbleId)
	{
		return AssetUtility.GetUIItemAsset(string.Format("{0}/MsgBubble{1}", "ChatBubble", bubbleId));
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
			bubbleTemplateCache = null;
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
		bubbleTemplateLoadingTasks = null;
	}

	protected new void OnDisable()
	{
		SetFunctionPanelVisible(visible: false);
	}

	private new void OnDestroy()
	{
		ClearFriendTitlePrefab();
		ClearChatBubbleTemplateCache();
		base.OnDestroy();
	}
}
