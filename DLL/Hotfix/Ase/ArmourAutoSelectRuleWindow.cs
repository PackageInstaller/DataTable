using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine.UI;

namespace Ase;

public class ArmourAutoSelectRuleWindow : UGuiWindow
{
	public Button btnBack;

	public Button cancelBtn;

	public Button confirmBtn;

	public List<TabItemNormal> rarityBtnList;

	public TabItemNormal upLimitBtn;

	private ArmourAutoSelectRuleViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<ArmourAutoSelectRuleViewModel>();
		BindingSet<ArmourAutoSelectRuleWindow, ArmourAutoSelectRuleViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((ArmourAutoSelectRuleWindow v) => v.CloseWindow).To((ArmourAutoSelectRuleViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((ArmourAutoSelectRuleViewModel vm) => vm.Close);
		bindingSet.Bind(cancelBtn).For((Button v) => v.onClick).To((ArmourAutoSelectRuleViewModel vm) => vm.Close);
		bindingSet.Bind(confirmBtn).For((Button v) => v.onClick).To((ArmourAutoSelectRuleViewModel vm) => vm.ConfirmOnClick);
		upLimitBtn.Init(viewModel.UpLimitBtn);
		for (int num = 0; num < rarityBtnList.Count; num++)
		{
			rarityBtnList[num].Init(viewModel.TabItemNormalDataList[num]);
		}
		bindingSet.Build();
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
