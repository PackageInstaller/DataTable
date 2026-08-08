using UnityEngine;

internal static class CriLipsMorphAnimatorImplement
{
	public static void PlaySafety(this Animator animator, int stateNameHash, int layer, float normalizedTime)
	{
		if (stateNameHash != 0 && !(animator == null))
		{
			animator.Play(stateNameHash, layer, normalizedTime);
		}
	}
}
