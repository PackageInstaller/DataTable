using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class OpeCountBtnSlider : UGuiView
{
	[SerializeField]
	private float pressSpeed = 0.5f;

	[SerializeField]
	private TextMeshProUGUI opeCount;

	[SerializeField]
	private ButtonLong btnDec;

	[SerializeField]
	private ButtonLong btnAdd;

	[SerializeField]
	private GameObject btnDecMask;

	[SerializeField]
	private GameObject btnAddMask;

	[SerializeField]
	private Slider slider;

	private OpeCountBtnSliderViewModel _viewModel;

	public OpeCountBtnSliderViewModel ViewModel => _viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_viewModel = GetUserData<OpeCountBtnSliderViewModel>(userData);
		BindingSet<OpeCountBtnSlider, OpeCountBtnSliderViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		if (btnDec != null)
		{
			bindingSet.Bind(btnDec).For((ButtonLong v) => v.onClick).To((OpeCountBtnSliderViewModel vm) => vm.DecOpeCount);
			bindingSet.Bind(btnDec).For((ButtonLong v) => v.enabled).To((OpeCountBtnSliderViewModel vm) => vm.CanDec);
			bindingSet.Bind(btnDec.gameObject).For((GameObject v) => v.activeSelf).To((OpeCountBtnSliderViewModel vm) => vm.ShowBtnDec);
		}
		if (btnAdd != null)
		{
			bindingSet.Bind(btnAdd).For((ButtonLong v) => v.onClick).To((OpeCountBtnSliderViewModel vm) => vm.AddOpeCount);
			bindingSet.Bind(btnAdd).For((ButtonLong v) => v.enabled).To((OpeCountBtnSliderViewModel vm) => vm.CanAdd);
			bindingSet.Bind(btnAdd.gameObject).For((GameObject v) => v.activeSelf).To((OpeCountBtnSliderViewModel vm) => vm.ShowBtnAdd);
		}
		if (btnDecMask != null)
		{
			bindingSet.Bind(btnDecMask).For((GameObject v) => v.activeSelf).ToExpression((OpeCountBtnSliderViewModel vm) => !vm.CanDec);
		}
		if (btnAddMask != null)
		{
			bindingSet.Bind(btnAddMask).For((GameObject v) => v.activeSelf).ToExpression((OpeCountBtnSliderViewModel vm) => !vm.CanAdd);
		}
		if (slider != null)
		{
			bindingSet.Bind(slider).For((Slider v) => v.value, (Slider v) => v.onValueChanged).To((OpeCountBtnSliderViewModel vm) => vm.SliderValue);
			bindingSet.Bind(this).For((OpeCountBtnSlider v) => v.FixSlider).To((OpeCountBtnSliderViewModel vm) => vm.FixSliderRequest);
		}
		if ((UnityEngine.Object)(object)opeCount != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(opeCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((OpeCountBtnSliderViewModel vm) => vm.OpeCount);
		}
		bindingSet.Build();
		if (btnDec != null)
		{
			btnDec.onPress.AddListener(DecPress);
		}
		if (btnAdd != null)
		{
			btnAdd.onPress.AddListener(AddPress);
		}
	}

	private void FixSlider(object sender, InteractionEventArgs e)
	{
		float value = (float)e.Context;
		slider.value = value;
	}

	private void AddPress()
	{
		if (_viewModel.OpeCount < _viewModel.OpeCountMax)
		{
			float value = Mathf.Clamp(slider.value + pressSpeed / (float)_viewModel.OpeCountMax, _viewModel.SliderValueMin, 1f);
			slider.value = value;
		}
	}

	private void DecPress()
	{
		if (_viewModel.OpeCount > _viewModel.OpeCountMin)
		{
			float value = Mathf.Clamp(slider.value - pressSpeed / (float)_viewModel.OpeCountMax, _viewModel.SliderValueMin, 1f);
			slider.value = value;
		}
	}
}
