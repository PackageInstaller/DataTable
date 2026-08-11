using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DrawCardTenWindow : UGuiWindow
{
	[SerializeField]
	private List<DrawCardItem> drawCardItems;

	[SerializeField]
	private Button close;

	[SerializeField]
	private GameObject closeBtnObj;

	[SerializeField]
	private Animator animator;

	private DrawCardTenViewModel viewModel;

	public int allLoadAnimation = 1000;

	public int allConvertAnimation = 1000;

	public int allLightAnimation = 1000;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<DrawCardTenViewModel>();
		BindingSet<DrawCardTenWindow, DrawCardTenViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(close).For((Button v) => v.onClick).To((DrawCardTenViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(closeBtnObj).For((GameObject v) => v.activeSelf).To((DrawCardTenViewModel vm) => vm.CanClose);
		bindingSet.Bind(this).For((DrawCardTenWindow v) => v.CloseWindow).To((DrawCardTenViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((DrawCardTenWindow v) => v.PlayLightAnimation).To((DrawCardTenViewModel vm) => vm.PlayLightAnimationRequest);
		bindingSet.Bind(this).For((DrawCardTenWindow v) => v.PlayLoadAnimation).To((DrawCardTenViewModel vm) => vm.PlayLoadRequest);
		bindingSet.Bind(this).For((DrawCardTenWindow v) => v.PlayConvertAnimation).To((DrawCardTenViewModel vm) => vm.PlayConvertRequest);
		bindingSet.Bind(this).For((DrawCardTenWindow v) => v.PlayAnimation).To((DrawCardTenViewModel vm) => vm.PlayAnimationRequest);
		bindingSet.Bind(this).For((DrawCardTenWindow v) => v.PlayEnterShow).To((DrawCardTenViewModel vm) => vm.PlayEnterRequest);
		InitDrawCardItems();
		bindingSet.Build();
	}

	private async void PlayLightAnimation(object sender, InteractionEventArgs e)
	{
		await UniTask.Delay(allLightAnimation);
		foreach (DrawCardItem drawCardItem in drawCardItems)
		{
			drawCardItem.PlayLightAnimation();
		}
	}

	public async void PlayConvertAnimation(object sender, InteractionEventArgs e)
	{
		await UniTask.Delay(allConvertAnimation);
		foreach (DrawCardItem drawCardItem in drawCardItems)
		{
			drawCardItem.PlayAnimation("Convert");
		}
	}

	private async void PlayLoadAnimation(object sender, InteractionEventArgs e)
	{
		await UniTask.Delay(allLoadAnimation);
		foreach (DrawCardItem drawCardItem in drawCardItems)
		{
			drawCardItem.PlayLoadAnimation();
		}
	}

	public void PlayAnimation(object sender, InteractionEventArgs e)
	{
		drawCardItems[viewModel.Index].PlayAnimation(viewModel.AnimationName);
	}

	public void PlayEnterShow(object sender, InteractionEventArgs e)
	{
		animator.SetTrigger(Animator.StringToHash("enter"));
	}

	protected override void OnShow()
	{
		base.OnShow();
		viewModel.OnShow();
	}

	public void ShowEvent()
	{
		viewModel.PlayLight();
	}

	private void InitDrawCardItems()
	{
		for (int i = 0; i < drawCardItems.Count; i++)
		{
			drawCardItems[i].Init(viewModel.DrawCardItemViewModels[i]);
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
