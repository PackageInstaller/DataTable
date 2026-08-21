using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleStatisticWindow : UGuiWindow
{
	[SerializeField]
	private LoopListView2 heroList;

	[SerializeField]
	private BattleStatDetailView detailView;

	[SerializeField]
	private Button btnBack;

	private BattleStatisticViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BattleStatisticViewModel>();
		BindingSet<BattleStatisticWindow, BattleStatisticViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((BattleStatisticViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((BattleStatisticWindow v) => v.OnDismissRequest).To((BattleStatisticViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((BattleStatisticWindow v) => v.OnOpt).To((BattleStatisticViewModel vm) => vm.OptRequest);
		bindingSet.Build();
		heroList.InitListView(viewModel.BSHeroItemVMs.Count, OnGetHeroItemByIndex);
		detailView.gameObject.SetActive(value: false);
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("OpenDetail".Equals(optName))
		{
			detailView.Init(viewModel.DetailViewModel);
			detailView.gameObject.SetActive(value: true);
			heroList.gameObject.SetActive(value: false);
		}
		else if ("CloseDetail".Equals(optName))
		{
			detailView.gameObject.SetActive(value: false);
			heroList.gameObject.SetActive(value: true);
		}
	}

	private LoopListViewItem2 OnGetHeroItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.BSHeroItemVMs.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("BSHeroItemView");
		if (loopListViewItem != null)
		{
			BSHeroItemView component = loopListViewItem.GetComponent<BSHeroItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.BSHeroItemVMs[index]);
			}
			else
			{
				component.RefreshData(viewModel.BSHeroItemVMs[index]);
			}
		}
		return loopListViewItem;
	}
}
