using UnityEngine;

namespace Ase;

public class ExampleMovingPlatform : MovingPlatform
{
	public Vector3 TranslationAxis = Vector3.right;

	public float Speed;

	public float BgSpeed;

	public Material BackgroundMaterial;

	public bool platformMove;

	protected override bool IsRunning => false;

	protected override void OnUpdateMovement(out Vector3 goalPosition, out Quaternion goalRotation, float deltaTime)
	{
		if (platformMove)
		{
			goalPosition = Mover.TransientPosition + TranslationAxis * (Speed * deltaTime);
			goalRotation = Mover.TransientRotation;
		}
		else
		{
			goalPosition = Mover.TransientPosition;
			goalRotation = Mover.TransientRotation;
			BackgroundMaterial.mainTextureOffset += TranslationAxis.ToVector2() * BgSpeed * deltaTime;
		}
	}

	protected override void GetMoveSpeedZero()
	{
	}
}
