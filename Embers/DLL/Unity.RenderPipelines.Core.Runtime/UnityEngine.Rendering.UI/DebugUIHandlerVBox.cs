namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerVBox : DebugUIHandlerWidget
{
	private DebugUIHandlerContainer m_Container;

	internal override void SetWidget(DebugUI.Widget widget)
	{
		base.SetWidget(widget);
		m_Container = GetComponent<DebugUIHandlerContainer>();
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
