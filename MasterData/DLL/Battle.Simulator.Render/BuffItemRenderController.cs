using UnityEngine;

public class BuffItemRenderController : MonoBehaviour
{
	public Animator mAnimator;

	public void SetTrigger(string name)
	{
		if (!(mAnimator == null))
		{
			mAnimator.SetTrigger(name);
		}
	}
}
