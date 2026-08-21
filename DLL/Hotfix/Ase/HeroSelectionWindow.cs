#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroSelectionWindow : UGuiWindow
{
	private HeroSelectionViewModel viewModel;

	public Animator animator;

	public Button detailBtn;

	public Button funcBtn;

	public TextMeshProUGUI funcBtnText;

	public Button backBtn;

	public Transform heroParent;

	private GameObject _heroOriginalObj;

	private string originalAssetPath;

	public LoopGridView heroCardList;

	public GameObject noSelectTips;

	public HeroScreenPanel heroScreenPanel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<HeroSelectionViewModel>();
		BindingSet<HeroSelectionWindow, HeroSelectionViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((HeroSelectionWindow v) => ((UGuiWindow)v).OpenUguiWindow).To((HeroSelectionViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((HeroSelectionWindow v) => v.CloseWindow).To((HeroSelectionViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((HeroSelectionViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((HeroSelectionWindow v) => v.OnVisibleChanged).To((HeroSelectionViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(funcBtn).For((Button v) => v.onClick).To((HeroSelectionViewModel vm) => vm.OnFuncBtnClick);
		bindingSet.Bind(detailBtn).For((Button v) => v.onClick).To((HeroSelectionViewModel vm) => vm.DetailCommand);
		bindingSet.Bind(detailBtn.gameObject).For((GameObject v) => v.activeSelf).To((HeroSelectionViewModel vm) => vm.CurSelected);
		bindingSet.Bind<TextMeshProUGUI>(funcBtnText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((HeroSelectionViewModel vm) => vm.FuncBtnText);
		bindingSet.Bind(funcBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroSelectionViewModel vm) => vm.FuncBtnText != null);
		bindingSet.Bind(noSelectTips).For((GameObject v) => v.activeSelf).ToExpression((HeroSelectionViewModel vm) => !vm.CurSelected);
		bindingSet.Bind().For((HeroSelectionWindow v) => v.RefreshHeroFgimage).To((HeroSelectionViewModel vm) => vm.OnShowHeroChangedRequest);
		bindingSet.Bind().For((HeroSelectionWindow v) => v.RefreshHeroList).To((HeroSelectionViewModel vm) => vm.RefreshHeroListRst);
		bindingSet.Build();
		heroCardList.InitGridView(viewModel.ShowHeroViewModels.Count, OnGetItemByIndex);
		RefreshHeroFgimage();
		heroScreenPanel.Init(viewModel.ScreenPanelViewModel);
		GetComponent<HeroSkinChangeControl>()?.AddHeroSkinChangeAction(delegate
		{
			RefreshHeroFgimage();
		});
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

	public async void RefreshHeroFgimage(object sender = null, InteractionEventArgs e = null)
	{
		try
		{
			Clear();
			if (viewModel?.CurSelectedVM?.HeroModel.IsNullOrEmpty() ?? true)
			{
				return;
			}
			if (_heroOriginalObj != null)
			{
				UnityEngine.Object.Destroy(_heroOriginalObj);
				_heroOriginalObj = null;
			}
			originalAssetPath = viewModel.CurSelectedVM.HeroModel.Original;
			if (string.IsNullOrEmpty(originalAssetPath))
			{
				Log.Error("英雄立绘路径为空");
				return;
			}
			GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset(originalAssetPath), heroParent);
			if (gameObject == null)
			{
				Log.Error("加载英雄立绘失败" + originalAssetPath);
				return;
			}
			_heroOriginalObj = gameObject;
			UIUtilly.SpineMatchRectHelper(_heroOriginalObj, heroParent, overwrite: false);
			StreamerMode.ApplySpineSkin(gameObject);
		}
		catch (Exception ex)
		{
			Log.Error("加载资源发生异常！ " + ex.Message + " / " + ex.StackTrace);
		}
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
			RefreshHeroFgimage();
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
