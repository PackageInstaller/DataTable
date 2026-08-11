using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using Spine.Unity;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class MonthlyCardRewardWindow : UGuiWindow
{
	[SerializeField]
	private Button btnGet;

	[SerializeField]
	private TextMeshProUGUI leftRewardDay;

	[Header("spine时长")]
	public float spineTime = 2f;

	public string spineAniName;

	[SerializeField]
	private SkeletonGraphic spine;

	private MonthlyCardRewardViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<MonthlyCardRewardViewModel>();
		BindingSet<MonthlyCardRewardWindow, MonthlyCardRewardViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((MonthlyCardRewardWindow v) => v.OnDismissRequest).To((MonthlyCardRewardViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((MonthlyCardRewardWindow v) => v.OpenUguiWindow).To((MonthlyCardRewardViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind<TextMeshProUGUI>(leftRewardDay).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((MonthlyCardRewardViewModel vm) => (vm.LeftRewardDay < 5) ? $"剩余领取天数：<color=red>{vm.LeftRewardDay}</color>" : $"剩余领取天数：{vm.LeftRewardDay}");
		bindingSet.Bind(btnGet).For((Button v) => v.onClick).To((MonthlyCardRewardViewModel vm) => vm.GetReward);
		bindingSet.Bind().For((MonthlyCardRewardWindow v) => v.PlaySpine).To((MonthlyCardRewardViewModel vm) => vm.OnGetRewardSuccess);
		bindingSet.Build();
	}

	private void PlaySpine(object sender, InteractionEventArgs e)
	{
		spine.AnimationState.SetAnimation(0, spineAniName, loop: false);
		Invoke("OpenPropGetWindow", spineTime);
	}

	private void OpenPropGetWindow()
	{
		_viewModel.OpenPropGetWindow();
	}
}
