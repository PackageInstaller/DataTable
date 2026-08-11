using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildRankWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private TabItem tabActivePoint;

	[SerializeField]
	private LoopListView2 scrollList;

	[SerializeField]
	private GuildRankItem myRankItem;

	private GuildRankViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<GuildRankViewModel>();
		BindingSet<GuildRankWindow, GuildRankViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((GuildRankWindow v) => v.OnDismissRequest).To((GuildRankViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((GuildRankWindow v) => v.OpenUguiWindow).To((GuildRankViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GuildRankViewModel vm) => vm.Close);
		bindingSet.Bind().For((GuildRankWindow v) => v.OnTabClick).To((GuildRankViewModel vm) => vm.OnTabClickRst);
		bindingSet.Build();
		myRankItem.Init(_viewModel.MyGuildRankData);
		scrollList.InitListView(_viewModel.RankDatas.Count, OnGetItemByIndex);
		tabActivePoint.Init(new TabItemData(_viewModel, 1));
		if (_viewModel.CurTabIndex == 1)
		{
			_viewModel.SetTabSelected(tabActivePoint.ViewModel, requestData: false);
		}
	}

	private void OnTabClick(object sender, InteractionEventArgs e)
	{
		scrollList.SetListItemCount(_viewModel.RankDatas.Count);
		scrollList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.RankDatas.Count)
		{
			return null;
		}
		KeyValuePair<int, GuildData> keyValuePair = _viewModel.RankDatas[index];
		LoopListViewItem2 loopListViewItem = scrollList.NewListViewItem("GuildRankItem");
		GuildRankItemData guildRankItemData = new GuildRankItemData(_viewModel, keyValuePair.Value, keyValuePair.Key, clickEnable: false);
		GuildRankItem component = loopListViewItem.GetComponent<GuildRankItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(guildRankItemData);
		}
		else
		{
			component.RefreshData(guildRankItemData);
		}
		return loopListViewItem;
	}
}
