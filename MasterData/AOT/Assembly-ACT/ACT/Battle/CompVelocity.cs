using UnityEngine;

namespace ACT.Battle;

public class CompVelocity : EcsComponent
{
	public bool pauseVelocity;

	public Vector3 velocity;

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		pauseVelocity = false;
		velocity = Vector3.zero;
	}
}
