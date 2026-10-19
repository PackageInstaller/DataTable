using ACT.UI;

namespace ACT;

public class SettingCellSliderResolver : SettingResolver<float>
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
		m_SettingCell.slider.onValueChanged.AddListener(OnValueChanged);
	}

	protected override void Refresh()
	{
		m_StopPropagation = true;
		try
		{
			m_SettingCell.slider.SetValueWithoutNotify(Setting.GetValue());
			m_SettingCell.SetSliderValue();
		}
		finally
		{
			m_StopPropagation = false;
		}
	}

	private void OnValueChanged(float arg0)
	{
		if (m_StopPropagation)
		{
			return;
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
}
