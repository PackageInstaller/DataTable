using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class StoryWindow : UGuiWindow
{
	private StoryViewModel viewModel;

	public Button skipButton;

	public Animator optionAnimator;

	protected override async void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<StoryViewModel>();
		if (viewModel == null)
		{
			return;
		}
		if (!viewModel.IsVaild)
		{
			Dismiss();
			return;
		}
		BindingSet<StoryWindow, StoryViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((StoryWindow v) => v.OpenUguiWindow).To((StoryViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(skipButton).For((Button v) => v.onClick).To((StoryViewModel vm) => vm.SkipCommand);
		bindingSet.Bind().For((StoryWindow v) => v.DismissRequest).To((StoryViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((StoryWindow v) => v.Alpha).To((StoryViewModel vm) => vm.WindowAlpha);
		bindingSet.Build();
		Alpha = 0f;
	}

	public void DismissRequest(object sender, InteractionEventArgs args)
	{
		viewModel = null;
		if (!base.Dismissed)
		{
			Close();
		}
	}
}
