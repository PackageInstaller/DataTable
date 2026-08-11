using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GuildRankPopupWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private LoopListView2 loopListView2;

	private GuildRankPopupViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<GuildRankPopupViewModel>();
		BindingSet<GuildRankPopupWindow, GuildRankPopupViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((GuildRankPopupWindow v) => v.OnDismissRequest).To((GuildRankPopupViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((GuildRankPopupWindow v) => v.OpenUguiWindow).To((GuildRankPopupViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GuildRankPopupViewModel vm) => vm.Close);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((GuildRankPopupViewModel vm) => vm.Close);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GuildRankPopupViewModel vm) => vm.Title);
		bindingSet.Bind().For((GuildRankPopupWindow v) => v.Refresh).To((GuildRankPopupViewModel vm) => vm.RefreshRequest);
		bindingSet.Build();
		loopListView2.InitListView(_viewModel.RankDatas.Count, OnGetItemByIndex);
	}

	private void Refresh(object sender, InteractionEventArgs e)
	{
		loopListView2.SetListItemCount(_viewModel.RankDatas.Count);
		loopListView2.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= _viewModel.RankDatas.Count)
		{
			return null;
		}
		RankItemData rankItemData = _viewModel.RankDatas[index];
		LoopListViewItem2 loopListViewItem = loopListView2.NewListViewItem("RankItem");
		RankItem component = loopListViewItem.GetComponent<RankItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(rankItemData);
		}
		else
		{
			component.RefreshData(rankItemData);
		}
		return loopListViewItem;
	}
}
