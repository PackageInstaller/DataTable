using ACT.UI;

namespace ACT;

public class SettingCellIntSliderResolver : SettingResolver<int>
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
		m_SettingCell.slider.value = Setting.GetValue();
	}

	private void OnValueChanged(float arg0)
	{
		m_StopPropagation = true;
		try
		{
			Setting.SetValue((int)arg0);
		}
		finally
		{
			m_StopPropagation = false;
		}
	}
}
