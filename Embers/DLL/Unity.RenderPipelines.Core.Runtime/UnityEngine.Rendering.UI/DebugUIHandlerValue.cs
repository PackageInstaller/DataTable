using UnityEngine.UI;

namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerValue : DebugUIHandlerWidget
{
	public Text nameLabel;

	public Text valueLabel;

	private DebugUI.Value m_Field;

	private float m_Timer;

	protected override void OnEnable()
	{
		m_Timer = 0f;
	}

	internal override void SetWidget(DebugUI.Widget widget)
	{
		base.SetWidget(widget);
		m_Field = CastWidget<DebugUI.Value>();
		nameLabel.text = m_Field.displayName;
	}

	public override bool OnSelection(bool fromNext, DebugUIHandlerWidget previous)
	{
		nameLabel.color = colorSelected;
		valueLabel.color = colorSelected;
		return true;
	}

	public override void OnDeselection()
	{
		nameLabel.color = colorDefault;
		valueLabel.color = colorDefault;
	}

	private void Update()
	{
		if (m_Timer >= m_Field.refreshRate)
		{
			valueLabel.text = m_Field.GetValue().ToString();
			m_Timer -= m_Field.refreshRate;
		}
		m_Timer += Time.deltaTime;
	}
}
