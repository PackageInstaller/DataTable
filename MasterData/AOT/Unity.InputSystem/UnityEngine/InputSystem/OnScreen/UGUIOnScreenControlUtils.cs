namespace UnityEngine.InputSystem.OnScreen;

internal static class UGUIOnScreenControlUtils
{
	public static RectTransform GetCanvasRectTransform(Transform transform)
	{
		if (!(transform.parent != null))
		{
			return null;
		}
		return transform.parent.GetComponentInParent<RectTransform>();
	}
}
