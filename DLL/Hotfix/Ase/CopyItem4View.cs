using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopyItem4View : UGuiView
{
	public Button btn;

	public new TextMeshProUGUI name;

	public TextMeshProUGUI count;

	public TextMeshProUGUI countMax;

	public LoadUISprite icon;

	public GameObject lockRoot;

	private CopyItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<CopyItemViewModel>(userData);
		BindingSet<CopyItem4View, CopyItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((CopyItemViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenDetail");
		bindingSet.Bind(icon).For((LoadUISprite v) => v.Path).ToExpression((CopyItemViewModel vm) => $"Copy/CopyDepths/{vm.Data.DepthsIcon}");
		bindingSet.Bind(lockRoot).For((GameObject v) => v.activeSelf).To((CopyItemViewModel vm) => vm.Data.IsLock);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopyItemViewModel vm) => vm.Data.CopyRankName);
		bindingSet.Bind<TextMeshProUGUI>(count).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((CopyItemViewModel vm) => $"{vm.StarCur}/{vm.StarConfigMax}");
		bindingSet.Bind<TextMeshProUGUI>(countMax).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((CopyItemViewModel vm) => $"{vm.StarCur}/{vm.StarConfigMax}");
		bindingSet.Bind(((Component)(object)countMax).gameObject).For((GameObject v) => v.activeSelf).ToExpression((CopyItemViewModel vm) => vm.StarCur >= vm.StarConfigMax);
		bindingSet.Bind(((Component)(object)count).gameObject).For((GameObject v) => v.activeSelf).ToExpression((CopyItemViewModel vm) => vm.StarCur < vm.StarConfigMax);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
