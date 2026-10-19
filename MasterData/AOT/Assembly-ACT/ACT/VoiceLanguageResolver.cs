using System.Collections.Generic;
using ACT.UI;

namespace ACT;

public class VoiceLanguageResolver : SettingResolver<int>
{
	private SettingCell m_SettingCell;

	private List<int> m_Labels;

	private void OnEnable()
	{
		m_SettingCell = GetComponent<SettingCell>();
	}

	private void OnDisable()
	{
	}

	protected override void OnStart()
	{
		base.OnStart();
		if (Setting != null && Setting is SettingOptions settingOptions)
		{
			m_Labels = settingOptions.GetOptionLabels<int>();
			m_SettingCell.SetButtonLabel(m_Labels[Setting.GetValue()]);
			Refresh();
		}
	}

	protected override void Refresh()
	{
		if (m_Labels != null && m_Labels.Count != 0)
		{
			int value = Setting.GetValue();
			if (value >= 0 && value < m_Labels.Count)
			{
				m_SettingCell.SetButtonLabel(m_Labels[value]);
			}
		}
	}
}
