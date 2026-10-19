using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class GeneralMovementPattern : TrajectoryMovementPattern
{
	[Tooltip("使用子弹自身坐标系")]
	public bool useLocalCoordinate;

	[Tooltip(",速度方向决定发射方向")]
	public Vector3 initSpeed;

	public Vector3 initRotate;

	[Tooltip("初始方向由瞄准决定")]
	public bool useOwnerAim;

	[Tooltip("使用发射时设定的")]
	public bool useAim;

	[Tooltip("使用子弹的生成的旋转方向")]
	public bool useRotation;

	public bool useDefaultVelocity;

	public InitVelocityMode initVelocityMode;

	[Space(30f)]
	public string attachPoint;

	public VelocityModifier[] velocityModifiers;

	public bool useVelocityDir;

	public bool useRotate;

	public float angleDegreeSpeed;

	public Vector3 axis;

	public override TrajectoryMovementRunner Create(Entity bullet, RuntimeGeneralTrajectory runtimeGeneralTrajectory, Ability ability)
	{
		GeneralMovementRunner generalMovementRunner = new GeneralMovementRunner();
		generalMovementRunner.Create(this, bullet, runtimeGeneralTrajectory, ability);
		return generalMovementRunner;
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
	}
}
