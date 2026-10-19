using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class TrackTargetMovementPattern : TrajectoryMovementPattern
{
	public TrackTargetType trackTargetType;

	public TrackTargetSpeedAxis trackTargetSpeedAxis;

	public Vector2 angleRange = new Vector2(-10f, 10f);

	public Vector2 lenRange = new Vector2(1f, 10f);

	public bool useOwnerAim;

	[Tooltip("如果要使用挂点瞄准,填写挂点,不填就是用Aim IK做瞄准")]
	public string attachPoint;

	public BaseFindTargets findTargets;

	public float speedScale;

	public bool useVelocityDir;

	public float rotateScale;

	public AnimationCurve rotateCutve;

	public float cannottrackDis = 0.15f;

	public bool noTrack = true;

	public bool upwards = true;

	[Space(30f)]
	public float mustTrackTime;

	public float minTime;

	public bool useAimAttachPoint;

	public string AimAttachPoint = "waist";

	public VelocityModifier[] velocityModifiers;

	public override TrajectoryMovementRunner Create(Entity bullet, RuntimeGeneralTrajectory runtimeGeneralTrajectory, Ability ability)
	{
		TrackTargetMovementRunner trackTargetMovementRunner = new TrackTargetMovementRunner();
		trackTargetMovementRunner.Create(this, bullet, runtimeGeneralTrajectory, ability);
		return trackTargetMovementRunner;
	}
}
