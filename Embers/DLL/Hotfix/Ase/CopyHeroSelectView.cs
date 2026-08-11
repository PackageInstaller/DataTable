using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyHeroSelectView : UGuiView
{
	public Button btnConfig;

	public Button btnPrefig;

	public GameObject prefigSelRoot;

	public GameObject configSelRoot;

	public LoopGridView heroItemList;

	public LoopListView2 prefigList;

	public string aniName;

	public Animator animator;

	private bool isSelectConfig;

	private CopyHeroSelectViewModel viewModel;

	public CopyHeroSelectViewModel ViewModel
	{
		get
		{
			return viewModel;
		}
		set
		{
			if (viewModel == null)
			{
				OnInit(value);
			}
			else
			{
				RefreshData(value);
			}
		}
	}

	public bool IsSelectConfig
	{
		get
		{
			return isSelectConfig;
		}
		set
		{
			bool num = !value && value != isSelectConfig;
			isSelectConfig = value;
			if (num)
			{
				animator.Play(aniName, 0, 0f);
			}
		}
	}

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<CopyHeroSelectViewModel>(userData);
		BindingSet<CopyHeroSelectView, CopyHeroSelectViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnConfig).For((Button v) => v.onClick).To((CopyHeroSelectViewModel vm) => vm.OptCommand)
			.CommandParameter("Config");
		bindingSet.Bind(btnPrefig).For((Button v) => v.onClick).To((CopyHeroSelectViewModel vm) => vm.OptCommand)
			.CommandParameter("Prefig");
		bindingSet.Bind(this).For((CopyHeroSelectView v) => v.IsSelectConfig).ToExpression((CopyHeroSelectViewModel vm) => vm.IsSelectConfig);
		bindingSet.Bind(prefigSelRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyHeroSelectViewModel vm) => !vm.IsSelectConfig);
		bindingSet.Bind(configSelRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyHeroSelectViewModel vm) => vm.IsSelectConfig);
		bindingSet.Bind(prefigList.gameObject).For((GameObject v) => v.activeSelf).ToExpression((CopyHeroSelectViewModel vm) => !vm.IsSelectConfig);
		bindingSet.Bind(heroItemList.gameObject).For((GameObject v) => v.activeSelf).ToExpression((CopyHeroSelectViewModel vm) => vm.IsSelectConfig);
		bindingSet.Bind(this).For((CopyHeroSelectView v) => v.OnOpt).To((CopyHeroSelectViewModel vm) => vm.OptRequest);
		bindingSet.Build();
		heroItemList.InitGridView(viewModel.HeroItemViewModels.Count, OnGetItemByIndex);
		prefigList.InitListView(viewModel.TeamItemList.Count, OnGetTeamItemByIndex);
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyHeroSelectViewModel>(userData);
		this.SetDataContext(viewModel);
		heroItemList.MovePanelToItemByIndex(0);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (viewModel != null && heroItemList.MListViewInited)
		{
			SettleOpt("RefreshHeroList");
		}
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("RefreshHeroList".Equals(optName))
		{
			heroItemList.SetListItemCount(viewModel.HeroItemViewModels.Count);
			heroItemList.RefreshAllShownItem();
		}
	}

	public LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int itemIndex, int row, int column)
	{
		if (itemIndex < 0 || itemIndex > viewModel.HeroItemViewModels.Count)
		{
			return null;
		}
		CopyHeroItemViewModel copyHeroItemViewModel = viewModel.HeroItemViewModels[itemIndex];
		if (copyHeroItemViewModel == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = arg1.NewListViewItem("HeroItem");
		CopyHeroItem component = loopGridViewItem.GetComponent<CopyHeroItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(copyHeroItemViewModel);
		}
		else
		{
			component.RefreshData(copyHeroItemViewModel);
		}
		return loopGridViewItem;
	}

	private LoopListViewItem2 OnGetTeamItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TeamItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("TeamItem");
		if (loopListViewItem != null)
		{
			CopyTeamView component = loopListViewItem.GetComponent<CopyTeamView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TeamItemList[index]);
			}
			else
			{
				component.RefreshData(viewModel.TeamItemList[index]);
			}
		}
		return loopListViewItem;
	}
}
