using UnityEngine;

public static class ColorUtil
{
	public static Vector3 RGBToHSV(Color rgb)
	{
		Color.RGBToHSV(rgb, out var H, out var S, out var V);
		return new Vector3(H, S, V);
	}
}
