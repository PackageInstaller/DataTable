using System.Collections.Generic;
using ACT.LocalizationExtension;
using ACT.UI;
using UnityEngine;

namespace ACT;

public class TMPDropdownResolver : SettingResolver<int>
{
	private SettingCell m_SettingCell;

	private bool m_StopPropagation;

	private void Awake()
	{
		m_SettingCell = GetComponent<SettingCell>();
	}

	protected override void OnStart()
	{
		base.OnStart();
		if (Setting == null || !(Setting is SettingOptions settingOptions))
		{
			return;
		}
		if (m_SettingCell == null || m_SettingCell.dropdown == null)
		{
			Debug.LogWarning("[TMPDropdownResolver] SettingCell dropdown is missing for setting '" + Setting.Id + "'.", this);
			return;
		}
		List<string> optionLabels = settingOptions.GetOptionLabels<string>();
		if (optionLabels == null)
		{
			Debug.LogWarning("[TMPDropdownResolver] No string options found for setting '" + Setting.Id + "'.", this);
			return;
		}
		m_SettingCell.dropdown.m_UseCommonText = true;
		if (m_SettingCell.dropdown.captionText != null)
		{
			m_SettingCell.dropdown.captionText.enabled = false;
		}
		m_SettingCell.dropdown.options.Clear();
		foreach (string item in optionLabels)
		{
			m_SettingCell.dropdown.options.Add(new LocalizeTMP_Dropdown.OptionData(item));
		}
		m_SettingCell.dropdown.onValueChanged.AddListener(OnValueChanged);
		Refresh();
	}

	protected override void Refresh()
	{
		if (Setting != null && !(m_SettingCell == null) && !(m_SettingCell.dropdown == null))
		{
			int value = Setting.GetValue();
			m_SettingCell.dropdown.SetValueWithoutNotify(value);
			m_SettingCell.dropdown.RefreshShownValue();
		}
	}

	private void OnValueChanged(int arg0)
	{
		m_StopPropagation = true;
		try
		{
			Setting.SetValue(arg0);
		}
		finally
		{
			m_StopPropagation = false;
		}
	}
}
