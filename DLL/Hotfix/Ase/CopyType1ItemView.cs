using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyType1ItemView : CopyPlayUnlockEffectItemView
{
	public Button btn;

	public new TextMeshProUGUI name;

	public LoadUISprite icon;

	public GameObject redRoot;

	private CopyTypeItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<CopyTypeItemViewModel>(userData);
		BindingSet<CopyType1ItemView, CopyTypeItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(redRoot).For((GameObject v) => v.activeSelf).To((CopyTypeItemViewModel vm) => vm.Data.HasNew);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyTypeItemViewModel vm) => vm.Data.CopyTypeName);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((CopyTypeItemViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenType1");
		bindingSet.Bind(icon).For((LoadUISprite v) => v.Path).ToExpression((CopyTypeItemViewModel vm) => $"Copy/CopyType/{vm.Data.CopyTypeIcon}");
		bindingSet.Bind().For((CopyType1ItemView v) => v.OnOpt).To((CopyTypeItemViewModel vm) => vm.OptRequest);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyTypeItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
