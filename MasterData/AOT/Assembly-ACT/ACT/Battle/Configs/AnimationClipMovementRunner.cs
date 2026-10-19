using System;
using System.Collections.Generic;
using ACT.Utility;
using Bamboo.Collections;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class AnimationClipMovementRunner : TrajectoryMovementRunner
{
	public class AttackBox
	{
		public Vector3 pos;

		public float lifeTime;

		public float radius;
	}

	private AnimationCurve m_Xcurve;

	private AnimationCurve m_Ycurve;

	private AnimationCurve m_Zcurve;

	private float m_Time;

	private Vector3 m_IntiPos;

	private Vector3 m_TargetPos;

	private float radius;

	private float lifeTime;

	private float totalDis;

	private int maxCount;

	private float perDis;

	private float speed;

	private Quaternion quaternion;

	public List<AttackBox> AttackBoxes;

	protected override void OnCreate()
	{
		AnimationClipMovementPattern animationClipMovementPattern = (AnimationClipMovementPattern)config;
		CompTransform compTransform = bullet.GetCompTransform();
		m_Xcurve = animationClipMovementPattern.xCurve;
		m_Ycurve = animationClipMovementPattern.yCurve;
		m_Zcurve = animationClipMovementPattern.zCurve;
		m_IntiPos = compTransform.physicsPosition;
		radius = animationClipMovementPattern.radius;
		lifeTime = animationClipMovementPattern.lifeTime;
		maxCount = animationClipMovementPattern.maxCount;
		perDis = animationClipMovementPattern.perDis;
		quaternion = animationClipMovementPattern.quaternion;
		speed = animationClipMovementPattern.speed;
		AttackBoxes = new List<AttackBox>();
	}

	public override void FixedUpdate(float dt)
	{
		if (MathF.Abs(dt - 0f) < 1E-05f)
		{
			return;
		}
		CompTrajectory compTrajectory = bullet.GetCompTrajectory();
		CompTransform compTransform = bullet.GetCompTransform();
		CompVelocity compVelocity = bullet.GetCompVelocity();
		CompAbility compAbility = bullet.GetCompAbility();
		m_TargetPos.x = m_Xcurve.Evaluate(compTrajectory.life * speed);
		m_TargetPos.y = m_Ycurve.Evaluate(compTrajectory.life * speed);
		m_TargetPos.z = m_Zcurve.Evaluate(compTrajectory.life * speed);
		m_TargetPos = quaternion * m_TargetPos;
		m_TargetPos.x += m_IntiPos.x;
		m_TargetPos.y += m_IntiPos.y;
		m_TargetPos.z += m_IntiPos.z;
		compVelocity.velocity = (m_TargetPos - compTransform.physicsPosition) / dt;
		(Vector3, Vector3, Quaternion) state = (compVelocity.velocity, compTransform.physicsPosition, compTransform.rotation);
		(Entity, Ability, float) message = (bullet, ability, dt);
		generalTrajectory.Evaluate(in message, in state, out (Vector3, Vector3, Quaternion) nextState);
		totalDis += (m_TargetPos - compTransform.physicsPosition).magnitude;
		if (totalDis >= perDis && AttackBoxes.Count < maxCount)
		{
			totalDis = 0f;
			AttackBox item = new AttackBox
			{
				pos = compTransform.physicsPosition,
				lifeTime = lifeTime,
				radius = radius
			};
			AttackBoxes.Add(item);
		}
		for (int num = AttackBoxes.Count - 1; num >= 0; num--)
		{
			AttackBox attackBox = AttackBoxes[num];
			attackBox.lifeTime--;
			if (attackBox.lifeTime <= 0f)
			{
				AttackBoxes.RemoveAt(num);
			}
			else
			{
				BSet<FindTargetResult> bSet = BSetPool<FindTargetResult>.Default.Get();
				WhereTargets whereTargets = generalTrajectory.CreateWhereTargets(bullet, canBeAttack: true);
				bool flag = false;
				Collider collider = null;
				Collider[] cacheColliders = PhysicsUtility.cacheColliders;
				if (Physics.OverlapSphereNonAlloc(attackBox.pos, radius, cacheColliders, BattleConsts.enviromentMask | BattleConsts.hitMask) > 0)
				{
					Collider[] array = cacheColliders;
					foreach (Collider collider2 in array)
					{
						if (collider2 == null)
						{
							break;
						}
						if (compTrajectory.ShouldIgnoreEnvironmentCollision(collider2))
						{
							continue;
						}
						if (BattleConsts.hitMask == (BattleConsts.hitMask | (1 << collider2.gameObject.layer)))
						{
							var (flag2, result) = BaseFindTargetsByArea.GetResult(state.Item2, collider2, Vector3.zero);
							if (flag2)
							{
								BaseFindTargetsByArea.AddTarget(result, bSet);
							}
						}
						else
						{
							flag = true;
							if (collider == null)
							{
								collider = collider2;
							}
						}
					}
					whereTargets.FindTargets(bSet, bullet);
					foreach (FindTargetResult item2 in bSet)
					{
						if (!compAbility.IsHited(item2, null))
						{
							generalTrajectory.hitPattern.OnHitEntity(bullet, item2, message.Item2);
							if (compTrajectory.lifeEnd)
							{
								break;
							}
						}
					}
					if (flag && !generalTrajectory.hitPattern.IgnoreEnvironment(bullet))
					{
						generalTrajectory.hitPattern.OnHitEnvironment(bullet, message.Item2, collider, Vector3.zero);
					}
				}
				PhysicsUtility.Release(cacheColliders);
			}
		}
		compTransform.UpdatePosition(nextState.Item2);
	}

	public override void Update(float dt)
	{
		UpdatePositionInterpolation();
	}

	protected override void OnReset()
	{
		AttackBoxes.Clear();
	}
}
