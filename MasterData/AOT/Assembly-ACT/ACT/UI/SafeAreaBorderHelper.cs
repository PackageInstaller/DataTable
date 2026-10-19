using UnityEngine;

namespace ACT.UI;

public static class SafeAreaBorderHelper
{
	public const int BorderMaxPixel = 144;

	public const int BorderMinPixel = 40;

	public const int DesignBorderBaisPixel = 84;

	public const int DesignBorderBaisPixelPC = 40;

	public const float DefaultDesignPixelValueX = 2340f;

	public static float ReturnLegalSafeAreaDefaultValue()
	{
		return Mathf.Clamp(Mathf.Max((1f - Screen.safeArea.width / (float)Screen.width) * 2340f / 2f, 84f), 0f, 144f);
	}
}
