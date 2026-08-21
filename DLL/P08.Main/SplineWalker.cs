using UnityEngine;

public class SplineWalker : MonoBehaviour
{
	public BezierSpline spline;

	public float duration;

	private float progress;

	public bool lookForward;

	public SplineWalkerMode mode;

	private bool goingForward = true;

	private void Update()
	{
		if (goingForward)
		{
			progress += Time.deltaTime / duration;
			if (progress > 1f)
			{
				if (mode == SplineWalkerMode.Once)
				{
					progress = 1f;
				}
				else if (mode == SplineWalkerMode.Loop)
				{
					progress--;
				}
				else
				{
					progress = 2f - progress;
					goingForward = false;
				}
			}
		}
		else
		{
			progress -= Time.deltaTime / duration;
			if (progress < 0f)
			{
				progress = 0f - progress;
				goingForward = true;
			}
		}
		Vector3 point = spline.GetPoint(progress);
		base.transform.localPosition = point;
		if (lookForward)
		{
			base.transform.LookAt(point + spline.GetDirection(progress));
		}
	}
}
