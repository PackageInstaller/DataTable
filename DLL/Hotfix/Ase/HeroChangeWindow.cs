using GameFramework.Runtime;
using Spine.Unity;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroChangeWindow : UGuiWindow
{
	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private Button confirmBtn;

	[SerializeField]
	private Button openCultureBtn;

	[SerializeField]
	private Transform heroImgPos;

	private GameObject heroImg;

	[SerializeField]
	private LoopGridView heroItemList;

	[SerializeField]
	private HeroScreenPanel heroScreenPanel;

	private HeroChangeViewModel _viewModel;

	private string curSpinePath;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<HeroChangeViewModel>();
		BindingSet<HeroChangeWindow, HeroChangeViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((HeroChangeViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((HeroChangeWindow v) => v.CloseWindow).To((HeroChangeViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(confirmBtn).For((Button v) => v.onClick).To((HeroChangeViewModel vm) => vm.ConfirmCmd);
		bindingSet.Bind(openCultureBtn).For((Button v) => v.onClick).To((HeroChangeViewModel vm) => vm.OpenCultureCmd);
		bindingSet.Bind(openCultureBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((HeroChangeViewModel vm) => !vm.IsLevelFix);
		bindingSet.Bind().For((HeroChangeWindow v) => v.RefreshHeroModels).To((HeroChangeViewModel vm) => vm.RefreshSortRequest);
		bindingSet.Bind().For((HeroChangeWindow v) => v.LoadHeroObj).To((HeroChangeViewModel vm) => vm.RefreshSelectionRequest);
		bindingSet.Bind().For((HeroChangeWindow v) => v.OpenUguiWindow).To((HeroChangeViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Build();
		heroScreenPanel.Init(_viewModel.ScreenPanelViewModel);
		heroItemList.InitGridView(_viewModel.HeroItemViewModels.Count, OnGetItemByIndex);
		LoadHeroObj();
		GetComponent<HeroSkinChangeControl>()?.AddHeroSkinChangeAction(delegate(int heroId)
		{
			if ((_viewModel.SelectedHero?.HeroModel?.Id).GetValueOrDefault() == heroId)
			{
				LoadHeroObj();
			}
		});
	}

	private void RefreshHeroModels(object sender, InteractionEventArgs e)
	{
		heroItemList.SetListItemCount(_viewModel.HeroItemViewModels.Count);
		heroItemList.RefreshAllShownItem();
	}

	private void LoadHeroObj(object sender = null, InteractionEventArgs e = null)
	{
		if (heroImg != null)
		{
			Object.Destroy(heroImg);
			heroImg = null;
		}
		SetHeroImg();
	}

	private async void SetHeroImg()
	{
		curSpinePath = AssetUtility.GetUIItemAsset(_viewModel.SelectedHero?.HeroModel?.Original);
		if (curSpinePath.Equals(""))
		{
			return;
		}
		GameObject gameObject = await InstantiateAsync(curSpinePath, heroImgPos);
		if (gameObject != null)
		{
			heroImg = gameObject;
			UIUtilly.SpineMatchRectHelper(heroImg, heroImgPos, overwrite: false);
			SkeletonGraphic val = heroImg.transform.GetChild(0)?.GetComponent<SkeletonGraphic>();
			if ((Object)(object)val != null)
			{
				((Graphic)(object)val).raycastTarget = false;
			}
			StreamerMode.ApplySpineSkin(gameObject);
		}
	}

	private LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int itemIndex, int row, int column)
	{
		if (itemIndex < 0 || itemIndex > _viewModel.HeroItemViewModels.Count)
		{
			return null;
		}
		HeroItemViewModel heroItemViewModel = _viewModel.HeroItemViewModels[itemIndex];
		if (heroItemViewModel == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = arg1.NewListViewItem("HeroItem");
		HeroItem component = loopGridViewItem.GetComponent<HeroItem>();
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

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		if (heroImg != null)
		{
			Object.Destroy(heroImg);
		}
		Dismiss();
	}
}
