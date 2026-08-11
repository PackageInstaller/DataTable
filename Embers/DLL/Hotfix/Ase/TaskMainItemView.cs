using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TaskMainItemView : UGuiView
{
	[SerializeField]
	private StateItem taskState;

	[SerializeField]
	private GameObject selRoot;

	[SerializeField]
	private GameObject typeIcon;

	[SerializeField]
	private GameObject typeIcon1;

	[SerializeField]
	private Button btnSel;

	[SerializeField]
	private StateItem taskType;

	[SerializeField]
	private new TextMeshProUGUI name;

	[SerializeField]
	private TextMeshProUGUI nameSel;

	private TaskMainItemViewModel viewModel;

	public void Init(TaskMainItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<TaskMainItemView, TaskMainItemViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		if (typeIcon != null && typeIcon1 != null)
		{
			bindingSet.Bind(typeIcon).For((GameObject v) => v.activeSelf).ToExpression((TaskMainItemViewModel vm) => vm.TaskExtra != 1);
			bindingSet.Bind(typeIcon1).For((GameObject v) => v.activeSelf).ToExpression((TaskMainItemViewModel vm) => vm.TaskExtra == 1);
		}
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TaskMainItemViewModel vm) => vm.Name);
		bindingSet.Bind<TextMeshProUGUI>(nameSel).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TaskMainItemViewModel vm) => vm.Name);
		bindingSet.Bind(btnSel).For((Button v) => v.onClick).To((TaskMainItemViewModel vm) => vm.OnSelect);
		bindingSet.Bind(selRoot).For((GameObject v) => v.activeSelf).To((TaskMainItemViewModel vm) => vm.IsSelect);
		bindingSet.Bind(taskState).For((StateItem v) => v.CurState).To((TaskMainItemViewModel vm) => vm.TaskState);
		bindingSet.Bind(taskType).For((StateItem v) => v.CurState).To((TaskMainItemViewModel vm) => vm.TaskTitleType);
		bindingSet.Build();
	}

	public void RefreshData(TaskMainItemViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
