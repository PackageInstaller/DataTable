using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;

namespace Ase;

public class TaskReceiveWindow : UGuiWindow
{
	public TextMeshProUGUI taskTitle;

	public TextMeshProUGUI taskName;

	private TaskDataViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<TaskDataViewModel>();
		BindingSet<TaskReceiveWindow, TaskDataViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(taskTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TaskDataViewModel vm) => vm.TaskTitle);
		bindingSet.Bind<TextMeshProUGUI>(taskName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TaskDataViewModel vm) => vm.TaskName);
		bindingSet.Bind().For((TaskReceiveWindow v) => v.OnCloseRequest).To((TaskDataViewModel vm) => vm.OnCloseRequest);
		bindingSet.Build();
	}

	private void OnCloseRequest(object sender, InteractionEventArgs e)
	{
		Close();
	}
}
