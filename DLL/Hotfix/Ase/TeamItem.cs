using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TeamItem : MonoBehaviour
{
	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private TextMeshProUGUI advLevel;

	[SerializeField]
	private Button btnEntry;

	[SerializeField]
	private LoopListView2 playerList;

	public void Init(TeamItemData viewModel)
	{
		BindingSet<TeamItem, TeamItemData> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((TeamItem v) => v.RefreshPlayerList).To((TeamItemData vm) => vm.RefreshPlayerListRequest);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TeamItemData vm) => $"{vm.CopyName} · {vm.DifficultyDesc}");
		bindingSet.Bind<TextMeshProUGUI>(advLevel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TeamItemData vm) => $"传火等级 {vm.AdvLevelMin}—{vm.AdvLevelMax}");
		bindingSet.Bind(btnEntry).For((Button v) => v.onClick).To((TeamItemData vm) => vm.EntryOnClick);
		bindingSet.Bind(btnEntry).For((Button v) => v.interactable).ToExpression((TeamItemData vm) => vm.PlayerCount > 0 && vm.PlayerCount < 3);
		bindingSet.Build();
		playerList.InitListView(viewModel.PlayerList.Count, OnGetPlayerItemByIndex);
	}

	private LoopListViewItem2 OnGetPlayerItemByIndex(LoopListView2 listView, int index)
	{
		if (index < 0 || index >= ((TeamItemData)this.GetDataContext()).PlayerList.Count)
		{
			return null;
		}
		TeamPlayerItemData viewModel = ((TeamItemData)this.GetDataContext()).PlayerList[index];
		LoopListViewItem2 loopListViewItem = listView.NewListViewItem("TeamPlayerItem");
		TeamPlayerItem component = loopListViewItem.GetComponent<TeamPlayerItem>();
		if (!loopListViewItem.IsInitHandlerCalled)
		{
			loopListViewItem.IsInitHandlerCalled = true;
			component.Init(viewModel);
		}
		else
		{
			component.RefreshData(viewModel);
		}
		return loopListViewItem;
	}

	private void RefreshPlayerList(object sender, InteractionEventArgs e)
	{
		playerList.SetListItemCount(((TeamItemData)this.GetDataContext()).PlayerList.Count);
		playerList.RefreshAllShownItem();
	}

	public void RefreshData(TeamItemData itemData)
	{
		this.SetDataContext(itemData);
		itemData.RefreshPlayerList();
	}
}
