using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
public struct GradientAlphaKey(float alpha, float time)
{
	public float alpha = alpha;

	public float time = time;
}
