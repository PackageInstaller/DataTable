using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class VersionMoneyView : UGuiView
{
	public int id;

	public TextMeshProUGUI curCount;

	public TextMeshProUGUI maxCount;

	public TextMeshProUGUI aumCount;

	private VersionMoneyViewModel viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<VersionMoneyViewModel>(userData);
		BindingSet<VersionMoneyView, VersionMoneyViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if ((UnityEngine.Object)(object)curCount != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(curCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((VersionMoneyViewModel vm) => vm.CurCount);
		}
		if ((UnityEngine.Object)(object)maxCount != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(maxCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((VersionMoneyViewModel vm) => vm.MaxCount);
		}
		if ((UnityEngine.Object)(object)aumCount != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(aumCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((VersionMoneyViewModel vm) => vm.AumCount);
		}
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		viewModel = GetUserData<VersionMoneyViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
