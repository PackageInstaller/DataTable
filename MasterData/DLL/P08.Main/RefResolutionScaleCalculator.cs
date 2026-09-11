using UnityEngine;
using UnityEngine.UI;

public struct RefResolutionScaleCalculator
{
	public Vector2 refResolution;

	public CanvasScaler.ScreenMatchMode screenMatchMode;

	public float logBase;

	public float matchWidthOrHeight;

	public float GetScaleFactor(Canvas canvas)
	{
		if (canvas.renderMode == RenderMode.WorldSpace)
		{
			Debug.LogError("RefResolutionScaleCalculator: could not calculate scale factor for WorldSpace Canvas on " + canvas.gameObject.name + "!");
			return 1f;
		}
		Vector2 screenSize = canvas.renderingDisplaySize;
		int targetDisplay = canvas.targetDisplay;
		if (targetDisplay > 0 && targetDisplay < Display.displays.Length)
		{
			Display display = Display.displays[targetDisplay];
			screenSize = new Vector2(display.renderingWidth, display.renderingHeight);
		}
		return GetScaleFactor(screenSize);
	}

	public float GetScaleFactor(Vector2 screenSize)
	{
		float result = 0f;
		switch (screenMatchMode)
		{
		case CanvasScaler.ScreenMatchMode.MatchWidthOrHeight:
		{
			float a = Mathf.Log(screenSize.x / refResolution.x, logBase);
			float b = Mathf.Log(screenSize.y / refResolution.y, logBase);
			float p = Mathf.Lerp(a, b, matchWidthOrHeight);
			result = Mathf.Pow(logBase, p);
			break;
		}
		case CanvasScaler.ScreenMatchMode.Expand:
			result = Mathf.Min(screenSize.x / refResolution.x, screenSize.y / refResolution.y);
			break;
		case CanvasScaler.ScreenMatchMode.Shrink:
			result = Mathf.Max(screenSize.x / refResolution.x, screenSize.y / refResolution.y);
			break;
		}
		return result;
	}
}
