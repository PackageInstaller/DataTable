using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine.UI;

namespace Ase;

public class BattleStatDetailView : UGuiView
{
	public TextMeshProUGUI heroName;

	public Button btnPro;

	public Text playerName;

	public LoopListView2 heroList;

	public LoopListView2 skillStatList;

	private BattleStatDetailViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<BattleStatDetailViewModel>(userData);
		BindingSet<BattleStatDetailView, BattleStatDetailViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnPro).For((Button v) => v.onClick).To((BattleStatDetailViewModel vm) => vm.OnPro);
		bindingSet.Bind(this).For((BattleStatDetailView v) => v.OnOpt).To((BattleStatDetailViewModel vm) => vm.OptRequest);
		bindingSet.Bind<TextMeshProUGUI>(heroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BattleStatDetailViewModel vm) => vm.Name);
		bindingSet.Bind(playerName).For((Text v) => v.text).ToExpression((BattleStatDetailViewModel vm) => vm.ShowHeroName ? $"<{vm.PlayerName}>" : "");
		bindingSet.Build();
		heroList.InitListView(viewModel.TeamItemList.Count, OnGetTeamItemByIndex);
		skillStatList.InitListView(viewModel.SkillList.Count, OnGetSkillItemByIndex);
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<BattleStatDetailViewModel>(userData);
		this.SetDataContext(viewModel);
		RefreshSkillList();
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("RefreshHeroSelect".Equals(optName))
		{
			RefreshHeroSelect();
		}
		else if ("RefreshSkillList".Equals(optName))
		{
			RefreshSkillList();
		}
	}

	private void RefreshSkillList()
	{
		skillStatList.SetListItemCount(viewModel.SkillList.Count, resetPos: false);
		skillStatList.RefreshAllShownItem();
	}

	private void RefreshHeroSelect()
	{
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
			CopyTeamItemView component = loopListViewItem.GetComponent<CopyTeamItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TeamItemList[index]);
			}
			else
			{
				component.RefreshData(viewModel.TeamItemList[index]);
			}
			component.CurIndex = index;
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetSkillItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.SkillList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		loopListViewItem = index switch
		{
			0 => listView2.NewListViewItem("TotalItem"), 
			1 => listView2.NewListViewItem("SkillTitleItem"), 
			_ => (!viewModel.SkillList[index].IsOther) ? ((!viewModel.SkillList[index].Data.IsTotalItem) ? listView2.NewListViewItem("SkillSmallItem") : listView2.NewListViewItem("SkillItem")) : listView2.NewListViewItem("SkillItemOther"), 
		};
		if (loopListViewItem != null)
		{
			BattleStatSkillItemView component = loopListViewItem.GetComponent<BattleStatSkillItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.SkillList[index]);
			}
			else
			{
				component.RefreshData(viewModel.SkillList[index]);
			}
		}
		return loopListViewItem;
	}
}
