using UnityEngine;
using UnityEngine.UI;

namespace Suriyun.MCS;

[DefaultExecutionOrder(-1200)]
public class UIScaler : MonoBehaviour
{
	public enum UIScaleMode
	{
		Variable
	}

	public CanvasScaler scaler;

	public float refDPI;

	public float refScaleFactor;

	public float refWidth;

	public float refHeight;

	public float refInches;

	public float refDiagonalInches;

	public float preferredScaleFactor;

	public UIScaleMode scaleMode;

	public AnimationCurve scaleByScreenSizeInches;

	public AnimationCurve scaleMultiplierByDpi;

	public AnimationCurve scaleMultiplierByAspectRatio;

	protected virtual void Awake()
	{
		refDPI = 458f;
		refWidth = 3200f;
		refHeight = 1440f;
		refInches = refWidth / refDPI;
		refDiagonalInches = 6.465209f;
		refScaleFactor = 2.061925f;
		UpdateScale();
	}

	public void UpdateScale()
	{
		if (scaleMode == UIScaleMode.Variable)
		{
			preferredScaleFactor = refScaleFactor * (float)Screen.width / refWidth * scaleMultiplierByDpi.Evaluate(Screen.dpi) * scaleMultiplierByAspectRatio.Evaluate((float)Screen.width / (float)Screen.height);
		}
		scaler.scaleFactor = preferredScaleFactor;
		LogScaleInfo();
	}

	protected void LogScaleInfo()
	{
	}

	public float GetDiagonalPixel(int w, int h)
	{
		return Mathf.Sqrt(Mathf.Pow(w, 2f) + Mathf.Pow(h, 2f));
	}

	public float GetDiagonalInches(int w, int h, float dpi)
	{
		return GetDiagonalPixel(w, h) / dpi;
	}
}
