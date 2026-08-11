using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopySecondType4Window : UGuiWindowBase
{
	public LoopListView2 copyTypeList;

	public LoopListView2 copyList;

	public Button btnBack;

	public Button btnShop;

	public Button btnReward;

	public Image buffIcon;

	public GameObject red;

	public TextMeshProUGUI buffDesc;

	public TextMeshProUGUI starCount;

	public TextMeshProUGUI timeLeft;

	public CopyST4RewardView st4RewardView;

	private CopySecondType4ViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<CopySecondType4ViewModel>();
		BindingSet<CopySecondType4Window, CopySecondType4ViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((CopySecondType4Window v) => v.OnDismissRequest).To((CopySecondType4ViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((CopySecondType4Window v) => v.OpenUguiWindow).To((CopySecondType4ViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((CopySecondType4Window v) => v.SetChildViewVisibility).To((CopySecondType4ViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind(this).For((CopySecondType4Window v) => v.OnOpt).To((CopySecondType4ViewModel vm) => vm.OptRequest);
		bindingSet.Bind(btnShop).For((Button v) => v.onClick).To((CopySecondType4ViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenShop");
		bindingSet.Bind(btnReward).For((Button v) => v.onClick).To((CopySecondType4ViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenReward");
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((CopySecondType4ViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(buffIcon).For((Image v) => v.sprite).To((CopySecondType4ViewModel vm) => vm.BuffIcon)
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(buffDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopySecondType4ViewModel vm) => vm.BuffDesc);
		bindingSet.Bind(red).For((GameObject v) => v.activeSelf).To((CopySecondType4ViewModel vm) => vm.Red);
		bindingSet.Bind<TextMeshProUGUI>(timeLeft).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopySecondType4ViewModel vm) => vm.TimeLeft);
		bindingSet.Bind<TextMeshProUGUI>(starCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((CopySecondType4ViewModel vm) => $"{vm.StarMax}/{vm.StarConfigMax}");
		bindingSet.Build();
		copyTypeList.InitListView(viewModel.TypeVms.Count, OnGetTypeItemItemByIndex);
		copyList.InitListView(viewModel.CopyItemVms.Count, OnGetCopyItemByIndex);
		SettleInitParam();
	}

	private async UniTaskVoid SettleInitParam()
	{
		if (viewModel != null)
		{
			await UniTask.WaitUntil(() => Visibility);
			viewModel.OnJump();
			copyList.MovePanelToItemIndex(viewModel.GetCurIndex(), 0f);
		}
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	protected override void OnShow()
	{
		base.OnShow();
	}

	private void SettleOpt(string optName)
	{
		if ("RefreshCopyList".Equals(optName))
		{
			copyList.SetListItemCount(viewModel.CopyItemVms.Count);
			copyList.RefreshAllShownItem();
			copyList.MovePanelToItemIndex(viewModel.GetCurIndex(), 0f);
		}
		else if ("RefreshCopyTypeList".Equals(optName))
		{
			copyTypeList.SetListItemCount(viewModel.TypeVms.Count);
			copyTypeList.RefreshAllShownItem();
		}
		else if ("OpenReward".Equals(optName))
		{
			st4RewardView.Init(viewModel.RewardVm);
			st4RewardView.gameObject.SetActive(value: true);
		}
	}

	private LoopListViewItem2 OnGetTypeItemItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.TypeVms.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("CopyType4ItemView");
		if (loopListViewItem != null)
		{
			CopyType4ItemView component = loopListViewItem.GetComponent<CopyType4ItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.TypeVms[index]);
			}
			else
			{
				component.RefreshData(viewModel.TypeVms[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetCopyItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.CopyItemVms.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		loopListViewItem = ((index % 2 != 0) ? listView2.NewListViewItem("CopyItemView_Right") : listView2.NewListViewItem("CopyItemView_Left"));
		if (loopListViewItem != null)
		{
			loopListViewItem.gameObject.SetActive(value: false);
			CopyItem4View component = loopListViewItem.GetComponent<CopyItem4View>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.CopyItemVms[index]);
			}
			else
			{
				component.RefreshData(viewModel.CopyItemVms[index]);
			}
			loopListViewItem.gameObject.SetActive(value: true);
		}
		return loopListViewItem;
	}
}
