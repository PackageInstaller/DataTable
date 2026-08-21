using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TowerCopyItemView : UGuiView
{
	[SerializeField]
	private GameObject select;

	[SerializeField]
	private GameObject finish;

	[SerializeField]
	private GameObject LockObj;

	[SerializeField]
	private Button btn;

	private TowerCopyItemViewModel viewModel;

	public void Init(TowerCopyItemViewModel userData)
	{
		viewModel = userData;
		BindingSet<TowerCopyItemView, TowerCopyItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(finish).For((GameObject v) => v.activeSelf).To((TowerCopyItemViewModel vm) => vm.FinishLevel);
		bindingSet.Bind(select).For((GameObject v) => v.activeSelf).To((TowerCopyItemViewModel vm) => vm.SelectLevel);
		bindingSet.Bind(LockObj).For((GameObject v) => v.activeSelf).ToExpression((TowerCopyItemViewModel vm) => !vm.UnLock);
		bindingSet.Build();
		btn.onClick.AddListener(ClickBtn);
	}

	private void ClickBtn()
	{
		viewModel.ItemOnClick(this);
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		viewModel = (TowerCopyItemViewModel)userData;
		this.SetDataContext(viewModel);
	}
}
