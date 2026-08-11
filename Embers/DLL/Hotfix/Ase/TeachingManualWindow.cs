using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TeachingManualWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private TabItem allTab;

	[SerializeField]
	private TabItem combatTab;

	[SerializeField]
	private TabItem levelTab;

	[SerializeField]
	private TabItem systemTab;

	[SerializeField]
	private TeachingManualView view;

	private TeachingManualWindowViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<TeachingManualWindowViewModel>();
		BindingSet<TeachingManualWindow, TeachingManualWindowViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((TeachingManualWindow v) => v.OnDismissRequest).To((TeachingManualWindowViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((TeachingManualWindow v) => v.OpenUguiWindow).To((TeachingManualWindowViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((TeachingManualWindowViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Build();
		Init();
	}

	private void Init()
	{
		view.Init(_viewModel.ViewData);
		allTab.Init(new TabItemData(_viewModel, 0));
		combatTab.Init(new TabItemData(_viewModel, 1));
		levelTab.Init(new TabItemData(_viewModel, 2));
		systemTab.Init(new TabItemData(_viewModel, 3));
		allTab.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.TeachingManualUpdate).SetFuncOnMessage((RedPointMessage message) => TeachingDefinition.GetManualTypeRedState(TeachingDefinition.TeachingType.All))
			.Invoke();
		combatTab.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.TeachingManualUpdate).SetFuncOnMessage((RedPointMessage message) => TeachingDefinition.GetManualTypeRedState(TeachingDefinition.TeachingType.Combat))
			.Invoke();
		levelTab.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.TeachingManualUpdate).SetFuncOnMessage((RedPointMessage message) => TeachingDefinition.GetManualTypeRedState(TeachingDefinition.TeachingType.Level))
			.Invoke();
		systemTab.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.TeachingManualUpdate).SetFuncOnMessage((RedPointMessage message) => TeachingDefinition.GetManualTypeRedState(TeachingDefinition.TeachingType.System))
			.Invoke();
		if (_viewModel.CurTabIndex == TeachingDefinition.TeachingType.All)
		{
			allTab.ViewModel.TabOnClick();
		}
		else if (_viewModel.CurTabIndex == TeachingDefinition.TeachingType.Combat)
		{
			combatTab.ViewModel.TabOnClick();
		}
		else if (_viewModel.CurTabIndex == TeachingDefinition.TeachingType.Level)
		{
			levelTab.ViewModel.TabOnClick();
		}
		else if (_viewModel.CurTabIndex == TeachingDefinition.TeachingType.System)
		{
			systemTab.ViewModel.TabOnClick();
		}
	}
}
