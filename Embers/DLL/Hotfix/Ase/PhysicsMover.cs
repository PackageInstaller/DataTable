using System;
using Ase.ECS;
using Unity.Collections;
using UnityEngine;

namespace Ase;

[RequireComponent(typeof(Rigidbody))]
public class PhysicsMover : MonoBehaviour, IInit
{
	private SceneSystem sceneSystem;

	private KinematicCharacterSystem kinematicCharacterSystem;

	[ReadOnly]
	public Rigidbody Rigidbody;

	public bool MoveWithPhysics = true;

	[NonSerialized]
	public IMoverController MoverController;

	[NonSerialized]
	public Vector3 LatestInterpolationPosition;

	[NonSerialized]
	public Quaternion LatestInterpolationRotation;

	[NonSerialized]
	public Vector3 PositionDeltaFromInterpolation;

	[NonSerialized]
	public Quaternion RotationDeltaFromInterpolation;

	private Vector3 _internalTransientPosition;

	private Quaternion _internalTransientRotation;

	public int IndexInCharacterSystem { get; set; }

	public Vector3 Velocity { get; protected set; }

	public Vector3 AngularVelocity { get; protected set; }

	public Vector3 InitialTickPosition { get; set; }

	public Quaternion InitialTickRotation { get; set; }

	public Transform Transform { get; private set; }

	public Vector3 InitialSimulationPosition { get; private set; }

	public Quaternion InitialSimulationRotation { get; private set; }

	public Vector3 TransientPosition
	{
		get
		{
			return _internalTransientPosition;
		}
		private set
		{
			_internalTransientPosition = value;
		}
	}

	public Quaternion TransientRotation
	{
		get
		{
			return _internalTransientRotation;
		}
		private set
		{
			_internalTransientRotation = value;
		}
	}

	public void OnInit(object data = null)
	{
		sceneSystem = (SceneSystem)data;
		kinematicCharacterSystem = sceneSystem.GetSystem<KinematicCharacterSystem>();
		kinematicCharacterSystem.RegisterPhysicsMover(this);
		Transform = base.transform;
		Rigidbody = base.gameObject.GetComponent<Rigidbody>();
		Rigidbody.centerOfMass = Vector3.zero;
		Rigidbody.maxAngularVelocity = float.PositiveInfinity;
		Rigidbody.maxDepenetrationVelocity = float.PositiveInfinity;
		Rigidbody.isKinematic = true;
		Rigidbody.interpolation = (RigidbodyInterpolation)0;
		TransientPosition = Rigidbody.position;
		TransientRotation = Rigidbody.rotation;
		InitialSimulationPosition = Rigidbody.position;
		InitialSimulationRotation = Rigidbody.rotation;
		LatestInterpolationPosition = Transform.position;
		LatestInterpolationRotation = Transform.rotation;
	}

	private void OnDestroy()
	{
		kinematicCharacterSystem.UnregisterPhysicsMover(this);
		sceneSystem = null;
		kinematicCharacterSystem = null;
	}

	public void SetPosition(Vector3 position)
	{
		Transform.position = position;
		Rigidbody.position = position;
		InitialSimulationPosition = position;
		TransientPosition = position;
	}

	public void SetRotation(Quaternion rotation)
	{
		Transform.rotation = rotation;
		Rigidbody.rotation = rotation;
		InitialSimulationRotation = rotation;
		TransientRotation = rotation;
	}

	public void SetPositionAndRotation(Vector3 position, Quaternion rotation)
	{
		Transform.SetPositionAndRotation(position, rotation);
		Rigidbody.position = position;
		Rigidbody.rotation = rotation;
		InitialSimulationPosition = position;
		InitialSimulationRotation = rotation;
		TransientPosition = position;
		TransientRotation = rotation;
	}

	public PhysicsMoverState GetState()
	{
		return new PhysicsMoverState
		{
			Position = TransientPosition,
			Rotation = TransientRotation,
			Velocity = Velocity,
			AngularVelocity = AngularVelocity
		};
	}

	public void ApplyState(PhysicsMoverState state)
	{
		SetPositionAndRotation(state.Position, state.Rotation);
		Velocity = state.Velocity;
		AngularVelocity = state.AngularVelocity;
	}

	public void VelocityUpdate(float deltaTime)
	{
		InitialSimulationPosition = TransientPosition;
		InitialSimulationRotation = TransientRotation;
		MoverController.UpdateMovement(out _internalTransientPosition, out _internalTransientRotation, deltaTime);
		if (deltaTime > 0f)
		{
			Velocity = (TransientPosition - InitialSimulationPosition) / deltaTime;
			AngularVelocity = MathF.PI / 180f * (TransientRotation * Quaternion.Inverse(InitialSimulationRotation)).eulerAngles / deltaTime;
		}
	}

	public void OnUpdate(float deltaTime)
	{
		MoverController.OnUpdate(deltaTime);
	}

	public T GetSystem<T>() where T : BaseSystem
	{
		return sceneSystem.GetSystem<T>();
	}
}
