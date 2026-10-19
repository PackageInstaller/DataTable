using UnityEngine;

namespace frame8.Logic.Misc.Visual.UI;

public static class IScrollRectProxyExtensions
{
	public static double GetScrollableArea(this IScrollRectProxy proxy)
	{
		return proxy.GetContentSize() - proxy.GetViewportSize();
	}

	public static double GetContentSizeToViewportRatio(this IScrollRectProxy proxy)
	{
		return proxy.GetContentSize() / proxy.GetViewportSize();
	}

	public static RectTransform.Edge GetStartEdge(this IScrollRectProxy proxy)
	{
		if (!proxy.IsHorizontal)
		{
			return RectTransform.Edge.Top;
		}
		return RectTransform.Edge.Left;
	}

	public static RectTransform.Edge GetEndEdge(this IScrollRectProxy proxy)
	{
		if (!proxy.IsHorizontal)
		{
			return RectTransform.Edge.Bottom;
		}
		return RectTransform.Edge.Right;
	}
}
