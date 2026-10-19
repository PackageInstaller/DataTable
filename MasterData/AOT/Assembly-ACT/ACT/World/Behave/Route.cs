using UnityEngine;

namespace ACT.World.Behave;

public struct Route
{
	public Vector3 startPos;

	public Vector3 controlPos;

	public Vector3 endPos;

	public float precent;

	public Vector3 Evaluate(float time)
	{
		float num = 1f - time;
		return Mathf.Pow(num, 2f) * startPos + 2f * time * num * controlPos + Mathf.Pow(time, 2f) * endPos;
	}
}
