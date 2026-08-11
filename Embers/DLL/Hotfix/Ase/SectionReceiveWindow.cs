using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace Ase;

public class SectionReceiveWindow : UGuiWindow
{
	public TextMeshProUGUI taskTitle;

	public TextMeshProUGUI sectionName;

	public TextMeshProUGUI sectionDes;

	public Button clickButton;

	private TaskDataViewModel viewModel;

	[FormerlySerializedAs("IsClick")]
	public bool IsClicked;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<TaskDataViewModel>();
		BindingSet<SectionReceiveWindow, TaskDataViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(sectionName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TaskDataViewModel vm) => vm.TaskName);
		bindingSet.Bind<TextMeshProUGUI>(taskTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TaskDataViewModel vm) => vm.TaskTitle);
		bindingSet.Bind<TextMeshProUGUI>(sectionDes).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((TaskDataViewModel vm) => vm.TaskDesc);
		bindingSet.Bind().For((SectionReceiveWindow v) => v.OnCloseRequest).To((TaskDataViewModel vm) => vm.OnCloseRequest);
		clickButton.onClick.AddListener(OnCloseClick);
		IsClicked = false;
		bindingSet.Build();
	}

	private void OnCloseClick()
	{
		if (!IsClicked)
		{
			IsClicked = true;
		}
	}

	private void OnCloseRequest(object sender, InteractionEventArgs e)
	{
		Close();
	}
}
