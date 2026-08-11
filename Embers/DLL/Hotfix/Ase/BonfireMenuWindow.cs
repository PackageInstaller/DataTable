using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BonfireMenuWindow : UGuiWindow
{
	[SerializeField]
	private TabItem btnRest;

	[SerializeField]
	private TabItem btnChangeHero;

	[SerializeField]
	private TabItem btnHeroCultivate;

	[SerializeField]
	private RectTransform bgRect;

	[SerializeField]
	private CanvasGroup canvasGroup;

	[SerializeField]
	private TabItem btnClose;

	private BonfireMenuViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<BonfireMenuViewModel>();
		BindingSet<BonfireMenuWindow, BonfireMenuViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((BonfireMenuWindow v) => v.OnDismissRequest).To((BonfireMenuViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((BonfireMenuWindow v) => v.OpenUguiWindow).To((BonfireMenuViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Build();
		btnRest.Init(new TabItemData(_viewModel, 0));
		btnChangeHero.Init(new TabItemData(_viewModel, 1));
		btnHeroCultivate.Init(new TabItemData(_viewModel, 2));
		btnClose.Init(new TabItemData(_viewModel, 3));
	}

	protected override void OnShow()
	{
		base.OnShow();
		ChangeHeroUnLock();
		_viewModel.GamePause();
	}

	private void ChangeHeroUnLock()
	{
		if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70006))
		{
			btnChangeHero.gameObject.SetActive(value: false);
			bgRect.sizeDelta = new Vector2(400f, 249f);
		}
	}
}
