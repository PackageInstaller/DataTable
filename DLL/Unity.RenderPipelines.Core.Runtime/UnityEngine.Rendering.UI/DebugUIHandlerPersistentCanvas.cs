using System.Collections.Generic;

namespace UnityEngine.Rendering.UI;

internal class DebugUIHandlerPersistentCanvas : MonoBehaviour
{
	public RectTransform panel;

	public RectTransform valuePrefab;

	private List<DebugUIHandlerValue> m_Items = new List<DebugUIHandlerValue>();

	internal void Toggle(DebugUI.Value widget)
	{
		int num = m_Items.FindIndex((DebugUIHandlerValue x) => x.GetWidget() == widget);
		if (num > -1)
		{
			CoreUtils.Destroy(m_Items[num].gameObject);
			m_Items.RemoveAt(num);
			return;
		}
		GameObject obj = Object.Instantiate(valuePrefab, panel, worldPositionStays: false).gameObject;
		obj.name = widget.displayName;
		DebugUIHandlerValue component = obj.GetComponent<DebugUIHandlerValue>();
		component.SetWidget(widget);
		m_Items.Add(component);
	}

	internal void Clear()
	{
		if (m_Items == null)
		{
			return;
		}
		foreach (DebugUIHandlerValue item in m_Items)
		{
			CoreUtils.Destroy(item.gameObject);
		}
		m_Items.Clear();
	}
}
