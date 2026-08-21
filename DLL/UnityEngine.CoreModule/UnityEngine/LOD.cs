using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
public struct LOD(float screenRelativeTransitionHeight, Renderer[] renderers)
{
	public float screenRelativeTransitionHeight = screenRelativeTransitionHeight;

	public float fadeTransitionWidth = 0f;

	public Renderer[] renderers = renderers;
}
