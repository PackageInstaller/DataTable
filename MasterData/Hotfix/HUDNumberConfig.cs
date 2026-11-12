using UnityEngine;

[CreateAssetMenu]
public class HUDNumberConfig : ScriptableObject
{
	[Space]
	public AnimationCurve fadeOutTranslateCurve;

	public float fadeOutTranslateCurveScale = 1f;

	public AnimationCurve fadeOutScaleCurve;

	public float fadeOutScaleCurveScale = 1f;

	public Gradient fadeOutGradient;

	[Space]
	public float continueTimeMin;

	public float continueTimeMax = 1f;

	public AnimationCurve translateCurveX;

	public float translateCurveScaleX = 1f;

	public AnimationCurve translateCurveY;

	public float translateCurveScaleY = 1f;

	public AnimationCurve scaleCurve;

	public float scaleCurveScale = 1f;

	public Gradient texGradient;

	[Header("xStarPos:")]
	public Vector2 starPosXRange;

	[Header("yStarPos:")]
	public Vector2 starPosYRange;
}
