using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroSelection2Window : UGuiWindow
{
	private HeroSelectionViewModel viewModel;

	public Animator animator;

	public Button detailBtn;

	public Button funcBtn;

	public TextMeshProUGUI funcBtnText;

	public Button backBtn;

	private GameObject _heroOriginalObj;

	private string originalAssetPath;

	public LoopGridView heroCardList;

	public HeroScreenPanel heroScreenPanel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<HeroSelectionViewModel>();
		BindingSet<HeroSelection2Window, HeroSelectionViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HeroSelection2Window v) => ((UGuiWindow)v).OpenUguiWindow).To((HeroSelectionViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((HeroSelection2Window v) => v.CloseWindow).To((HeroSelectionViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((HeroSelectionViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((HeroSelection2Window v) => v.OnVisibleChanged).To((HeroSelectionViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(funcBtn).For((Button v) => v.onClick).To((HeroSelectionViewModel vm) => vm.OnFuncBtnClick);
		bindingSet.Bind(detailBtn).For((Button v) => v.onClick).To((HeroSelectionViewModel vm) => vm.DetailCommand);
		bindingSet.Bind(detailBtn.gameObject).For((GameObject v) => v.activeSelf).To((HeroSelectionViewModel vm) => vm.CurSelected);
		bindingSet.Bind<TextMeshProUGUI>(funcBtnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSelectionViewModel vm) => vm.FuncBtnText);
		bindingSet.Bind(funcBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroSelectionViewModel vm) => vm.FuncBtnText != null);
		bindingSet.Bind().For((HeroSelection2Window v) => v.RefreshHeroList).To((HeroSelectionViewModel vm) => vm.RefreshHeroListRst);
		bindingSet.Build();
		heroCardList.InitGridView(viewModel.ShowHeroViewModels.Count, OnGetItemByIndex);
		heroScreenPanel.Init(viewModel.ScreenPanelViewModel);
	}

	private void RefreshHeroList(object sender, InteractionEventArgs e)
	{
		heroCardList.SetListItemCount(viewModel.ShowHeroViewModels.Count);
		heroCardList.RefreshAllShownItem();
	}

	private LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int itemIndex, int row, int column)
	{
		if (itemIndex < 0 || itemIndex > viewModel.ShowHeroViewModels.Count)
		{
			return null;
		}
		HeroItemViewModel heroItemViewModel = viewModel.ShowHeroViewModels[itemIndex];
		if (heroItemViewModel == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = arg1.NewListViewItem("HeroSelectionItem");
		HeroSelectionItem component = loopGridViewItem.GetComponent<HeroSelectionItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(heroItemViewModel);
		}
		else
		{
			component.RefreshData(heroItemViewModel);
		}
		return loopGridViewItem;
	}

	protected override void OpenUguiWindow(object sender, InteractionEventArgs args)
	{
		if ((UnityEngine.Object)(object)animator != null)
		{
			animator.SetTrigger("openWindow");
		}
		InteractionEventArgs args2 = new InteractionEventArgs(args.Context, delegate
		{
			if ((UnityEngine.Object)(object)animator != null)
			{
				animator.SetTrigger("closeWindow");
			}
			args.Callback?.Invoke();
		});
		base.OpenUguiWindow(sender, args2);
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Clear();
		Dismiss();
	}

	private void Clear()
	{
		if (_heroOriginalObj != null)
		{
			UnityEngine.Object.DestroyImmediate(_heroOriginalObj);
			_heroOriginalObj = null;
		}
	}
}
