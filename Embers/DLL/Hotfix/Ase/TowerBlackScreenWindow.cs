using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class TowerBlackScreenWindow : UGuiWindow
{
	[SerializeField]
	private Animation blackScreenAnimation;

	[SerializeField]
	private string hideName;

	[SerializeField]
	private float hideTime = 0.5f;

	private TowerBlackScreenViewModel viewModel;

	public float HideTime => hideTime;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<TowerBlackScreenViewModel>();
		BindingSet<TowerBlackScreenWindow, TowerBlackScreenViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((TowerBlackScreenWindow v) => v.OnPlyBlackScreenHide).To((TowerBlackScreenViewModel vm) => vm.BalckScreenHide);
		bindingSet.Bind(this).For((TowerBlackScreenWindow v) => v.OnDismissRequest).To((TowerBlackScreenViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((TowerBlackScreenWindow v) => v.OnShowEndTimeRequest).To((TowerBlackScreenViewModel vm) => vm.ShowEndTimeRequest);
		bindingSet.Build();
	}

	private void OnPlyBlackScreenHide(object sender, InteractionEventArgs args)
	{
		if ((Object)(object)blackScreenAnimation != null)
		{
			blackScreenAnimation.Play(hideName);
		}
	}

	private void OnShowEndTimeRequest(object sender, InteractionEventArgs args)
	{
		if ((Object)(object)blackScreenAnimation != null)
		{
			string text = ((Object)(object)blackScreenAnimation.clip).name;
			blackScreenAnimation[text].normalizedTime = 1f;
		}
	}
}
