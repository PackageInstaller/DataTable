using UnityEngine;

namespace Cinemachine.Utility;

public static class UnityRectExtensions
{
	public static Rect Inflated(this Rect r, Vector2 delta)
	{
		return new Rect(r.xMin - delta.x, r.yMin - delta.y, r.width + delta.x * 2f, r.height + delta.y * 2f);
	}
}
