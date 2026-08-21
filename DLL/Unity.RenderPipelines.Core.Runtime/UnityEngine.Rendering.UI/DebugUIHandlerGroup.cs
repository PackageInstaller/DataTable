using UnityEngine.UI;

namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerGroup : DebugUIHandlerWidget
{
	public Text nameLabel;

	public Transform header;

	private DebugUI.Container m_Field;

	private DebugUIHandlerContainer m_Container;

	internal override void SetWidget(DebugUI.Widget widget)
	{
		base.SetWidget(widget);
		m_Field = CastWidget<DebugUI.Container>();
		m_Container = GetComponent<DebugUIHandlerContainer>();
		if (string.IsNullOrEmpty(m_Field.displayName))
		{
			header.gameObject.SetActive(value: false);
		}
		else
		{
			nameLabel.text = m_Field.displayName;
		}
	}

	public override bool OnSelection(bool fromNext, DebugUIHandlerWidget previous)
	{
		if (!fromNext && !m_Container.IsDirectChild(previous))
		{
			DebugUIHandlerWidget lastItem = m_Container.GetLastItem();
			DebugManager.instance.ChangeSelection(lastItem, fromNext: false);
			return true;
		}
		return false;
	}

	public override DebugUIHandlerWidget Next()
	{
		if (m_Container == null)
		{
			return base.Next();
		}
		DebugUIHandlerWidget firstItem = m_Container.GetFirstItem();
		if (firstItem == null)
		{
			return base.Next();
		}
		return firstItem;
	}
}
