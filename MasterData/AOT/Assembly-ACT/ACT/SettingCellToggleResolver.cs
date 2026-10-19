using ACT.UI;

namespace ACT;

public class SettingCellToggleResolver : SettingResolver<bool>
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
		m_SettingCell.muteToggle.onValueChanged.AddListener(OnValueChanged);
	}

	protected override void Refresh()
	{
		bool value = Setting.GetValue();
		m_StopPropagation = true;
		try
		{
			m_SettingCell.muteToggle.SetIsOnWithoutNotify(value);
			m_SettingCell.SetIcon(value);
		}
		finally
		{
			m_StopPropagation = false;
		}
	}

	private void OnValueChanged(bool arg0)
	{
		if (m_StopPropagation)
		{
			return;
		}
		if (!arg0 && IsAudioMuteSetting() && m_SettingCell.ShouldForceMuteIcon())
		{
			m_StopPropagation = true;
			try
			{
				m_SettingCell.muteToggle.SetIsOnWithoutNotify(value: true);
				m_SettingCell.SetIcon(isMute: true);
				Setting.SetValue(value: true);
				return;
			}
			finally
			{
				m_StopPropagation = false;
			}
		}
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

	private bool IsAudioMuteSetting()
	{
		string settingsId = GetSettingsId();
		switch (settingsId)
		{
		default:
			return settingsId == "Audio.Mute.Talk";
		case "Audio.Mute.Main":
		case "Audio.Mute.Music":
		case "Audio.Mute.Effect":
			return true;
		}
	}
}
