#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ChatBubbleSetView : UGuiView
{
	[SerializeField]
	private LoopGridView loopGridView;

	[SerializeField]
	private CanvasGroup info;

	[SerializeField]
	private TextMeshProUGUI bubbleName;

	[SerializeField]
	private TextMeshProUGUI bubbleDesc;

	[SerializeField]
	private GameObject expirePart;

	[SerializeField]
	private TextMeshProUGUI expireText;

	[SerializeField]
	private TextMeshProUGUI bubbleContent1;

	[SerializeField]
	private TextMeshProUGUI bubbleContent2;

	[SerializeField]
	private GameObject btnPart;

	[SerializeField]
	private Button btnApply;

	[SerializeField]
	private TextMeshProUGUI btnText;

	[SerializeField]
	private GameObject btnApplyMask;

	[SerializeField]
	private Button btnJump;

	[SerializeField]
	private string jumpWindow;

	[SerializeField]
	private List<int> jumpParams;

	private ChatBubbleSetViewModel _viewModel;

	private const string ChatBubblePrefabDir = "ChatBubble";

	private GameObject _bubbleInstance1;

	private GameObject _bubbleInstance2;

	[SerializeField]
	private RectTransform bubblePrefabRoot1;

	[SerializeField]
	private RectTransform bubblePrefabRoot2;

	private Dictionary<string, GameObject> bubbleTemplateCache = new Dictionary<string, GameObject>();

	private Dictionary<string, Task<GameObject>> bubbleTemplateLoadingTasks = new Dictionary<string, Task<GameObject>>();

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<ChatBubbleSetViewModel>(userData);
		BindingSet<ChatBubbleSetView, ChatBubbleSetViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(bubbleName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ChatBubbleSetViewModel vm) => vm.BubbleName);
		bindingSet.Bind<TextMeshProUGUI>(bubbleDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ChatBubbleSetViewModel vm) => vm.BubbleDesc);
		bindingSet.Bind(expirePart).For((GameObject v) => v.activeSelf).To((ChatBubbleSetViewModel vm) => vm.HaveExpireTime);
		bindingSet.Bind<TextMeshProUGUI>(expireText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ChatBubbleSetViewModel vm) => vm.ExpireTimeText);
		bindingSet.Bind<TextMeshProUGUI>(bubbleContent1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ChatBubbleSetViewModel vm) => vm.BubbleContent);
		bindingSet.Bind<TextMeshProUGUI>(bubbleContent2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ChatBubbleSetViewModel vm) => vm.BubbleContent);
		bindingSet.Bind<TextMeshProUGUI>(bubbleContent1).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).To((ChatBubbleSetViewModel vm) => vm.ContentColor1);
		bindingSet.Bind<TextMeshProUGUI>(bubbleContent2).For((Expression<Func<TextMeshProUGUI, Color>>)((TextMeshProUGUI v) => ((Graphic)v).color)).To((ChatBubbleSetViewModel vm) => vm.ContentColor2);
		bindingSet.Bind(btnPart).For((GameObject v) => v.activeSelf).To((ChatBubbleSetViewModel vm) => vm.ShowBtn);
		bindingSet.Bind<TextMeshProUGUI>(btnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ChatBubbleSetViewModel vm) => vm.BtnText);
		bindingSet.Bind(btnApplyMask).For((GameObject v) => v.activeSelf).To((ChatBubbleSetViewModel vm) => vm.BtnApplyMask);
		bindingSet.Bind(btnApply).For((Button v) => v.onClick).To((ChatBubbleSetViewModel vm) => vm.ApplyCmd);
		bindingSet.Bind(btnApply).For((Button v) => v.enabled).ToExpression((ChatBubbleSetViewModel vm) => !vm.BtnApplyMask);
		bindingSet.Bind().For((ChatBubbleSetView v) => v.RefreshBubblePrefab).To((ChatBubbleSetViewModel vm) => vm.RefreshBubblePrefabRst);
		bindingSet.Build();
		if (btnJump != null)
		{
			JumpWindowParams param = new JumpWindowParams(jumpWindow, jumpParams);
			btnJump.onClick.AddListener(delegate
			{
				_viewModel.ItemOnClick(param);
			});
		}
		loopGridView.InitGridView(_viewModel.BubbleItemDataList.Count, OnGetItemByIndex);
		info.alpha = ((_viewModel.BubbleItemDataList.Count > 0) ? 1 : 0);
		info.blocksRaycasts = _viewModel.BubbleItemDataList.Count > 0;
		RefreshBubblePrefab();
	}

	private LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int dataIndex, int row, int column)
	{
		List<ChatBubbleItemData> bubbleItemDataList = _viewModel.BubbleItemDataList;
		if (dataIndex < 0 || dataIndex >= bubbleItemDataList.Count)
		{
			return null;
		}
		ChatBubbleItemData data = bubbleItemDataList[dataIndex];
		if (data == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = loopGridView.NewListViewItem("ChatBubbleItem");
		ChatBubbleItem component = loopGridViewItem.GetComponent<ChatBubbleItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(data);
		}
		else
		{
			component.RefreshData(data);
		}
		if (_viewModel.CurSelectBubbleData != null)
		{
			data.Selected = data.Data.id == _viewModel.CurSelectBubbleData.id;
		}
		else if (dataIndex == 0)
		{
			data.OnItemClick();
		}
		loopGridViewItem.GetComponent<UIRedPoint>()?.Dispose();
		loopGridViewItem.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.ChatBubble).SetFuncOnMessage((RedPointMessage msg) => (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetItemList(RoleDecorateEnum.ChatBubble) ?? new List<RoleDecorateData>()).Find((RoleDecorateData p) => p.id == data.Data.id)?.isNew ?? false)
			.Invoke();
		return loopGridViewItem;
	}

	private async void RefreshBubblePrefab(object sender = null, InteractionEventArgs e = null)
	{
		if (_viewModel != null && _viewModel.CurSelectBubbleData != null)
		{
			ClearPrefabs();
			GameObject gameObject = await GetTemplateAsync(_viewModel.CurSelectBubbleData.id);
			if (!(gameObject == null))
			{
				ApplyPrefab(gameObject);
			}
		}
	}

	public void ApplyPrefab(GameObject bubbleTemplate)
	{
		if (bubbleTemplate == null)
		{
			return;
		}
		_bubbleInstance1 = UnityEngine.Object.Instantiate(bubbleTemplate, bubblePrefabRoot1);
		_bubbleInstance1.SetActive(value: true);
		_bubbleInstance1.transform.SetAsFirstSibling();
		RectTransform component = _bubbleInstance1.GetComponent<RectTransform>();
		if (component != null)
		{
			component.anchorMin = Vector2.zero;
			component.anchorMax = Vector2.one;
			component.offsetMin = Vector2.zero;
			component.offsetMax = Vector2.zero;
			component.localScale = Vector3.one;
		}
		MsgBubble componentInChildren = _bubbleInstance1.GetComponentInChildren<MsgBubble>(includeInactive: true);
		if (componentInChildren == null)
		{
			Log.Error("Chat bubble prefab missing MsgBubble component: " + _bubbleInstance1.name);
			return;
		}
		componentInChildren.ApplyStyle(isSend: true, useResPath1: false);
		_bubbleInstance2 = UnityEngine.Object.Instantiate(bubbleTemplate, bubblePrefabRoot2);
		_bubbleInstance2.SetActive(value: true);
		_bubbleInstance2.transform.SetAsFirstSibling();
		RectTransform component2 = _bubbleInstance2.GetComponent<RectTransform>();
		if (component2 != null)
		{
			component2.anchorMin = Vector2.zero;
			component2.anchorMax = Vector2.one;
			component2.offsetMin = Vector2.zero;
			component2.offsetMax = Vector2.zero;
			component2.localScale = Vector3.one;
		}
		MsgBubble componentInChildren2 = _bubbleInstance2.GetComponentInChildren<MsgBubble>(includeInactive: true);
		if (componentInChildren2 == null)
		{
			Log.Error("Chat bubble prefab missing MsgBubble component: " + _bubbleInstance2.name);
		}
		else
		{
			componentInChildren2.ApplyStyle(isSend: true, useResPath1: true);
		}
	}

	private UniTask<GameObject> GetTemplateAsync(int bubbleId)
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

	private void ClearPrefabs()
	{
		if (_bubbleInstance1 != null)
		{
			UnityEngine.Object.Destroy(_bubbleInstance1);
			_bubbleInstance1 = null;
		}
		if (_bubbleInstance2 != null)
		{
			UnityEngine.Object.Destroy(_bubbleInstance2);
			_bubbleInstance2 = null;
		}
	}

	protected override void OnDestroy()
	{
		ClearPrefabs();
		ClearChatBubbleTemplateCache();
		base.OnDestroy();
	}
}
