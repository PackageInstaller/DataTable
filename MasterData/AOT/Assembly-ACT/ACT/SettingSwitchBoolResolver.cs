using ACT.UI;

namespace ACT;

public class SettingSwitchBoolResolver : SettingResolver<bool>
{
	private SettingCell cell;

	private bool m_StopPropagation;

	private void Awake()
	{
		cell = GetComponent<SettingCell>();
	}

	protected override void OnStart()
	{
		base.OnStart();
		cell.settingSwitch.OnValueChanged.AddListener(OnValueChanged);
		cell.settingSwitch.CurrentIndex = (Setting.GetValue() ? 1 : 0);
	}

	protected override void OnDestroy()
	{
		cell.settingSwitch.OnValueChanged.RemoveListener(OnValueChanged);
	}

	private void OnValueChanged(int arg0)
	{
		m_StopPropagation = true;
		try
		{
			Setting.SetValue(arg0 == 1);
		}
		finally
		{
			m_StopPropagation = false;
		}
	}

	protected override void Refresh()
	{
	}
}
