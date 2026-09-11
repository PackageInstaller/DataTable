using UnityEngine;

public static class ScreenRotateUtil
{
	public static void ChangeScreenOrientation(ScreenOrientation orientation)
	{
		Screen.orientation = orientation;
	}
}
