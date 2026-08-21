using UnityEngine;
using UnityEngine.UI;

public class BeanAnimationController : MonoBehaviour
{
	private Animator _animtor;

	private AnimationClip _animationClip;

	private Image[] _images;

	public void Init()
	{
		_animtor = GetComponent<Animator>();
		_images = GetComponentsInChildren<Image>();
		_animationClip = _animtor.GetCurrentAnimatorClipInfo(0)[0].clip;
	}

	public void BeanComplete()
	{
		SetEnable(enable: false);
	}

	public void SetEnable(bool enable)
	{
		if (enable)
		{
			_animtor.Play("New Animation", 0, 0f);
			_animtor.Update(0f);
		}
		_animtor.enabled = enable;
		for (int i = 0; i < _images.Length; i++)
		{
			_images[i].enabled = enable;
		}
	}
}
