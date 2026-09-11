using UnityEngine;

[RequireComponent(typeof(Animator))]
public class AnimatorFixer : MonoBehaviour
{
	private Animator _animator;

	private bool _active;

	private bool _justAwake = true;

	private void Awake()
	{
		_animator = GetComponent<Animator>();
		_justAwake = true;
	}

	private void OnEnable()
	{
		if (!_justAwake)
		{
			_animator.Update(0f);
		}
		else
		{
			_justAwake = false;
		}
	}
}
