using ACT.UI;

namespace ACT;

public class AnimateToggleResolver : SettingResolver<bool>
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
		if (m_SettingCell.animateToggle != null)
		{
			m_SettingCell.animateToggle.onValueChanged.AddListener(OnValueChanged);
		}
	}

	protected override void Refresh()
	{
		if (m_SettingCell.animateToggle != null)
		{
			m_SettingCell.animateToggle.isOn = Setting.GetValue();
		}
	}

	private void OnValueChanged(bool arg0)
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
