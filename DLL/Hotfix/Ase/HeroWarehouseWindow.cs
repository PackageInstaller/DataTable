using System.Collections.Generic;
using GameFramework.Runtime;
using SuperScrollView;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HeroWarehouseWindow : UGuiWindow
{
	[SerializeField]
	private float paddingTop;

	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private LoopGridView heroItemList;

	[SerializeField]
	private HeroScreenPanel heroScreenPanel;

	[SerializeField]
	private Animator _animator;

	private HeroWarehouseViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<HeroWarehouseViewModel>();
		BindingSet<HeroWarehouseWindow, HeroWarehouseViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((HeroWarehouseWindow v) => v.OnDismissRequest).To((HeroWarehouseViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((HeroWarehouseViewModel vm) => vm.Close);
		bindingSet.Bind().For((HeroWarehouseWindow v) => v.RefreshHeroModels).To((HeroWarehouseViewModel vm) => vm.RefreshHeroListRst);
		bindingSet.Bind().For((HeroWarehouseWindow v) => v.PlayHeroCultivateAnimator).To((HeroWarehouseViewModel vm) => vm.PlayAnimatorRequest);
		bindingSet.Build();
		heroScreenPanel.Init(_viewModel.ScreenPanelViewModel);
		heroItemList.InitGridView(_viewModel.HeroItemViewModels.Count, OnGetItemByIndex);
	}

	private void RefreshHeroModels(object sender, InteractionEventArgs e)
	{
		heroItemList.SetListItemCount(_viewModel.HeroItemViewModels.Count);
		heroItemList.RefreshAllShownItem();
		heroItemList.MovePanelToItemByIndex(0, 0f, 0f - paddingTop);
	}

	private void PlayHeroCultivateAnimator(object sender, InteractionEventArgs e)
	{
		_animator.SetTrigger(Animator.StringToHash("out"));
	}

	public LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int itemIndex, int row, int column)
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
		HeroItem heroItem = loopGridViewItem.GetComponent<HeroItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			heroItem.Init(heroItemViewModel);
			heroItem.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.HeroDestinyEnabled).SetFuncOnMessage((RedPointMessage message) => ((RedPointService)Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()).HeroSeats.Exists((DRHeroSeat p) => p.HeroId.Equals(heroItem.ViewModel.HeroModel.Id)))
				.Invoke();
		}
		else
		{
			heroItem.RefreshData(heroItemViewModel);
			heroItem.GetComponent<UIRedPoint>()?.Invoke();
		}
		if (heroItemViewModel.HeroModel.Id == 1104)
		{
			Singleton<GuidanceManager>.Instance.RegisterGuidanceUIs(Name, new List<GuidanceManager.GuidanceUIConfig>
			{
				new GuidanceManager.GuidanceUIConfig
				{
					uiKey = "1104",
					targetUI = loopGridViewItem.GetComponent<RectTransform>()
				}
			});
		}
		return loopGridViewItem;
	}
}
