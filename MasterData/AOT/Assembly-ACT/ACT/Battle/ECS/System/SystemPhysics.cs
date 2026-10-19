using System;
using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using EasyCharacterMovement;
using UnityEngine;

namespace ACT.Battle.ECS.System;

public class SystemPhysics : EntitySystem
{
	private Filter _filter;

	private EntityAction<CompPhysics, CompTransform, CompTime> _lateFixedUpdateEntityAction;

	private EntityAction<CompPhysics> _updateEntityAction;

	public override Filter MajorFilter => _filter;

	private float interpolationFactor { get; set; }

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompTransform, CompTime, CompInput, CompMotion, CompPhysics, CompEffect>().Build();
		_lateFixedUpdateEntityAction = LateFixedUpdateEntity;
		_updateEntityAction = UpdateEntity;
	}

	internal void SetRotateImmediately(Entity entity, bool faceLeft)
	{
		entity.SetFaceLeft(faceLeft);
		entity.GetCompPhysics()?.SetDirImmediately();
	}

	public override void LateFixedUpdate()
	{
		_filter.ForEach(_lateFixedUpdateEntityAction);
	}

	private void LateFixedUpdateEntity(Entity entity, CompPhysics compPhysics, CompTransform compTransform, CompTime compTime)
	{
		if (!entity.IsActive() || !entity.IsTickAvailable())
		{
			return;
		}
		if (compPhysics.state == ACTMovementMode.None)
		{
			if (entity.GetConfig().enableRootMotionWhenPhysicsNone)
			{
				compPhysics.SimulateRootMotionOnly(compTime.physicsFixedDeltalTime);
			}
			return;
		}
		if (!Mathf.Approximately(compTransform.compensationProgress, 1f))
		{
			Vector3 zero = Vector3.zero;
			_ = Vector3.zero;
			float num = InterpolationUtility.FixedLerp(compTransform.compensationProgress, 1f, (compTransform.compensationDuration == 0f) ? 1f : (compTime.motionFixedDeltaTime / compTransform.compensationDuration), out var actualDelta);
			if (compTransform.compensationCurve != null)
			{
				float num2 = compTransform.compensationCurve.Height();
				actualDelta = ((num2 != 0f) ? ((compTransform.compensationCurve.Evaluate(num) - compTransform.compensationCurve.Evaluate(compTransform.compensationProgress)) / num2) : 0f);
			}
			zero = compTransform.compensation * actualDelta;
			compTransform.compensationProgress = num;
			float motionFixedDeltaTime = compTime.motionFixedDeltaTime;
			if (motionFixedDeltaTime != 0f)
			{
				Vector3 force = zero / motionFixedDeltaTime;
				compPhysics.characterMovement.AddForce(force, ForceMode.VelocityChange);
			}
			if (num >= 1f)
			{
				compTransform.onCompensationComplete?.Invoke();
			}
		}
		if (!Mathf.Approximately(compTransform.tractionProgress, 1f))
		{
			float tractionProgress = ((compTransform.tractionDuration == 0f) ? InterpolationUtility.FixedLerp(compTransform.tractionProgress, 1f, compTime.physicsFixedDeltalTime / 0.02f) : InterpolationUtility.FixedLerp(compTransform.tractionProgress, 1f, compTime.physicsFixedDeltalTime / compTransform.tractionDuration));
			compTransform.tractionProgress = tractionProgress;
			float num3 = 0.02f;
			if (num3 != 0f)
			{
				Vector2 vector = compTransform.tractionOffset / num3;
				compPhysics.characterMovement.AddForce(vector, ForceMode.VelocityChange);
			}
		}
		compPhysics.Simulate(compTime.physicsFixedDeltalTime);
		compPhysics.UpdateSensor();
	}

	public override void Update()
	{
		interpolationFactor = (Time.time - Time.fixedTime) / Time.fixedDeltaTime;
		_filter.ForEachStable(_updateEntityAction);
	}

	private void UpdateEntity(Entity entity, CompPhysics compPhysics)
	{
		if (entity.IsTickAvailable())
		{
			compPhysics.InterpolationPathOrientation = Quaternion.Slerp(compPhysics.LastOnPathOrientation, compPhysics.OnPathOrientation, interpolationFactor);
		}
	}

	protected override void OnPause()
	{
	}

	protected override void OnResume()
	{
	}

	public void OnSpawn(Entity entity, bool faceLeft)
	{
		ConfigCharacter config = entity.GetConfig();
		CompPhysics compPhysics = entity.GetCompPhysics();
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
		CompMotion? compMotion = entity.GetCompMotion();
		compMotion.onMotionChange = (Action<MotionState, MotionState>)Delegate.Combine(compMotion.onMotionChange, new Action<MotionState, MotionState>(compPhysics.OnMotionStateChanged));
		CharacterMovement characterMovement2 = compPhysics.characterMovement;
		compPhysics.SetDefaultEcm2Params(new CompPhysics.ECM2PARAMS
		{
			radius = characterMovement2.radius,
			height = characterMovement2.height,
			rootTransformOffset = characterMovement2.rootTransformOffset
		});
	}

	public void ForceToGround(Entity entity)
	{
		CompTransform compTransform = entity.GetCompTransform();
		Vector3 physicsPosition = compTransform.physicsPosition;
		physicsPosition = PhysicsUtility.GetGroundPoint(physicsPosition + compTransform.center, compTransform.size) - compTransform.center;
		entity.Teleport(physicsPosition);
	}
}
