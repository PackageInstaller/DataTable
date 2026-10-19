using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class CurveMovementPattern : TrajectoryMovementPattern
{
	[Tooltip("特效方向由速度决定，持续更新")]
	public bool useVelocityDir;

	public CurveMovementEndPosType curveMovementEndPos;

	[Tooltip("终点获取")]
	public ConfigFunction<Vector3> endPosition;

	public float bornSpeed;

	[Range(0f, 1f)]
	public float controPoint1Length = 0.5f;

	public float controPoint1Height = 0.5f;

	[Range(-180f, 180f)]
	public float controlPoint1Angle = 0.5f;

	[Range(-1f, 1f)]
	public float controlPoint2Length;

	[Tooltip("控制点2没有用的话，填了高度都没用")]
	public float controlPoint2Height;

	[Range(-180f, 180f)]
	public float controlPoint2Angle = 0.5f;

	public override TrajectoryMovementRunner Create(Entity bullet, RuntimeGeneralTrajectory runtimeGeneralTrajectory, Ability ability)
	{
		CurveMovementRunner curveMovementRunner = new CurveMovementRunner();
		curveMovementRunner.Create(this, bullet, runtimeGeneralTrajectory, ability);
		return curveMovementRunner;
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
	}
}
