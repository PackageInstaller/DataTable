using System;
using System.Linq.Expressions;
using System.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class TipWindow : UGuiWindow
{
	[SerializeField]
	private TextMeshProUGUI textTip;

	private TipWindowViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<TipWindowViewModel>();
		BindingSet<TipWindow, TipWindowViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(textTip).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TipWindowViewModel vm) => vm.Tip)
			.OneWay();
		bindingSet.Build();
		if (viewModel.autoHideTime > 0)
		{
			AutoHide(viewModel.autoHideTime);
		}
	}

	private async void AutoHide(int timeSpan)
	{
		await Task.Delay(timeSpan);
		Hide();
	}
}
