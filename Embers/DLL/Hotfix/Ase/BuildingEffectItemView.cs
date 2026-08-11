using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class BuildingEffectItemView : UGuiView
{
	public new TextMeshProUGUI name;

	public TextMeshProUGUI cur;

	public TextMeshProUGUI next;

	public GameObject valRoot;

	private BuildingEffectItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<BuildingEffectItemViewModel>(userData);
		BindingSet<BuildingEffectItemView, BuildingEffectItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BuildingEffectItemViewModel vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(cur).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BuildingEffectItemViewModel vm) => vm.Cur);
		bindingSet.Bind<TextMeshProUGUI>(next).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((BuildingEffectItemViewModel vm) => vm.Next);
		bindingSet.Bind(valRoot).For((GameObject v) => v.activeSelf).To((BuildingEffectItemViewModel vm) => vm.ShowVal);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		BuildingEffectItemViewModel userData2 = GetUserData<BuildingEffectItemViewModel>(userData);
		if (viewModel != userData2)
		{
			viewModel = userData2;
			this.SetDataContext(viewModel);
		}
	}
}
