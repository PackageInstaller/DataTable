using ACT.UI;
using UnityEngine;

namespace ACT.Battle;

public class AreaNameData : MonoBehaviour
{
	public MapScaleLevel areaNameLevel;

	public Color originColor;

	public float curAlpha;

	public Color CurColor
	{
		get
		{
			Color result = originColor;
			result.a = curAlpha;
			return result;
		}
	}
}
