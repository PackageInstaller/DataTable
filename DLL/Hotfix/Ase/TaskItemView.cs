using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TaskItemView : UGuiView
{
	[SerializeField]
	private Image icon;

	[SerializeField]
	private Button btn;

	[SerializeField]
	private GameObject mainTaskIcon;

	[SerializeField]
	private new TextMeshProUGUI name;

	private TaskItemViewModel viewModel;

	public void Init(TaskItemViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<TaskItemView, TaskItemViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(icon).For((Image v) => v.sprite).ToExpression((TaskItemViewModel vm) => $"map_mark_{20 + vm.Data.TaskType}_1")
			.WithConversion("ItemIcon");
		bindingSet.Bind(mainTaskIcon).For((GameObject v) => v.activeSelf).ToExpression((TaskItemViewModel vm) => vm.Data.TaskType == 1);
		bindingSet.Bind(btn).For((Button v) => v.onClick).To((TaskItemViewModel vm) => vm.OnClick);
		bindingSet.Bind<TextMeshProUGUI>(name).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TaskItemViewModel vm) => vm.Data.TaskTitle);
		bindingSet.Build();
	}

	public void RefreshData(TaskItemViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
