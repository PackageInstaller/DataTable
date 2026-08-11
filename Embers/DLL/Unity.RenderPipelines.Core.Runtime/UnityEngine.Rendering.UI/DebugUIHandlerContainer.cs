using System.Collections.Generic;
using System.Linq;

namespace UnityEngine.Rendering.UI;

public class DebugUIHandlerContainer : MonoBehaviour
{
	[SerializeField]
	public RectTransform contentHolder;

	internal DebugUIHandlerWidget GetFirstItem()
	{
		if (contentHolder.childCount == 0)
		{
			return null;
		}
		List<DebugUIHandlerWidget> activeChildren = GetActiveChildren();
		if (activeChildren.Count == 0)
		{
			return null;
		}
		return activeChildren[0];
	}

	internal DebugUIHandlerWidget GetLastItem()
	{
		if (contentHolder.childCount == 0)
		{
			return null;
		}
		List<DebugUIHandlerWidget> activeChildren = GetActiveChildren();
		if (activeChildren.Count == 0)
		{
			return null;
		}
		return activeChildren[activeChildren.Count - 1];
	}

	internal bool IsDirectChild(DebugUIHandlerWidget widget)
	{
		if (contentHolder.childCount == 0)
		{
			return false;
		}
		return GetActiveChildren().Count((DebugUIHandlerWidget x) => x == widget) > 0;
	}

	private List<DebugUIHandlerWidget> GetActiveChildren()
	{
		List<DebugUIHandlerWidget> list = new List<DebugUIHandlerWidget>();
		foreach (Transform item in contentHolder)
		{
			if (item.gameObject.activeInHierarchy)
			{
				DebugUIHandlerWidget component = item.GetComponent<DebugUIHandlerWidget>();
				if (component != null)
				{
					list.Add(component);
				}
			}
		}
		return list;
	}
}
