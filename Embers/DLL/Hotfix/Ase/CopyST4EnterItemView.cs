using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyST4EnterItemView : UGuiView
{
	public TeamBPConfigView teamBpConfigView;

	public Transform teamRoot;

	public LoopListView2 heroList;

	public TextMeshProUGUI bossName;

	public LoadUISprite bossImg;

	public LoopListView2 attributeList;

	public LoopListView2 conditionList;

	public GameObject cantConfig;

	public GameObject configging;

	public GameObject accessRoot;

	public GameObject notAccessRoot;

	public Button btnEnter;

	public Button btnStartNew;

	private CopyST4EnterItemViewModel viewModel;

	private Transform highlightRoot;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<CopyST4EnterItemViewModel>(userData);
		BindingSet<CopyST4EnterItemView, CopyST4EnterItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(bossImg).For((LoadUISprite v) => v.Path).ToExpression((CopyST4EnterItemViewModel vm) => $"{vm.Data.BossIconPath}/{vm.BossIcon}");
		bindingSet.Bind<TextMeshProUGUI>(bossName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyST4EnterItemViewModel vm) => vm.BossName);
		bindingSet.Bind(this).For((CopyST4EnterItemView v) => v.OnOpt).To((CopyST4EnterItemViewModel vm) => vm.OptRequest);
		bindingSet.Bind(btnEnter).For((Button v) => v.onClick).To((CopyST4EnterItemViewModel vm) => vm.OptCommand)
			.CommandParameter("EnterCopy");
		bindingSet.Bind(btnStartNew).For((Button v) => v.onClick).To((CopyST4EnterItemViewModel vm) => vm.OptCommand)
			.CommandParameter("EnterCopy");
		bindingSet.Bind(cantConfig).For((GameObject v) => v.activeSelf).ToExpression((CopyST4EnterItemViewModel vm) => (int)vm.CopyStage == 3);
		bindingSet.Bind(configging).For((GameObject v) => v.activeSelf).To((CopyST4EnterItemViewModel vm) => vm.IsConfigging);
		bindingSet.Bind(accessRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyST4EnterItemViewModel vm) => vm.Data.IsAccessed && (int)vm.CopyStage == 3);
		bindingSet.Bind(notAccessRoot).For((GameObject v) => v.activeSelf).ToExpression((CopyST4EnterItemViewModel vm) => !vm.Data.IsAccessed && (int)vm.CopyStage == 3);
		bindingSet.Build();
		attributeList.InitListView(viewModel.AdItemList.Count, OnGetAttributeItemByIndex);
		conditionList.InitListView(viewModel.ConditionItems.Count, OnGetConditionItemByIndex);
		heroList.InitListView(viewModel.TeamItemList.Count, OnGetTeamItemByIndex);
		teamBpConfigView.Init(viewModel.BpConfigViewModel);
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyST4EnterItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}

	private LoopListViewItem2 OnGetAttributeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.AdItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AttriItem");
		if (loopListViewItem != null)
		{
			LoadUISprite component = loopListViewItem.GetComponent<LoadUISprite>();
			Button component2 = loopListViewItem.GetComponent<Button>();
			component2.onClick.RemoveAllListeners();
			component2.onClick.AddListener(viewModel.OnBuffClick);
			component.Path = $"ItemIcons/Copy/CopyBuff/boss_property_{viewModel.AdItemList[index]}";
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetConditionItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ConditionItems.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("StarConditionItemView");
		if (loopListViewItem != null)
		{
			StarConditionItemView component = loopListViewItem.GetComponent<StarConditionItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ConditionItems[index]);
			}
			else
			{
				component.RefreshData(viewModel.ConditionItems[index]);
			}
		}
		return loopListViewItem;
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

	public void SetTeamListHighlightRoot(Transform root)
	{
		highlightRoot = root;
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("HighlightTeam".Equals(optName))
		{
			configging.transform.SetParent(highlightRoot);
			heroList.transform.SetParent(highlightRoot);
		}
		else if ("ResetTeam".Equals(optName))
		{
			configging.transform.SetParent(teamRoot);
			heroList.transform.SetParent(teamRoot);
		}
	}
}
