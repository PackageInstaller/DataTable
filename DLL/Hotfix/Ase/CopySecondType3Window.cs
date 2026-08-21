using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class CopySecondType3Window : UGuiWindowBase
{
	public CopySecondType3EntryView entryView;

	public CopySecondType3MultiView multiView;

	public CopySecondType3ExtremeView firePowerView;

	public CopySecondType3ExtremeView extremeView;

	private CopySecondType3ViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<CopySecondType3ViewModel>();
		BindingSet<CopySecondType3Window, CopySecondType3ViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((CopySecondType3Window v) => v.OnDismissRequest).To((CopySecondType3ViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((CopySecondType3Window v) => v.OnPageChanged).To((CopySecondType3ViewModel vm) => vm.PageRequest);
		bindingSet.Bind(this).For((CopySecondType3Window v) => v.OpenUguiWindow).To((CopySecondType3ViewModel vm) => vm.OpenWindowRequest);
		if (entryView != null)
		{
			entryView.ViewModel = viewModel.EntryViewModel;
		}
		if (multiView != null)
		{
			multiView.ViewModel = viewModel;
		}
		bindingSet.Build();
		RefreshPage(viewModel.CurrentPage);
		SettleInitParam().Forget();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		viewModel?.Open();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		viewModel?.RemoveMonthlyCardInfo();
	}

	private void OnPageChanged(object sender, InteractionEventArgs e)
	{
		if (e.Context is CopyType3Page page)
		{
			RefreshPage(page);
			RefreshActiveRankView(page);
		}
	}

	private void RefreshPage(CopyType3Page page)
	{
		RefreshActiveRankView(page);
		SetViewActive(multiView, page == CopyType3Page.Multi);
		SetViewActive(entryView, page == CopyType3Page.Entry);
		SetViewActive(firePowerView, page == CopyType3Page.FirePower);
		SetViewActive(extremeView, page == CopyType3Page.Extreme);
	}

	private static void SetViewActive(Component view, bool active)
	{
		if (view != null)
		{
			view.gameObject.SetActive(active);
		}
	}

	private void RefreshActiveRankView(CopyType3Page page)
	{
		switch (page)
		{
		case CopyType3Page.FirePower:
			if (firePowerView != null)
			{
				firePowerView.ViewModel = viewModel.FirePowerViewModel;
			}
			break;
		case CopyType3Page.Extreme:
			if (extremeView != null)
			{
				extremeView.ViewModel = viewModel.ExtremeViewModel;
			}
			break;
		}
	}

	private async UniTaskVoid SettleInitParam()
	{
		if (viewModel != null)
		{
			await UniTask.WaitUntil(() => Visibility);
			viewModel.InitMonthlyCardInfo();
		}
	}
}
