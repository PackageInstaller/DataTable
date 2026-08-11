#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class OperatingActivityWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private TabItem tabType1;

	[SerializeField]
	private TabItem tabType2;

	[SerializeField]
	private LoopListView2 tabLoopListView;

	[SerializeField]
	private Transform viewRoot;

	[SerializeField]
	private RectTransform tabTpl;

	[SerializeField]
	private GameObject upArrow;

	[SerializeField]
	private GameObject downArrow;

	[SerializeField]
	private GameObject windowMask;

	[SerializeField]
	private Animator animator;

	[SerializeField]
	private string showUiAniName;

	[SerializeField]
	private string hideUiAniName;

	private Dictionary<int, ActivityViewBase> _activityViews = new Dictionary<int, ActivityViewBase>();

	private ActivityViewBase _curView;

	private OperatingActivityViewModel _viewModel;

	private int curAutoSelectIndex = -1;

	private OpActAnimateState _animateState;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<OperatingActivityViewModel>();
		BindingSet<OperatingActivityWindow, OperatingActivityViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((OperatingActivityWindow v) => v.OnDismissRequest).To((OperatingActivityViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((OperatingActivityWindow v) => v.OpenUguiWindow).To((OperatingActivityViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((OperatingActivityWindow v) => v.OpenUguiWindow2).To((OperatingActivityViewModel vm) => vm.OpenWindowRequest2);
		bindingSet.Bind().For((OperatingActivityWindow v) => v.SetChildViewVisibility).To((OperatingActivityViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((OperatingActivityViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(windowMask).For((GameObject v) => v.activeSelf).ToExpression((OperatingActivityViewModel vm) => vm.WindowMaskLeftTime > 0f);
		bindingSet.Bind().For((OperatingActivityWindow v) => v.RefreshTabListView).To((OperatingActivityViewModel vm) => vm.RefreshActTabListRst);
		bindingSet.Bind().For((OperatingActivityWindow v) => v.OnTabItemClickRst).To((OperatingActivityViewModel vm) => vm.OnActivityTabClick);
		bindingSet.Bind().For((OperatingActivityWindow v) => v.UpdateArrow).To((OperatingActivityViewModel vm) => vm.RedChangeRst);
		bindingSet.Build();
		tabType1.Init(_viewModel.TabTypeItemData1);
		tabType2.Init(_viewModel.TabTypeItemData2);
		tabType1.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.OpActivityRed).SetFuncOnMessage((RedPointMessage message) => Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.GetTypeRed(1) == true)
			.Invoke();
		tabType2.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.OpActivityRed).SetFuncOnMessage((RedPointMessage message) => Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.GetTypeRed(2) == true)
			.Invoke();
		InitTabListView();
		OnTabItemClickRst();
		MarkViewModelVisibleAfterShown().Forget();
		OperatingActivityViewModel viewModel = _viewModel;
		viewModel.AniAction = (Action<OpActAnimateState>)Delegate.Combine(viewModel.AniAction, new Action<OpActAnimateState>(SerAnimator));
	}

	private void Update()
	{
		if (_viewModel != null && !(_viewModel.WindowMaskLeftTime <= 0f))
		{
			_viewModel.WindowMaskLeftTime -= Time.deltaTime;
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (_viewModel != null)
		{
			SerAnimator(_viewModel.AnimateState);
		}
	}

	private async UniTaskVoid MarkViewModelVisibleAfterShown()
	{
		await UniTask.WaitUntil(() => Visibility);
		_viewModel?.MarkWindowVisible(visible: true);
	}

	private void InitTabListView()
	{
		if (_viewModel.AutoSelectActivityId > 0)
		{
			curAutoSelectIndex = _viewModel.TabItemDataList.FindIndex((ActivityTabItemData p) => p.TabIndex == _viewModel.AutoSelectActivityId);
			_viewModel.AutoSelectActivityId = 0;
		}
		if (curAutoSelectIndex < 0)
		{
			curAutoSelectIndex = 0;
		}
		tabLoopListView.InitListView(_viewModel.TabItemDataList.Count, OnGetItemByIndex);
		tabLoopListView.MovePanelToItemIndex(curAutoSelectIndex, 0f);
		tabLoopListView.ScrollRect.onValueChanged.AddListener(delegate
		{
			UpdateArrow();
		});
		UpdateArrow();
	}

	private void RefreshTabListView(object sender, InteractionEventArgs e)
	{
		if (_viewModel.AutoSelectActivityId > 0)
		{
			curAutoSelectIndex = _viewModel.TabItemDataList.FindIndex((ActivityTabItemData p) => p.TabIndex == _viewModel.AutoSelectActivityId);
			_viewModel.AutoSelectActivityId = 0;
		}
		else if (_viewModel.CurSelectTypeId > 0)
		{
			curAutoSelectIndex = _viewModel.TabItemDataList.FindIndex((ActivityTabItemData p) => p.TabIndex == _viewModel.CurSelectTypeId);
		}
		if (curAutoSelectIndex < 0)
		{
			curAutoSelectIndex = 0;
		}
		tabLoopListView.SetListItemCount(_viewModel.TabItemDataList.Count);
		tabLoopListView.RefreshAllShownItem();
		tabLoopListView.MovePanelToItemIndex(curAutoSelectIndex, 0f);
		UpdateArrow();
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.TabItemDataList.Count)
		{
			return null;
		}
		ActivityTabItemData tabItemData = _viewModel.TabItemDataList[index];
		if (tabItemData == null)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = tabLoopListView.NewListViewItem("ActivityTabItem");
		ActivityTabItem component = loopListViewItem.GetComponent<ActivityTabItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(tabItemData);
		}
		else
		{
			component.RefreshData(tabItemData);
		}
		component.GetComponent<UIRedPoint>()?.Dispose();
		component.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.OpActivityRed).SetFuncOnMessage((RedPointMessage message) => Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.GetRed(tabItemData.TabIndex) == true)
			.Invoke();
		if (_viewModel.CurSelectTypeId <= 0)
		{
			if (index == curAutoSelectIndex)
			{
				tabItemData.TabOnClick();
			}
		}
		else
		{
			tabItemData.SetSelected(tabItemData.TabIndex == _viewModel.CurSelectTypeId);
		}
		return loopListViewItem;
	}

	private void UpdateArrow(object sender = null, InteractionEventArgs e = null)
	{
		float viewPortHeight = tabLoopListView.ViewPortHeight;
		float height = tabTpl.rect.height;
		float y = tabLoopListView.ContainerTrans.anchoredPosition.y;
		float num = 0f - y;
		float num2 = 0f - y - viewPortHeight;
		List<LoopListViewItem2> list = new List<LoopListViewItem2>();
		foreach (LoopListViewItem2 item in tabLoopListView.ItemList)
		{
			if (item.CachedRectTransform.anchoredPosition.y - height <= num && item.CachedRectTransform.anchoredPosition.y >= num2)
			{
				list.Add(item);
			}
		}
		int num3 = -1;
		int num4 = -1;
		foreach (LoopListViewItem2 item2 in list)
		{
			if (num3 < 0 || num3 > item2.ItemIndex)
			{
				num3 = item2.ItemIndex;
			}
			if (num4 < 0 || num4 < item2.ItemIndex)
			{
				num4 = item2.ItemIndex;
			}
		}
		bool flag = false;
		bool flag2 = false;
		for (int i = 0; i < _viewModel.TabItemDataList.Count; i++)
		{
			int activityTypeId = _viewModel.TabItemDataList[i].TabIndex;
			ActivityViewModelBase activityViewModelBase = _viewModel.ActivityViewModels.Find((ActivityViewModelBase p) => p.ActivityTypeId == activityTypeId);
			if (activityViewModelBase != null)
			{
				if (num3 >= 0 && !flag && activityViewModelBase.Red && i < num3)
				{
					flag = true;
				}
				if (num4 >= 0 && !flag2 && activityViewModelBase.Red && i > num4)
				{
					flag2 = true;
				}
			}
		}
		upArrow.SetActive(flag);
		downArrow.SetActive(flag2);
	}

	private void OnTabItemClickRst(object sender = null, InteractionEventArgs e = null)
	{
		if (_viewModel.CurSelectTypeId <= 0)
		{
			return;
		}
		OnTabItemClick(_viewModel.CurSelectTypeId);
		if (e == null)
		{
			return;
		}
		object context = e.Context;
		if (context is bool && (bool)context)
		{
			curAutoSelectIndex = _viewModel.TabItemDataList.FindIndex((ActivityTabItemData p) => p.TabIndex == _viewModel.CurSelectTypeId);
			if (curAutoSelectIndex < 0)
			{
				curAutoSelectIndex = 0;
			}
			tabLoopListView.MovePanelToItemIndex(curAutoSelectIndex, 0f);
		}
	}

	private async void OnTabItemClick(int typeId)
	{
		ActivityViewModelBase newViewModel = null;
		_activityViews.TryGetValue(typeId, out var view);
		if (view == null)
		{
			ActivityViewModelBase viewModel = _viewModel.ActivityViewModels.Find((ActivityViewModelBase p) => p.ActivityTypeId == typeId);
			if (string.IsNullOrEmpty(viewModel.UiViewName))
			{
				return;
			}
			try
			{
				await viewModel.RequestDataBeforeShow();
				view = await GameEntry.UI.OpenUIView<ActivityViewBase>(viewModel.UiViewName);
				if (view != null)
				{
					view.transform.SetParent(viewRoot);
					view.Owner.layer = base.gameObject.layer;
					view.RectTransform.localScale = Vector3.one;
					view.RectTransform.anchorMin = Vector2.zero;
					view.RectTransform.anchorMax = Vector2.one;
					view.RectTransform.pivot = Vector2.one * 0.5f;
					view.RectTransform.offsetMin = Vector2.zero;
					view.RectTransform.offsetMax = Vector2.zero;
					newViewModel = viewModel;
					if (_activityViews.ContainsKey(typeId))
					{
						_activityViews[typeId] = view;
					}
					else
					{
						_activityViews.Add(typeId, view);
					}
				}
			}
			catch (Exception ex)
			{
				Log.Error(ex?.ToString() + ex.StackTrace);
			}
			if (view == null)
			{
				return;
			}
		}
		if (_curView != null)
		{
			_curView.Hide(ignoreAnimation: false, Func);
		}
		else
		{
			Func();
		}
		void Func()
		{
			_curView = view;
			if (newViewModel != null)
			{
				view.Init(newViewModel);
			}
			view.Show();
		}
	}

	protected async void OpenUguiWindow2(object sender, InteractionEventArgs args)
	{
		Action callback = null;
		try
		{
			callback = args.Callback;
			OpenViewArgTemp openViewArg = (OpenViewArgTemp)args.Context;
			ViewConfig? viewConfig = null;
			string path;
			if (openViewArg.Path == null)
			{
				ViewConfig[] viewConfigs = ViewConfigSetting.GetViewConfigs((ViewConfig p) => p.ViewClass.Equals(openViewArg.ViewName));
				if (viewConfigs == null || viewConfigs.Length == 0)
				{
					throw new Exception("找不到类型" + openViewArg.ViewName + " 的视图路径");
				}
				path = viewConfigs[0].ViewPath;
				viewConfig = viewConfigs[0];
			}
			else
			{
				ViewConfig[] viewConfigs2 = ViewConfigSetting.GetViewConfigs((ViewConfig p) => p.ViewPath.Equals(openViewArg.Path));
				if (viewConfigs2 != null && viewConfigs2.Length != 0)
				{
					viewConfig = viewConfigs2[0];
				}
				path = openViewArg.Path;
			}
			if (openViewArg.IsOpenWindow)
			{
				await CheckOpenWindow(path, openViewArg.UserData, callback, openViewArg.UiGroupName, viewConfig, openViewArg.Entrance);
			}
			else
			{
				await CheckOpenView(openViewArg.ViewName, path, openViewArg.UserData, viewConfig, openViewArg.Entrance, callback);
			}
		}
		catch (Exception ex)
		{
			callback?.Invoke();
			Log.Error("打开界面发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	protected override void OnDestroy()
	{
		foreach (ActivityViewBase value in _activityViews.Values)
		{
			value.ToDestroy();
		}
		_activityViews.Clear();
		_activityViews = null;
		_viewModel?.MarkWindowVisible(visible: false);
		_viewModel.Dispose();
		base.OnDestroy();
	}

	private void SerAnimator(OpActAnimateState targetState)
	{
		if (base.gameObject.activeSelf && !((UnityEngine.Object)(object)animator == null) && _animateState != targetState)
		{
			_animateState = targetState;
			string text = "";
			switch (targetState)
			{
			case OpActAnimateState.Enter:
				text = "enter";
				break;
			case OpActAnimateState.HideUi:
				text = hideUiAniName;
				break;
			case OpActAnimateState.ShowUi:
				text = showUiAniName;
				break;
			}
			if (!string.IsNullOrEmpty(text))
			{
				animator.SetTrigger(text);
			}
		}
	}
}
