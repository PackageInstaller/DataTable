using System.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DrawCardTouchWindow : UGuiWindow
{
	[SerializeField]
	private Button skipBtn;

	[SerializeField]
	private Animator animator;

	[SerializeField]
	private GameObject knockObj;

	private DrawCardTouchViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<DrawCardTouchViewModel>();
		BindingSet<DrawCardTouchWindow, DrawCardTouchViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((DrawCardTouchWindow v) => v.CloseWindow).To((DrawCardTouchViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(skipBtn).For((Button v) => v.onClick).To((DrawCardTouchViewModel vm) => vm.SkipCmd);
		bindingSet.Bind(this).For((DrawCardTouchWindow v) => v.PlayCloseAnimation).To((DrawCardTouchViewModel vm) => vm.CloseWindowRequest);
		bindingSet.Bind(knockObj).For((GameObject v) => v.activeSelf).To((DrawCardTouchViewModel vm) => vm.ShowKnock);
		bindingSet.Build();
	}

	public async void PlayCloseAnimation(object sender, InteractionEventArgs e)
	{
		string text = "out";
		animator.SetTrigger(Animator.StringToHash(text));
		await Task.Delay(1000);
		viewModel.Close();
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
	}
}
