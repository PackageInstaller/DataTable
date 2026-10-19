using System;
using ACT.LocalizationExtension;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT;

public class DisableNodeControl : MonoBehaviour
{
	[FormerlySerializedAs("_dlssNodeDisableMask")]
	[SerializeField]
	private Image _nodeDisableMask;

	[FormerlySerializedAs("_dlssNodeSelection")]
	[SerializeField]
	private Selectable _nodeSelection;

	[FormerlySerializedAs("_dlssNodeDropdown")]
	[SerializeField]
	private LocalizeTMP_Dropdown _nodeDropdown;

	[SerializeField]
	private string _dependOnSettingId;

	[SerializeField]
	private int _dependOnSettingIndex;

	[SerializeField]
	private bool _dependOnEqual;

	private SettingOptions _targetOptions;

	private void OnEnable()
	{
		if (SettingsManager.Instance.RuntimeSettings.GetSetting("Graphic.TemporalUpscalerQuality") != null && SettingsManager.Instance.RuntimeSettings.GetSetting(_dependOnSettingId) is SettingOptions settingOptions)
		{
			_targetOptions = settingOptions;
			settingOptions.OnChange = (Action<ISetting>)Delegate.Combine(settingOptions.OnChange, new Action<ISetting>(UpdateDisableState));
			UpdateDisableState();
		}
	}

	private void UpdateDisableState(ISetting setting)
	{
		UpdateDisableState();
	}

	private void UpdateDisableState()
	{
		if (_targetOptions != null)
		{
			bool flag = ((!_dependOnEqual) ? (_targetOptions.GetValue() != _dependOnSettingIndex) : (_targetOptions.GetValue() == _dependOnSettingIndex));
			_nodeDisableMask.gameObject.SetActive(!flag);
			_nodeDropdown.interactable = flag;
			_nodeSelection.interactable = flag;
		}
	}

	private void OnDisable()
	{
		if (_targetOptions != null)
		{
			SettingOptions targetOptions = _targetOptions;
			targetOptions.OnChange = (Action<ISetting>)Delegate.Remove(targetOptions.OnChange, new Action<ISetting>(UpdateDisableState));
			_targetOptions = null;
		}
	}
}
