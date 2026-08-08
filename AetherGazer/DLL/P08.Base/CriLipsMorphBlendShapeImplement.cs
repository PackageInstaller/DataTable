using UnityEngine;

internal static class CriLipsMorphBlendShapeImplement
{
	public static void SetBlendShapeWeightSafety(this SkinnedMeshRenderer skinnedMeshRenderer, int index, float weight)
	{
		if (index >= 0 && !(skinnedMeshRenderer == null))
		{
			skinnedMeshRenderer.SetBlendShapeWeight(index, weight);
		}
	}
}
