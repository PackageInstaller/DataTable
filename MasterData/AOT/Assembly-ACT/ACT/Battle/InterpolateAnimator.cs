using UnityEngine;

namespace ACT.Battle;

public class InterpolateAnimator : MonoBehaviour
{
	private Animator _animator;

	private float lastTime;

	private void Awake()
	{
		_animator = GetComponentInChildren<Animator>();
		_animator.enabled = false;
		lastTime = Time.time;
	}

	private void FixedUpdate()
	{
		_animator.Update(Time.fixedTime - lastTime);
		lastTime = Time.fixedTime;
	}

	private void Update()
	{
		_animator.Update(Time.time - lastTime);
		lastTime = Time.time;
	}
}
