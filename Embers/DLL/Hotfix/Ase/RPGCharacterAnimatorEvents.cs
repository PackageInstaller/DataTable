using UnityEngine;

namespace Ase;

public class RPGCharacterAnimatorEvents : MonoBehaviour
{
	private bool _enableMove;

	private Animator _animator;

	private Transform _root;

	public void Init(Animator animator, Transform root)
	{
		_animator = animator;
		_root = root;
	}

	public void OpenAnimatorMovement(bool enableMove)
	{
		_enableMove = enableMove;
	}

	private void OnAnimatorMove()
	{
		if ((bool)(Object)(object)_animator && _enableMove)
		{
			_root.position += _animator.deltaPosition;
			_root.rotation = _animator.rootRotation;
		}
	}
}
