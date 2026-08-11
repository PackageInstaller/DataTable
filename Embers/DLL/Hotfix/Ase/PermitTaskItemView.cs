using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PermitTaskItemView : UGuiView
{
	public Image progressFill;

	public Button btnGoto;

	public TextMeshProUGUI taskDesc;

	public TextMeshProUGUI taskVal;

	public GameObject compeletRoot;

	public GameObject normalRoot;

	private PermitTaskItemViewModel viewModel;

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = GetUserData<PermitTaskItemViewModel>(userData);
		BindingSet<PermitTaskItemView, PermitTaskItemViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnGoto).For((Button v) => v.onClick).To((PermitTaskItemViewModel vm) => vm.OnGoto);
		bindingSet.Bind<TextMeshProUGUI>(taskVal).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((PermitTaskItemViewModel vm) => string.Format("(<color=#{0}>{1}</color>/{2})", (vm.Data.CurProgress >= vm.Data.TargetVal) ? "B0B0B0" : "FF8484", vm.Data.CurProgress, vm.Data.TargetVal));
		bindingSet.Bind(progressFill).For((Image v) => v.fillAmount).ToExpression((PermitTaskItemViewModel vm) => (vm.Data.TargetVal == 0) ? 0f : ((float)vm.Data.CurProgress * 1f / (float)vm.Data.TargetVal));
		bindingSet.Bind<TextMeshProUGUI>(taskDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PermitTaskItemViewModel vm) => vm.Data.Desc);
		bindingSet.Bind(compeletRoot).For((GameObject v) => v.activeSelf).To((PermitTaskItemViewModel vm) => vm.Data.IsComplete);
		bindingSet.Bind(normalRoot).For((GameObject v) => v.activeSelf).ToExpression((PermitTaskItemViewModel vm) => !vm.Data.IsComplete);
		bindingSet.Build();
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<PermitTaskItemViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
