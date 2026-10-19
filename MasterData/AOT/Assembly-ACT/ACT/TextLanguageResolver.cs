using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.LocalizationExtension;

namespace ACT;

public class TextLanguageResolver : SettingResolver<int>
{
	public LocalizeTMP_Dropdown Dropdown;

	private bool m_StopPropagation;

	private bool m_Started;

	protected override void OnStart()
	{
		base.OnStart();
		m_Started = true;
		if (Setting is SettingOptions)
		{
			Dropdown.m_UseCommonText = true;
			Dropdown.captionText.enabled = false;
			Dropdown.onValueChanged.AddListener(OnValueChanged);
			BuildOptions(force: true);
			Refresh();
		}
	}

	private void OnEnable()
	{
		if (m_Started)
		{
			Refresh();
		}
	}

	private bool BuildOptions(bool force)
	{
		if (!force && Dropdown.options.Count > 0)
		{
			return true;
		}
		if (!(Setting is SettingOptions settingOptions))
		{
			return false;
		}
		List<int> optionLabels = settingOptions.GetOptionLabels<int>();
		if (optionLabels == null || optionLabels.Count == 0)
		{
			return false;
		}
		Dictionary<int, TextLanguageData> dictionary = RuntimeConfigs.data?.textLanguageDatas;
		if (dictionary == null)
		{
			return false;
		}
		Dropdown.options.Clear();
		foreach (int item in optionLabels)
		{
			if (dictionary.TryGetValue(item, out var value) && value != null)
			{
				Dropdown.options.Add(new LocalizeTMP_Dropdown.OptionData(value.languageName));
			}
		}
		return Dropdown.options.Count > 0;
	}

	protected override void Refresh()
	{
		if (!m_StopPropagation && BuildOptions(force: false))
		{
			int value = Setting.GetValue();
			Dropdown.SetValueWithoutNotify(value);
			Dropdown.RefreshShownValue();
		}
	}

	private void OnValueChanged(int arg0)
	{
		m_StopPropagation = true;
		try
		{
			Setting.SetValue(arg0, applyImmediately: true);
		}
		finally
		{
			m_StopPropagation = false;
		}
	}
}
