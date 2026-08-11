using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GameScoreWindow : UGuiWindowBase
{
	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private Button closeBtn;

	[SerializeField]
	private Button closeBtn2;

	[SerializeField]
	private TextMeshProUGUI closeBtnText;

	[SerializeField]
	private GameObject score;

	[SerializeField]
	private GameObject iosObj;

	[SerializeField]
	private GameObject taptapObj;

	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private TextMeshProUGUI content;

	[SerializeField]
	private Button encourageBtn;

	[SerializeField]
	private Button evaluateBtn;

	[SerializeField]
	private TextMeshProUGUI evaluateBtnText;

	[SerializeField]
	private GameObject thankObj;

	[SerializeField]
	private LoopListView2 starList;

	private GameScoreViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<GameScoreViewModel>();
		BindingSet<GameScoreWindow, GameScoreViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((GameScoreWindow v) => v.CloseWindow).To((GameScoreViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(closeBtn).For((Button v) => v.onClick).To((GameScoreViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(closeBtn2).For((Button v) => v.onClick).To((GameScoreViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((GameScoreViewModel vm) => vm.BtnCancel);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameScoreViewModel vm) => vm.Title);
		bindingSet.Bind<TextMeshProUGUI>(content).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameScoreViewModel vm) => vm.Content);
		bindingSet.Bind(encourageBtn).For((Button v) => v.onClick).To((GameScoreViewModel vm) => vm.RantCmd);
		bindingSet.Bind(evaluateBtn).For((Button v) => v.onClick).To((GameScoreViewModel vm) => vm.EvaluateCmd);
		bindingSet.Bind(thankObj).For((GameObject v) => v.activeSelf).To((GameScoreViewModel vm) => vm.ShowThank);
		bindingSet.Bind<TextMeshProUGUI>(closeBtnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameScoreViewModel vm) => vm.CancelText);
		bindingSet.Bind<TextMeshProUGUI>(evaluateBtnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameScoreViewModel vm) => vm.ConfirmText);
		bindingSet.Bind(iosObj).For((GameObject v) => v.activeSelf).To((GameScoreViewModel vm) => vm.IsIos);
		bindingSet.Bind(taptapObj).For((GameObject v) => v.activeSelf).ToExpression((GameScoreViewModel vm) => !vm.IsIos);
		bindingSet.Bind(score).For((GameObject v) => v.activeSelf).ToExpression((GameScoreViewModel vm) => !vm.ShowThank);
		bindingSet.Build();
		starList.InitListView(viewModel.StarList.Count, OnGetStarItemByIndex);
	}

	private LoopListViewItem2 OnGetStarItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.StarList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("StarItem");
		if (loopListViewItem != null)
		{
			TabItemNormal component = loopListViewItem.GetComponent<TabItemNormal>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.StarList[index]);
			}
			else
			{
				component.RefreshData(viewModel.StarList[index]);
			}
		}
		return loopListViewItem;
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
