using UnityEngine;

public class DynamicHeroProxy : MonoBehaviour
{
	public Animator mAnimator;

	public void PlayAnimation(string animName, float crossFade)
	{
		mAnimator?.CrossFade(animName, crossFade, 0, 0f);
	}
}
