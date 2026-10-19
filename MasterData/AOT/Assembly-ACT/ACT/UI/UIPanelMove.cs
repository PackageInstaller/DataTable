using System.Collections.Generic;
using System.Linq;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class UIPanelMove : MonoBehaviour
{
	public List<RectTransform> settingsNotInControlPanels;

	private MonoSettingsView settingView;

	public BetterAnimation betterAnimation;

	public LimitedSlider slider;

	public TextMeshProUGUI MoveValue;

	public ActButton m_BtnConfirm;

	public ActButton m_BtnCancel;

	public ActButton m_RecoverBtn;

	public ViewControlLayer ViewControlLayer;

	private float _lastValue;

	private float _value;

	private void Awake()
	{
		m_BtnConfirm.SetBtnClick(OnBtnConfirmClick);
		m_BtnCancel.SetBtnClick(OnBtnCancelClick);
		m_RecoverBtn.SetBtnClick(RecoverModify);
	}

	private void OnEnable()
	{
		settingView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_SETTINGS) as MonoSettingsView;
		slider.maxValue = 144f;
		slider.minValue = 40f;
		SettingFloat settingFloat = SettingsManager.Instance.RuntimeSettings.GetSettingFloat("Other.UIBorder");
		float lastValue = (slider.value = settingFloat.GetValue());
		_value = (_lastValue = lastValue);
		foreach (RectTransform settingsNotInControlPanel in settingsNotInControlPanels)
		{
			settingsNotInControlPanel.offsetMin = new Vector2(_value, settingsNotInControlPanel.offsetMin.y);
			settingsNotInControlPanel.offsetMax = new Vector2(0f - _value, settingsNotInControlPanel.offsetMax.y);
		}
	}

	public void OnSliderValueChange(float newValue)
	{
		_value = newValue;
		foreach (RectTransform settingsNotInControlPanel in settingsNotInControlPanels)
		{
			settingsNotInControlPanel.offsetMin = new Vector2(newValue, settingsNotInControlPanel.offsetMin.y);
			settingsNotInControlPanel.offsetMax = new Vector2(0f - newValue, settingsNotInControlPanel.offsetMax.y);
		}
		MoveValue.text = newValue.FastToString();
	}

	public void OnBtnConfirmClick()
	{
		SettingFloat settingFloat = SettingsManager.Instance.RuntimeSettings.GetSettingFloat("Other.UIBorder");
		settingFloat.SetValue(_value);
		settingFloat.Apply();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			ViewControlLayer.UnFocus();
			gameObject.SetActive(value: false);
			settingView.ControlCg.alpha = 1f;
			settingView.betterAnimation.GetSequence("Show").Play();
			settingView.tabInfos.First((MonoSettingsView.TabInfo item) => item.Panel is OperationPanel).ControlLayer.ReFocus();
		}).Play();
	}

	public void OnBtnCancelClick()
	{
		TextPanel.Param uiData = new TextPanel.Param
		{
			commonId = 898,
			OnConfirm = OnCancelConfirm
		};
		if (!Mathf.Approximately(slider.value, _lastValue))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, uiData);
			return;
		}
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			ViewControlLayer.UnFocus();
			gameObject.SetActive(value: false);
			settingView.ControlCg.alpha = 1f;
			settingView.betterAnimation.GetSequence("Show").Play();
			settingView.tabInfos.First((MonoSettingsView.TabInfo item) => item.Panel is OperationPanel).ControlLayer.ReFocus();
		}).Play();
	}

	public void OnCancelConfirm()
	{
		SettingsManager.Instance.RuntimeSettings.GetSettingFloat("Other.UIBorder").ResetToAppliedValue();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			ViewControlLayer.UnFocus();
			gameObject.SetActive(value: false);
			settingView.ControlCg.alpha = 1f;
			settingView.betterAnimation.GetSequence("Show").Play();
			settingView.tabInfos.First((MonoSettingsView.TabInfo item) => item.Panel is OperationPanel).ControlLayer.ReFocus();
		}).Play();
	}

	private void RecoverModify()
	{
		float valueWithoutNotify = SafeAreaBorderHelper.ReturnLegalSafeAreaDefaultValue();
		slider.SetValueWithoutNotify(valueWithoutNotify);
		OnSliderValueChange(slider.value);
	}
}
