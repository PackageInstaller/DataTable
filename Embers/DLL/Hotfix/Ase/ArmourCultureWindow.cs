using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourCultureWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private GameObject armourShowObj;

	[SerializeField]
	private TabItemNormal armourDetailTab;

	[SerializeField]
	private TabItemNormal armourUpgradeTab;

	[SerializeField]
	private TabItemNormal armourAffixRefreshTab;

	[SerializeField]
	private TabItemNormal armourEntryResetTab;

	[SerializeField]
	private ArmourShowView armourShowView;

	[SerializeField]
	private ArmourPopupView armourPopupView;

	[SerializeField]
	private ArmourUpgradeView armourUpgradeView;

	[SerializeField]
	private ArmourAffixRefreshView armourAffixRefreshView;

	[SerializeField]
	private ArmourEntryResetView armourEntryResetView;

	[SerializeField]
	private GameObject windowMask;

	[SerializeField]
	private EntryInfoView entryInfoView;

	[SerializeField]
	private Vector2 popupEntryPos;

	[SerializeField]
	private Vector2 resetEntryPos;

	[SerializeField]
	private MoneyView moneyView;

	private ArmourCultureViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ArmourCultureViewModel>();
		BindingSet<ArmourCultureWindow, ArmourCultureViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((ArmourCultureViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((ArmourCultureWindow v) => v.OpenUguiWindow).To((ArmourCultureViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(armourShowObj).For((GameObject v) => v.activeSelf).To((ArmourCultureViewModel vm) => vm.IsShowArmourObj);
		bindingSet.Bind(this).For((ArmourCultureWindow v) => v.CloseWindow).To((ArmourCultureViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((ArmourCultureWindow v) => v.ShowEntryDetail).To((ArmourCultureViewModel vm) => vm.ShowEntryDetailRequest);
		bindingSet.Bind(this).For((ArmourCultureWindow v) => v.RefreshArmourShow).To((ArmourCultureViewModel vm) => vm.RefreshArmourShowRequest);
		bindingSet.Bind(this).For((ArmourCultureWindow v) => v.RefreshMoneyShow).To((ArmourCultureViewModel vm) => vm.RefreshMoneyViewRequest);
		bindingSet.Bind(windowMask).For((GameObject v) => v.activeSelf).ToExpression((ArmourCultureViewModel vm) => vm.WindowMaskLeftTime > 0f);
		bindingSet.Build();
		InitTab();
		armourShowView.SetArmourData(viewModel.ArmourData);
		armourPopupView.Init(viewModel.ArmourPopupViewModel);
		armourUpgradeView.Init(viewModel.ArmourUpgradeViewModel);
		armourAffixRefreshView.Init(viewModel.ArmourAffixRefreshViewModel);
		armourEntryResetView.Init(viewModel.ArmourEntryResetViewModel);
		moneyView.Init(new MoneyViewModel(viewModel));
		entryInfoView.Init();
		RefreshMoneyShow();
	}

	private void InitTab()
	{
		armourDetailTab.Init(viewModel.ArmourDetailBtn);
		armourUpgradeTab.Init(viewModel.ArmourUpgradeBtn);
		armourAffixRefreshTab.Init(viewModel.ArmourAffixRefreshBtn);
		armourEntryResetTab.Init(viewModel.ArmourEntryResetBtn);
	}

	private void ShowEntryDetail(object sender, InteractionEventArgs e)
	{
		EntryItemData entryItemData = (EntryItemData)e.Context;
		Vector2 position = ((entryItemData.Type == 1) ? popupEntryPos : resetEntryPos);
		entryInfoView.SetPosition(position);
		entryInfoView.Show(entryItemData);
	}

	private void RefreshArmourShow(object sender, InteractionEventArgs e)
	{
		armourShowView.SetArmourData(viewModel.ArmourData);
	}

	private void RefreshMoneyShow(object sender = null, InteractionEventArgs e = null)
	{
		moneyView.HideAll();
		if (viewModel.ArmourUpgradeBtn.IsSelected || viewModel.ArmourEntryResetBtn.IsSelected)
		{
			moneyView.SetShow(RoleMoneyEnum.Coin);
		}
		armourUpgradeView.CloseScreen();
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		armourShowView.ClearObj();
		armourUpgradeView.ClearObj();
		Dismiss();
	}

	private void Update()
	{
		if (viewModel != null && !(viewModel.WindowMaskLeftTime <= 0f))
		{
			viewModel.WindowMaskLeftTime -= Time.deltaTime;
		}
	}
}
