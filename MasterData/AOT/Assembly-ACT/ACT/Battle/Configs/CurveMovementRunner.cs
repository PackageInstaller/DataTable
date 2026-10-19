using Bamboo.ECS;
using Cinemachine.Utility;
using UnityEngine;

namespace ACT.Battle.Configs;

public class CurveMovementRunner : TrajectoryMovementRunner
{
	private Vector3 startPosition;

	private Vector3 endPosition;

	private Vector3 controlPoint1Pos;

	private Vector3 controlPoint2Pos;

	private float bezierTime;

	private float runTime;

	private float runTimeNormalize;

	public Vector3 lastVelocity;

	protected override void OnCreate()
	{
		CurveMovementPattern curveMovementPattern = (CurveMovementPattern)config;
		CompTransform compTransform = bullet.GetCompTransform();
		CompVelocity compVelocity = bullet.GetCompVelocity();
		startPosition = compTransform.physicsPosition;
		ActionMemory memory = new ActionMemory(bullet.GetCompProduct().caster, bullet, bullet, null, ability);
		endPosition = curveMovementPattern.endPosition.Return(memory);
		compVelocity.velocity = Vector3.zero;
		if (curveMovementPattern.useVelocityDir)
		{
			compTransform.rotation = Quaternion.FromToRotation(Vector3.forward, compVelocity.velocity);
		}
		bullet.GetRootTransform().rotation = compTransform.rotation;
		Quaternion quaternion = Quaternion.FromToRotation(Vector3.forward, endPosition);
		Quaternion quaternion2 = Quaternion.AngleAxis(curveMovementPattern.controlPoint1Angle, Vector3.forward);
		Quaternion quaternion3 = Quaternion.AngleAxis(curveMovementPattern.controlPoint2Angle, Vector3.forward);
		Vector3 vector = quaternion * quaternion2 * Vector3.left;
		Vector3 vector2 = quaternion * quaternion3 * Vector3.left;
		Vector3 vector3 = Vector3.Lerp(startPosition, endPosition, curveMovementPattern.controlPoint2Length);
		Vector3 vector4 = Vector3.Lerp(startPosition, endPosition, curveMovementPattern.controlPoint2Length);
		controlPoint1Pos = vector3 + vector * curveMovementPattern.controPoint1Height;
		controlPoint2Pos = vector4 + vector2 * curveMovementPattern.controlPoint2Height;
		if (curveMovementPattern.controlPoint2Length < 0f)
		{
			controlPoint2Pos = controlPoint1Pos;
		}
		bezierTime = (endPosition - startPosition).magnitude / curveMovementPattern.bornSpeed;
		runTime = 0f;
		lastVelocity = Vector3.zero;
	}

	public override void FixedUpdate(float dt)
	{
		CurveMovementPattern curveMovementPattern = (CurveMovementPattern)config;
		runTime += dt;
		runTimeNormalize = runTime / bezierTime;
		CompVelocity compVelocity = bullet.GetCompVelocity();
		CompTransform compTransform = bullet.GetCompTransform();
		if (bullet.IsActive() && runTimeNormalize < 1f)
		{
			Vector3 vector = SplineHelpers.Bezier3(runTimeNormalize, startPosition, controlPoint1Pos, controlPoint2Pos, endPosition);
			compVelocity.velocity = ((dt == 0f) ? Vector3.zero : ((vector - compTransform.physicsPosition) / dt));
		}
		else
		{
			compVelocity.velocity = lastVelocity;
		}
		(Vector3, Vector3, Quaternion) state = (compVelocity.velocity, compTransform.physicsPosition, compTransform.rotation);
		(Entity, Ability, float) message = (bullet, ability, dt);
		generalTrajectory.Evaluate(in message, in state, out (Vector3, Vector3, Quaternion) nextState);
		lastVelocity = compVelocity.velocity;
		compTransform.UpdatePosition(nextState.Item2);
		if (curveMovementPattern.useVelocityDir)
		{
			compTransform.rotation = Quaternion.FromToRotation(Vector3.forward, compVelocity.velocity);
		}
	}

	public override void Update(float dt)
	{
		UpdatePositionInterpolation();
	}

	protected override void OnReset()
	{
	}
}
