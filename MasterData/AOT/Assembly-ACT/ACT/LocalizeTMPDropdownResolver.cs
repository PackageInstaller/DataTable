using System.Collections.Generic;
using ACT.LocalizationExtension;
using ACT.UI;
using Unity.VisualScripting;
using UnityEngine.Localization;

namespace ACT;

public class LocalizeTMPDropdownResolver : SettingResolver<int>
{
	private SettingCell m_SettingCell;

	private bool m_StopPropagation;

	private LocalizeTMPDropdownHighPerformanceMarksManager m_HighPerformanceMarksManager;

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
		m_SettingCell.dropdown.options.Clear();
		foreach (LocalizedString optionLabel in settingOptions.GetOptionLabels<LocalizedString>())
		{
			m_SettingCell.dropdown.options.Add(new LocalizeTMP_Dropdown.OptionData(optionLabel));
		}
		m_SettingCell.dropdown.onValueChanged.AddListener(OnValueChanged);
		Refresh();
	}

	protected override void Refresh()
	{
		int value = Setting.GetValue();
		m_SettingCell.dropdown.SetValueWithoutNotify(value);
		m_SettingCell.dropdown.RefreshShownValue();
		UpdateHighPerformanceMarkVisible();
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
		UpdateHighPerformanceMarkVisible();
	}

	private void UpdateHighPerformanceMarkVisible()
	{
		m_HighPerformanceMarksManager.UpdateValue(Setting.GetValue());
	}

	protected override void OnInit()
	{
		base.OnInit();
		HashSet<int> highPerformanceInfos = SettingsManager.Instance.RuntimeSettings.GetHighPerformanceInfos(Id);
		LocalizeTMPDropdownHighPerformanceMarksManager orAddComponent = m_SettingCell.dropdown.GetOrAddComponent<LocalizeTMPDropdownHighPerformanceMarksManager>();
		orAddComponent.SetHighPerformanceInfos(highPerformanceInfos);
		m_HighPerformanceMarksManager = orAddComponent;
	}
}
