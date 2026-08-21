using System.Collections.Generic;
using Ase.ECS;
using UnityEngine;

namespace Ase;

public class KinematicCharacterSystem : BaseSystem
{
	private List<MovementMotorBase> _characterMotors = new List<MovementMotorBase>();

	private List<PhysicsMover> _physicsMovers = new List<PhysicsMover>();

	private float _lastCustomInterpolationStartTime = -1f;

	private float _lastCustomInterpolationDeltaTime = -1f;

	public bool AutoSimulation = true;

	protected override bool IsLogicSystem => true;

	public override bool NeedPauseSystem => false;

	public override void OnDispose()
	{
		base.OnDispose();
		_characterMotors.Clear();
		_characterMotors = null;
		_physicsMovers.Clear();
		_physicsMovers = null;
	}

	public void SetCharacterMotorsCapacity(int capacity)
	{
		if (capacity < _characterMotors.Count)
		{
			capacity = _characterMotors.Count;
		}
		_characterMotors.Capacity = capacity;
	}

	public void RegisterCharacterMotor(MovementMotorBase movementMotor)
	{
		_characterMotors.Add(movementMotor);
	}

	public void UnregisterCharacterMotor(MovementMotorBase movementMotor)
	{
		_characterMotors.Remove(movementMotor);
	}

	public void RegisterPhysicsMover(PhysicsMover mover)
	{
		_physicsMovers.Add(mover);
		mover.Rigidbody.interpolation = (RigidbodyInterpolation)0;
	}

	public void UnregisterPhysicsMover(PhysicsMover mover)
	{
		if (world != null)
		{
			_physicsMovers.IndexOf(mover);
			_physicsMovers.Remove(mover);
		}
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		if (world.IsStoryWorld)
		{
			for (int i = 0; i < _physicsMovers.Count; i++)
			{
				_physicsMovers[i].OnUpdate(deltaTime);
			}
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (AutoSimulation)
		{
			Simulate(deltaTime, _characterMotors, _physicsMovers);
		}
	}

	private void Simulate(float deltaTime, List<MovementMotorBase> motors, List<PhysicsMover> movers)
	{
		int count = motors.Count;
		int count2 = movers.Count;
		if (world.IsStoryWorld)
		{
			for (int i = 0; i < count2; i++)
			{
				movers[i].VelocityUpdate(deltaTime);
			}
		}
		for (int j = 0; j < count; j++)
		{
			if (motors[j].Entity.CacheTickUpdate || world.IsStoryWorld)
			{
				motors[j].UpdatePhase1(deltaTime);
			}
		}
		if (world.IsStoryWorld)
		{
			for (int k = 0; k < count2; k++)
			{
				PhysicsMover physicsMover = movers[k];
				physicsMover.Transform.SetPositionAndRotation(physicsMover.TransientPosition, physicsMover.TransientRotation);
				physicsMover.Rigidbody.position = physicsMover.TransientPosition;
				physicsMover.Rigidbody.rotation = physicsMover.TransientRotation;
			}
		}
		for (int l = 0; l < count; l++)
		{
			MovementMotorBase movementMotorBase = motors[l];
			if (movementMotorBase.Entity.CacheTickUpdate || world.IsStoryWorld)
			{
				movementMotorBase.UpdatePhase2(deltaTime);
				movementMotorBase.SetPositionAndRotation(movementMotorBase.TransientPosition, movementMotorBase.TransientRotation);
			}
		}
	}
}
