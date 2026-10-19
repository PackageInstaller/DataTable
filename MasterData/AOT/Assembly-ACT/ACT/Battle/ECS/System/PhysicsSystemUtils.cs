using System;
using ACT.Battle.Configs;
using Bamboo.ECS;
using EasyCharacterMovement;

namespace ACT.Battle.ECS.System;

internal static class PhysicsSystemUtils
{
	public static void SpawnEntity(Entity entity, bool faceLeft)
	{
		CompMotion? compMotion = entity.GetCompMotion();
		CompPhysics compPhysics = entity.GetCompPhysics();
		ConfigCharacter config = entity.GetConfig();
		compPhysics.characterMovement = entity.GetRoot().GetComponent<CharacterMovement>();
		compPhysics.characterMovement.position = entity.GetCompTransform().physicsPosition;
		compPhysics.BindInterface();
		MonoEntity mono = entity.GetMono();
		mono.onDisable += compPhysics.OnMonoDisable;
		mono.onDestroy += compPhysics.OnMonoDestroy;
		entity.SetFaceLeft(faceLeft);
		if (CompPhysics.IsGroundLikeMotion(compPhysics.motion))
		{
			compPhysics.SetMovementMode(ACTMovementMode.Walking);
		}
		else if (compPhysics.motion == MotionType.Air)
		{
			compPhysics.SetMovementMode(ACTMovementMode.Flying);
		}
		else if (compPhysics.motion == MotionType.Orbital360)
		{
			compPhysics.SetMovementMode(ACTMovementMode.Orbital360);
		}
		else
		{
			compPhysics.SetMovementMode(ACTMovementMode.None);
		}
		if (entity.TryGetCompInput(out CompInput component))
		{
			CompInput compInput = component;
			InputDirMode inputDirMode = ((compPhysics.motion == MotionType.Air) ? InputDirMode.Gimbal : InputDirMode.FourDirection);
			compInput.inputDirMode = inputDirMode;
		}
		compPhysics.config = config.physics;
		compPhysics.characterMovement.rigidbody.mass = config.mass;
		compPhysics.characterMovement.slopeLimitOverride = true;
		entity.SetFaceLeft(faceLeft);
		compPhysics.InitRotation(faceLeft);
		CharacterMovement characterMovement = compPhysics.characterMovement;
		characterMovement.detectCollisionsAction = (Action<bool>)Delegate.Combine(characterMovement.detectCollisionsAction, new Action<bool>(compPhysics.DetectCollisionsChange));
		compPhysics.overlapEntityMode = config.physics.OverlapEntityMode;
		compMotion.onMotionChange = (Action<MotionState, MotionState>)Delegate.Combine(compMotion.onMotionChange, new Action<MotionState, MotionState>(compPhysics.OnMotionStateChanged));
		CharacterMovement characterMovement2 = compPhysics.characterMovement;
		compPhysics.SetDefaultEcm2Params(new CompPhysics.ECM2PARAMS
		{
			radius = characterMovement2.radius,
			height = characterMovement2.height,
			rootTransformOffset = characterMovement2.rootTransformOffset
		});
	}
}
