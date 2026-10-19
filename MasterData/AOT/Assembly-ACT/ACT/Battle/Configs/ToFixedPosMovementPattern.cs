using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ToFixedPosMovementPattern : TrajectoryMovementPattern
{
	public ConfigFunction<Vector3> targetPos;

	public bool updateTargetPos;

	public bool fixedSpeed;

	public float speed;

	public bool fixedTime;

	public float time;

	[Tooltip("为True则特效的方向跟随速度，方向会持续更新")]
	public bool useVelocityDir;

	public bool upwards;

	public ConfigAction[] onArriveTarget;

	public bool arriveDontDie;

	private void OnFixedSpeedChange()
	{
		fixedTime = !fixedSpeed;
	}

	private void OnFixedPosChange()
	{
		fixedSpeed = !fixedTime;
	}

	public override TrajectoryMovementRunner Create(Entity bullet, RuntimeGeneralTrajectory runtimeGeneralTrajectory, Ability ability)
	{
		ToFixedPosMovementRunner toFixedPosMovementRunner = new ToFixedPosMovementRunner();
		toFixedPosMovementRunner.Create(this, bullet, runtimeGeneralTrajectory, ability);
		return toFixedPosMovementRunner;
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, onArriveTarget, ab);
	}
}
