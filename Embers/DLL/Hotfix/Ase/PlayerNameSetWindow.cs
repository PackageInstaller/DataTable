using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using Spine.Unity;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class PlayerNameSetWindow : UGuiWindow
{
	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private Button btnRandom;

	[SerializeField]
	private TMP_InputField input;

	[SerializeField]
	private TabItemNormal maleBtn;

	[SerializeField]
	private SkeletonGraphic maleSkeletonGraphic;

	[SerializeField]
	private TabItemNormal femaleBtn;

	[SerializeField]
	private SkeletonGraphic femaleSkeletonGraphic;

	[SerializeField]
	private SkeletonGraphic lightSkeletonGraphic;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private Button btnClose2;

	[SerializeField]
	private Button btnNextStep;

	[SerializeField]
	private Animator animator;

	[SerializeField]
	private GameObject confirmEffectObj;

	private PlayerNameSetViewModel viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<PlayerNameSetViewModel>();
		BindingSet<PlayerNameSetWindow, PlayerNameSetViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind().For((PlayerNameSetWindow v) => v.OnToastShow).To((PlayerNameSetViewModel vm) => vm.ToastRequest);
		bindingSet.Bind().For((PlayerNameSetWindow v) => v.OnDismissRequest).To((PlayerNameSetViewModel vm) => vm.DismissRequest);
		bindingSet.Bind<TMP_InputField>(input).For((Expression<Func<TMP_InputField, string>>)((TMP_InputField v) => v.text), (Expression<Func<TMP_InputField, SubmitEvent>>)((TMP_InputField v) => v.onEndEdit)).To((PlayerNameSetViewModel vm) => vm.NameInput);
		bindingSet.Bind(btnRandom).For((Button v) => v.onClick).To((PlayerNameSetViewModel vm) => vm.RandomName);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((PlayerNameSetViewModel vm) => vm.ConfirmCommand);
		bindingSet.Bind(this).For((PlayerNameSetWindow v) => v.PlayNextAnimation).To((PlayerNameSetViewModel vm) => vm.PlayNextAnimationRequest);
		bindingSet.Bind(this).For((PlayerNameSetWindow v) => v.PlayExitAnimation).To((PlayerNameSetViewModel vm) => vm.PlayExitAnimationRequest);
		if (btnClose != null)
		{
			bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((PlayerNameSetViewModel vm) => vm.Close);
		}
		if (btnClose2 != null)
		{
			bindingSet.Bind(btnClose2).For((Button v) => v.onClick).To((PlayerNameSetViewModel vm) => vm.Close);
		}
		if (btnNextStep != null)
		{
			bindingSet.Bind(btnNextStep).For((Button v) => v.onClick).To((PlayerNameSetViewModel vm) => vm.NextStepOnClick);
		}
		bindingSet.Build();
		if (!(maleBtn == null))
		{
			maleBtn.Init(viewModel.MaleData);
			femaleBtn.Init(viewModel.FemaleData);
			PlayAnimation();
		}
	}

	private void PlayAnimation()
	{
		lightSkeletonGraphic.AnimationState.SetAnimation(0, "Name_Start", loop: false);
		lightSkeletonGraphic.AnimationState.Complete += delegate
		{
			lightSkeletonGraphic.AnimationState.SetAnimation(0, "Name_StanrtIdle", loop: true);
		};
		maleSkeletonGraphic.AnimationState.SetAnimation(0, "Idle_00", loop: true);
		femaleSkeletonGraphic.AnimationState.SetAnimation(0, "Idle_00", loop: true);
	}

	public void PlayNextAnimation(object sender, InteractionEventArgs args)
	{
		lightSkeletonGraphic.AnimationState.SetAnimation(0, "Name_Fire", loop: false);
		lightSkeletonGraphic.AnimationState.Complete += delegate
		{
			lightSkeletonGraphic.AnimationState.SetAnimation(0, "Name_FireIdle", loop: true);
		};
		animator.SetTrigger(Animator.StringToHash("next"));
	}

	public void PlayExitAnimation(object sender, InteractionEventArgs args)
	{
		animator.SetTrigger(Animator.StringToHash("out"));
		confirmEffectObj.gameObject.SetActive(value: true);
	}

	public virtual async void OnToastShow(object sender, InteractionEventArgs args)
	{
		if (args.Context is Notification notification)
		{
			Toast.ShowInfo(notification.Message);
		}
	}

	private void OnCloseRequest(object sender, InteractionEventArgs e)
	{
		Dismiss();
	}
}
