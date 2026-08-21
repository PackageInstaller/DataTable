using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class StoryTipWindow : UGuiWindow
{
	[SerializeField]
	private StoryPopTipView storyPopTipView;

	[SerializeField]
	private StoryPopTipView taskPopTipView;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		StoryTipViewModel data = GetData<StoryTipViewModel>();
		BindingSet<StoryTipWindow, StoryTipViewModel> bindingSet = this.CreateBindingSet(data);
		bindingSet.Bind(this).For((StoryTipWindow v) => v.OnVisibleChanged).To((StoryTipViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(this).For((StoryTipWindow v) => v.OnDismissRequest).To((StoryTipViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		storyPopTipView.Init(data.StoryPopTipViewModel);
		taskPopTipView.Init(data.TaskPopTipViewModel);
	}
}
