using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class BattleMenuWindow : UGuiWindow
{
	[SerializeField]
	private Button outsideButton;

	[SerializeField]
	private Button continueButton;

	[SerializeField]
	private Button settingButton;

	[SerializeField]
	private Button quitButton;

	[SerializeField]
	private Button safeButton;

	[SerializeField]
	private GameObject safeBtnGo;

	private BattleMenuViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<BattleMenuViewModel>();
		BindingSet<BattleMenuWindow, BattleMenuViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((BattleMenuWindow v) => v.OnDismissRequest).To((BattleMenuViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((BattleMenuWindow v) => v.OpenUguiWindow).To((BattleMenuViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(continueButton).For((Button v) => v.onClick).To((BattleMenuViewModel vm) => vm.OnContinueBtnClick);
		bindingSet.Bind(settingButton).For((Button v) => v.onClick).To((BattleMenuViewModel vm) => vm.OnSetBtnClick);
		bindingSet.Bind(quitButton).For((Button v) => v.onClick).To((BattleMenuViewModel vm) => vm.OnQuitBtnClick);
		bindingSet.Bind(safeButton).For((Button v) => v.onClick).To((BattleMenuViewModel vm) => vm.OnSafeBtnClick);
		bindingSet.Bind(safeBtnGo).For((GameObject v) => v.activeSelf).To((BattleMenuViewModel vm) => vm.IsInCaves);
		bindingSet.Build();
	}

	protected override void OnShow()
	{
		base.OnShow();
		if (viewModel.BattleWorldMode != BattleWorldMode.SyncBattle)
		{
			viewModel.GamePause();
		}
	}
}
