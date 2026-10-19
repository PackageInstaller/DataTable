using UnityEngine;

namespace Runtime.AnimatorSnap;

public static class AnimatorExtensions
{
	public static bool HasParameter(this Animator animator, string name)
	{
		AnimatorControllerParameter[] parameters = animator.parameters;
		for (int i = 0; i < parameters.Length; i++)
		{
			if (parameters[i].name == name)
			{
				return true;
			}
		}
		return false;
	}
}
