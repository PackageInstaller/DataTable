using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public class GameSettingSliderItem : GameSettingItem
{
	[SerializeField]
	private TextMeshProUGUI nameText;

	[SerializeField]
	private CustomSlider slider;

	[SerializeField]
	private Button disableBtn;

	[SerializeField]
	private Button enableBtn;

	[SerializeField]
	private TextMeshProUGUI sliderRate;

	private bool _switching;

	public override void Init(GameSettingItemViewModel viewModel)
	{
		base.Init(viewModel);
		BindingSet<GameSettingSliderItem, GameSettingItemViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		if ((UnityEngine.Object)(object)nameText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(nameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameSettingItemViewModel vm) => vm.Name);
		}
		if (slider != null)
		{
			bindingSet.Bind(slider).For((CustomSlider v) => v.minValue).To((GameSettingItemViewModel vm) => vm.MinValue);
			bindingSet.Bind(slider).For((CustomSlider v) => v.maxValue).To((GameSettingItemViewModel vm) => vm.MaxValue);
			bindingSet.Bind(slider).For((CustomSlider v) => v.value).To((GameSettingItemViewModel vm) => vm.Value);
			slider.OnPointerDownEvent.AddListener(OnSliderPointerDown);
			slider.onValueChanged.AddListener(OnSliderValueChanged);
			slider.OnPointerUpEvent.AddListener(OnSliderPointerUp);
		}
		if ((UnityEngine.Object)(object)sliderRate != null)
		{
			((TMP_Text)sliderRate).text = $"{Math.Floor(_viewModel.GetValueRate() * 100.0)}%";
		}
		if (disableBtn != null)
		{
			bindingSet.Bind(disableBtn.gameObject).For((GameObject v) => v.activeSelf).ToExpression((GameSettingItemViewModel vm) => !vm.SwitchTag);
			disableBtn.onClick.AddListener(OnDisableBtnClick);
		}
		if (disableBtn != null)
		{
			bindingSet.Bind(enableBtn.gameObject).For((GameObject v) => v.activeSelf).To((GameSettingItemViewModel vm) => vm.SwitchTag);
			enableBtn.onClick.AddListener(OnEnableBtnClick);
		}
		bindingSet.Bind().For((GameSettingSliderItem v) => v.OnValueChanged).To((GameSettingItemViewModel vm) => vm.ValueChanged);
		bindingSet.Build();
	}

	private void OnDisableBtnClick()
	{
		if (_viewModel.SetSwitchTag(tag: true))
		{
			float value = (_viewModel.LastValue.Equals(_viewModel.Value) ? _viewModel.MaxValue : _viewModel.LastValue);
			_viewModel.SetValue(value);
			_viewModel.Parent.ItemOnClick(new OptionArg(_viewModel, "Save"));
		}
	}

	private void OnEnableBtnClick()
	{
		if (_viewModel.SetSwitchTag(tag: false))
		{
			_viewModel.SetLastValue(_viewModel.Value);
			_viewModel.SetValue(_viewModel.MinValue);
			_viewModel.Parent.ItemOnClick(new OptionArg(_viewModel, "Save"));
		}
	}

	private void OnSliderPointerDown(PointerEventData eventData)
	{
		_viewModel.SetSwitchTag(tag: true);
	}

	private void OnSliderValueChanged(float value)
	{
		if (_viewModel.SetValue(value))
		{
			_viewModel.Parent.ItemOnClick(new OptionArg(_viewModel, "Change"));
		}
	}

	private void OnSliderPointerUp(PointerEventData eventData)
	{
		_viewModel.Parent.ItemOnClick(new OptionArg(_viewModel, "Save"));
	}

	private void OnValueChanged(object sender, InteractionEventArgs e)
	{
		if ((UnityEngine.Object)(object)sliderRate != null)
		{
			((TMP_Text)sliderRate).text = $"{Math.Floor(_viewModel.GetValueRate() * 100.0)}%";
		}
	}
}
