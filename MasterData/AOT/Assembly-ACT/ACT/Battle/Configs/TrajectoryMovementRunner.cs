using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public abstract class TrajectoryMovementRunner
{
	protected TrajectoryMovementPattern config;

	protected Entity bullet;

	protected RuntimeGeneralTrajectory generalTrajectory;

	protected Ability ability;

	public void Create(TrajectoryMovementPattern config, Entity bullet, RuntimeGeneralTrajectory generalTrajectoryRunner, Ability ability)
	{
		this.config = config;
		this.bullet = bullet;
		generalTrajectory = generalTrajectoryRunner;
		this.ability = ability;
		OnCreate();
	}

	protected abstract void OnCreate();

	public abstract void FixedUpdate(float dt);

	public abstract void Update(float dt);

	public virtual void Reset()
	{
		config = null;
		bullet = default;
		generalTrajectory = null;
		ability = null;
		OnReset();
	}

	protected abstract void OnReset();

	protected void UpdatePositionInterpolation()
	{
		if (bullet.IsLogicAvailable())
		{
			CompTransform compTransform = bullet.GetCompTransform();
			bullet.GetRootTransform().SetPositionAndRotation(Vector3.Lerp(compTransform.lastPhysicsPosition, compTransform.physicsPosition, (Time.time - Time.fixedTime) / Time.fixedDeltaTime), compTransform.rotation);
			compTransform.UpdatePosition(compTransform.physicsPosition);
		}
	}
}
