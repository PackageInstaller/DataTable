using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class SelectItemView : UGuiView
{
	public Button btn;

	public ButtonLong buttonLong;

	public GameObject selectRoot;

	private bool isSelect;

	private SelectItemViewModel viewModel;

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		set
		{
			OnSelectChanged(isSelect, value);
			isSelect = value;
		}
	}

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<SelectItemViewModel>(userData);
		BindingSet<SelectItemView, SelectItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((SelectItemViewModel vm) => vm.OnClick);
		}
		if (buttonLong != null)
		{
			if (buttonLong.ClickEnabled)
			{
				bindingSet.Bind(buttonLong).For((ButtonLong v) => v.onClick).To((SelectItemViewModel vm) => vm.OnClick);
			}
			if (buttonLong.PressEnabled)
			{
				bindingSet.Bind(buttonLong).For((ButtonLong v) => v.onPress).To((SelectItemViewModel vm) => vm.OnPress);
			}
			if (buttonLong.LongClickEnabled)
			{
				bindingSet.Bind(buttonLong).For((ButtonLong v) => v.onLongClick).To((SelectItemViewModel vm) => vm.OnLongClick);
			}
		}
		if (selectRoot != null)
		{
			bindingSet.Bind(selectRoot).For((GameObject v) => v.activeSelf).To((SelectItemViewModel vm) => vm.IsSelect);
		}
		bindingSet.Bind(this).For((SelectItemView v) => v.IsSelect).To((SelectItemViewModel vm) => vm.IsSelect);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		viewModel = GetUserData<SelectItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}

	protected virtual void OnSelectChanged(bool oldSel, bool newSel)
	{
	}
}
