using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ImageQualitySelectWindow : UGuiWindow
{
	private ImageQualityViewModel _viewModel;

	[SerializeField]
	private Button lowQualityBtn;

	[SerializeField]
	private Button midQualityBtn;

	[SerializeField]
	private Button hightQualityBtn;

	[SerializeField]
	private Button confirmBtn;

	[SerializeField]
	private GameObject lowToggle;

	[SerializeField]
	private GameObject midToggle;

	[SerializeField]
	private GameObject hightToggle;

	[SerializeField]
	private GameObject lowRecommend;

	[SerializeField]
	private GameObject midRecommend;

	[SerializeField]
	private GameObject hightRecommend;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<ImageQualityViewModel>();
		BindingSet<ImageQualitySelectWindow, ImageQualityViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(lowToggle).For((GameObject v) => v.activeSelf).ToExpression((ImageQualityViewModel vm) => vm.CurGraphicLevel == 1);
		bindingSet.Bind(midToggle).For((GameObject v) => v.activeSelf).ToExpression((ImageQualityViewModel vm) => vm.CurGraphicLevel == 2);
		bindingSet.Bind(hightToggle).For((GameObject v) => v.activeSelf).ToExpression((ImageQualityViewModel vm) => vm.CurGraphicLevel == 3);
		bindingSet.Bind(lowRecommend).For((GameObject v) => v.activeSelf).ToExpression((ImageQualityViewModel vm) => vm.RecommendLevel == 1);
		bindingSet.Bind(midRecommend).For((GameObject v) => v.activeSelf).ToExpression((ImageQualityViewModel vm) => vm.RecommendLevel == 2);
		bindingSet.Bind(hightRecommend).For((GameObject v) => v.activeSelf).ToExpression((ImageQualityViewModel vm) => vm.RecommendLevel == 3);
		bindingSet.Bind(this).For((ImageQualitySelectWindow v) => v.OnDismissRequest).To((ImageQualityViewModel vm) => vm.DismissRequest);
		bindingSet.Build();
		lowQualityBtn.onClick.AddListener(ClickLowBtn);
		midQualityBtn.onClick.AddListener(ClickMidBtn);
		hightQualityBtn.onClick.AddListener(ClickHightBtn);
		confirmBtn.onClick.AddListener(ClickConfirmBtn);
	}

	private void ClickLowBtn()
	{
		_viewModel.SetGraphicLevel(1);
	}

	private void ClickMidBtn()
	{
		_viewModel.SetGraphicLevel(2);
	}

	private void ClickHightBtn()
	{
		_viewModel.SetGraphicLevel(3);
	}

	private void ClickConfirmBtn()
	{
		_viewModel.ClickConfirm();
	}
}
