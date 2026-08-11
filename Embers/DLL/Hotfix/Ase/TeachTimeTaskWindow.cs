using System;
using System.Collections;
using System.Linq.Expressions;
using DG.Tweening;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class TeachTimeTaskWindow : UGuiWindow
{
	private TeachTimeTaskViewModel _viewModel;

	[SerializeField]
	private TextMeshProUGUI taskContentText1;

	[SerializeField]
	private TextMeshProUGUI taskContentText2;

	[SerializeField]
	private TextMeshProUGUI taskTimeText;

	[SerializeField]
	private Slider taskSlider;

	[SerializeField]
	private GameObject successIcon;

	[SerializeField]
	private GameObject failIocn;

	[SerializeField]
	private GameObject timePart;

	[SerializeField]
	private GameObject sliderPart;

	[SerializeField]
	private GameObject textContentPart;

	[SerializeField]
	private GameObject FinishTipPart;

	[SerializeField]
	private GameObject mainTaskpart;

	private Tween failHideTween;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<TeachTimeTaskViewModel>();
		if (_viewModel == null || _viewModel.IsCloseView)
		{
			Close();
			return;
		}
		BindingSet<TeachTimeTaskWindow, TeachTimeTaskViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind<TextMeshProUGUI>(taskContentText1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TeachTimeTaskViewModel vm) => vm.TaskContent);
		bindingSet.Bind<TextMeshProUGUI>(taskContentText2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((TeachTimeTaskViewModel vm) => vm.TaskContent);
		bindingSet.Bind(timePart).For((GameObject v) => v.activeSelf).To((TeachTimeTaskViewModel vm) => vm.ShowSlider);
		bindingSet.Bind(sliderPart).For((GameObject v) => v.activeSelf).To((TeachTimeTaskViewModel vm) => vm.ShowSlider);
		bindingSet.Bind().For((TeachTimeTaskWindow v) => v.OnDismissRequest).To((TeachTimeTaskViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((TeachTimeTaskWindow v) => v.OnTimeTaskChangeStateRequest).To((TeachTimeTaskViewModel vm) => vm.TimeTaskChangeStateRequest);
		bindingSet.Build();
	}

	protected override void OnShow()
	{
		base.OnShow();
		_viewModel.ShowAction();
	}

	private void Update()
	{
		if (_viewModel != null && _viewModel.ShowSlider)
		{
			taskSlider.value = _viewModel.SliderFillAmount;
			((TMP_Text)taskTimeText).text = _viewModel.ShowTimerText;
		}
	}

	private void OnTimeTaskChangeStateRequest(object sender, InteractionEventArgs e)
	{
		if (_viewModel == null)
		{
			return;
		}
		if (_viewModel.TimeTaskState == TimeTaskState.Fail)
		{
			if (_viewModel.ShowSlider)
			{
				timePart.SetActive(value: false);
				textContentPart.SetActive(value: false);
				failIocn.SetActive(value: true);
				failHideTween = DOTweenModuleUI.DOFade(CanvasGroup, 0f, 0.01f).SetDelay(1.1f);
			}
		}
		else if (_viewModel.TimeTaskState == TimeTaskState.Success)
		{
			if (_viewModel.ShowSlider)
			{
				timePart.SetActive(value: false);
				textContentPart.SetActive(value: false);
				successIcon.SetActive(value: true);
			}
			StartCoroutine(DelayShowFinish());
		}
		else if (_viewModel.TimeTaskState == TimeTaskState.Running)
		{
			if (failHideTween != null)
			{
				failHideTween.Kill();
				failHideTween = null;
			}
			CanvasGroup.alpha = 1f;
			if (_viewModel.ShowSlider)
			{
				timePart.SetActive(value: true);
				textContentPart.SetActive(value: true);
			}
			failIocn.SetActive(value: false);
			successIcon.SetActive(value: false);
		}
	}

	private IEnumerator DelayShowFinish()
	{
		yield return new WaitForSeconds(0.2f);
		mainTaskpart.SetActive(value: false);
		FinishTipPart.SetActive(value: true);
	}
}
