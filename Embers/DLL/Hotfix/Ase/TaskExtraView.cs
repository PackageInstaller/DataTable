using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TaskExtraView : UGuiView
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private LoadUISprite img;

	private TaskExtraViewModel viewModel;

	public void Init(TaskExtraViewModel viewModel)
	{
		if (this.viewModel != null)
		{
			RefreshData(viewModel);
			return;
		}
		this.viewModel = viewModel;
		BindingSet<TaskExtraView, TaskExtraViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(this).For((TaskExtraView v) => v.OnVisibleChanged).To((TaskExtraViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(img).For((LoadUISprite v) => v.Path).ToExpression((TaskExtraViewModel vm) => $"Task/{this.viewModel.Img}");
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((TaskExtraViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Build();
	}

	public void RefreshData(TaskExtraViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
