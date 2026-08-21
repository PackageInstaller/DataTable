using UnityEngine.UI;

namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerMessageBox : DebugUIHandlerWidget
{
	public Text nameLabel;

	private DebugUI.MessageBox m_Field;

	private static Color32 k_WarningBackgroundColor = new Color32(231, 180, 3, 30);

	private static Color32 k_WarningTextColor = new Color32(231, 180, 3, byte.MaxValue);

	private static Color32 k_ErrorBackgroundColor = new Color32(231, 75, 3, 30);

	private static Color32 k_ErrorTextColor = new Color32(231, 75, 3, byte.MaxValue);

	internal override void SetWidget(DebugUI.Widget widget)
	{
		base.SetWidget(widget);
		m_Field = CastWidget<DebugUI.MessageBox>();
		nameLabel.text = m_Field.displayName;
		Image component = GetComponent<Image>();
		switch (m_Field.style)
		{
		case DebugUI.MessageBox.Style.Warning:
			component.color = k_WarningBackgroundColor;
			break;
		case DebugUI.MessageBox.Style.Error:
			component.color = k_ErrorBackgroundColor;
			break;
		}
	}

	public override bool OnSelection(bool fromNext, DebugUIHandlerWidget previous)
	{
		return false;
	}
}
