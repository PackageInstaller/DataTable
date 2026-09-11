using UnityEngine;

[RequireComponent(typeof(LineRenderer))]
public class LineWidthCurverController : MonoBehaviour
{
	public float Width;

	private LineRenderer lineRenderer;

	private AnimationCurve curve = new AnimationCurve();

	private void Awake()
	{
		lineRenderer = U3DUtil.Get<LineRenderer>(base.gameObject);
		curve.AddKey(0f, 1f);
	}

	private void Update()
	{
		if (lineRenderer.enabled)
		{
			Keyframe[] keys = curve.keys;
			keys[0].value = Width;
			curve.keys = keys;
			lineRenderer.widthCurve = curve;
		}
	}
}
