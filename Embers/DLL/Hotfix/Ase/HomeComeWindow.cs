#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HomeComeWindow : UGuiWindow
{
	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private TextMeshProUGUI timeTxt;

	[SerializeField]
	private LoopGridView tabList;

	[SerializeField]
	private GameObject allGiftView;

	[SerializeField]
	private GameObject signRewardView;

	[SerializeField]
	private GameObject phasedActivityView;

	private HomeComeWindowViewModel viewModel;

	private HomeComeAllGiftView allGiftSubView;

	private HomeComeSignRewardView signSubView;

	private HomeComePhasedActivityView phasedSubView;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<HomeComeWindowViewModel>();
		if (viewModel == null)
		{
			Log.Error("HomeComeWindow 打开失败：未传入 HomeComeWindowViewModel");
			Dismiss();
			return;
		}
		BindingSet<HomeComeWindow, HomeComeWindowViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HomeComeWindow v) => v.OnDismissRequest).To((HomeComeWindowViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((HomeComeWindow v) => v.OpenUguiWindow).To((HomeComeWindowViewModel vm) => vm.OpenWindowRequest);
		if (backBtn != null)
		{
			bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((HomeComeWindowViewModel vm) => vm.Close);
		}
		if ((UnityEngine.Object)(object)timeTxt != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(timeTxt).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HomeComeWindowViewModel vm) => vm.LeftTimeText);
		}
		bindingSet.Bind().For((HomeComeWindow v) => v.RefreshView).To((HomeComeWindowViewModel vm) => vm.RefreshRequest);
		bindingSet.Build();
		if (tabList != null)
		{
			tabList.InitGridView(viewModel.TabCount, OnGetTabItemByIndex);
		}
		InitSubViews();
		viewModel.Initialize();
		RefreshView();
	}

	private void InitSubViews()
	{
		if (allGiftView != null)
		{
			allGiftSubView = allGiftView.GetComponent<HomeComeAllGiftView>();
			if (allGiftSubView == null)
			{
				allGiftSubView = allGiftView.AddComponent<HomeComeAllGiftView>();
			}
			allGiftSubView.Init(viewModel.AddChild(new HomeComeAllGiftViewModel(viewModel)));
		}
		if (signRewardView != null)
		{
			signSubView = signRewardView.GetComponent<HomeComeSignRewardView>();
			if (signSubView == null)
			{
				signSubView = signRewardView.AddComponent<HomeComeSignRewardView>();
			}
			signSubView.Init(viewModel.AddChild(new HomeComeSignRewardViewModel(viewModel)));
		}
		if (phasedActivityView != null)
		{
			PhasedActivityView2 component = phasedActivityView.GetComponent<PhasedActivityView2>();
			if (component != null)
			{
				component.enabled = false;
			}
			phasedSubView = phasedActivityView.GetComponent<HomeComePhasedActivityView>();
			if (phasedSubView == null)
			{
				phasedSubView = phasedActivityView.AddComponent<HomeComePhasedActivityView>();
			}
			phasedSubView.Init(viewModel.AddChild(new HomeComePhasedActivityViewModel(viewModel)));
		}
	}

	private void RefreshView(object sender = null, InteractionEventArgs e = null)
	{
		if (viewModel != null)
		{
			if (tabList != null)
			{
				tabList.SetListItemCount(viewModel.TabCount);
				tabList.RefreshAllShownItem();
			}
			SetViewActive(allGiftView, viewModel.SelectedTabIndex == 0);
			SetViewActive(signRewardView, viewModel.SelectedTabIndex == 1);
			SetViewActive(phasedActivityView, viewModel.SelectedTabIndex == 2);
		}
	}

	private void SetViewActive(GameObject go, bool active)
	{
		if (go != null && go.activeSelf != active)
		{
			go.SetActive(active);
		}
	}

	private LoopGridViewItem OnGetTabItemByIndex(LoopGridView gridView, int dataIndex, int row, int column)
	{
		if (viewModel == null || dataIndex < 0 || dataIndex >= viewModel.TabCount)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = gridView.NewListViewItem("TabItem");
		HomeComeTabItemView homeComeTabItemView = loopGridViewItem.GetComponent<HomeComeTabItemView>();
		if (homeComeTabItemView == null)
		{
			homeComeTabItemView = loopGridViewItem.gameObject.AddComponent<HomeComeTabItemView>();
		}
		bool selected = viewModel.SelectedTabIndex == dataIndex;
		homeComeTabItemView.Refresh(viewModel.GetTabName(dataIndex), selected, viewModel.GetTabRed(dataIndex), delegate
		{
			viewModel.SelectTab(dataIndex);
		});
		return loopGridViewItem;
	}

	protected override void OnDestroy()
	{
		viewModel?.Dispose();
		viewModel = null;
		base.OnDestroy();
	}
}
