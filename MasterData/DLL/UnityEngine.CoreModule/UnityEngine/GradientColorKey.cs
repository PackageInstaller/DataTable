using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
public struct GradientColorKey(Color col, float time)
{
	public Color color = col;

	public float time = time;
}
