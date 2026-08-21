using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TaskTrackView : UGuiView
{
	[SerializeField]
	private Image taskIcon;

	[SerializeField]
	private Image taskIconTemp;

	[SerializeField]
	private RectTransform root;

	[SerializeField]
	private RectTransform iconTF;

	[SerializeField]
	private RectTransform iconTFTemp;

	[SerializeField]
	private RectTransform arrow;

	private TaskTrackViewModel viewModel;

	[SerializeField]
	private float offset;

	[SerializeField]
	private float paddingL;

	[SerializeField]
	private float paddingR;

	[SerializeField]
	private float paddingT;

	[SerializeField]
	private float paddingB;

	public void Init(TaskTrackViewModel viewModel)
	{
		this.viewModel = viewModel;
		BindingSet<TaskTrackView, TaskTrackViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(taskIcon).For((Image v) => v.sprite).ToExpression((TaskTrackViewModel vm) => $"map_mark_2{vm.TaskType}_1")
			.WithConversion("ItemIcon");
		bindingSet.Bind(taskIconTemp).For((Image v) => v.sprite).ToExpression((TaskTrackViewModel vm) => $"map_mark_2{vm.TaskType}_1")
			.WithConversion("ItemIcon");
		bindingSet.Bind(arrow).For((RectTransform v) => v.localRotation).ToExpression((TaskTrackViewModel vm) => vm.RotZ);
		bindingSet.Bind(iconTF).For((RectTransform v) => v.localRotation).ToExpression((TaskTrackViewModel vm) => vm.RotZIcon);
		bindingSet.Bind().For((TaskTrackView v) => v.FixIconPos).To((TaskTrackViewModel vm) => vm.FixIconPosRequest);
		bindingSet.Build();
	}

	private void FixIconPos(object sender, InteractionEventArgs e)
	{
		root.localPosition = viewModel.UiPos;
		Vector2 anchoredPosition = root.anchoredPosition;
		if (!UIUtilly.IsUIPosInsideScreen(anchoredPosition, paddingL, paddingR, paddingT, paddingB))
		{
			anchoredPosition = UIUtilly.PutUIPosInsideScreen(anchoredPosition, paddingL, paddingR, paddingT, paddingB);
			root.anchoredPosition = anchoredPosition;
			base.gameObject.SetActive(value: true);
		}
		else
		{
			base.gameObject.SetActive(value: false);
		}
	}

	public void RefreshData(TaskTrackViewModel viewModel)
	{
		this.SetDataContext(viewModel);
	}
}
