using System;
using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

public class TrackTargetMovementRunner : TrajectoryMovementRunner
{
	private new TrackTargetMovementPattern config;

	private List<FindTargetResult> findTargetResults;

	private WhereTargets where;

	private FindTargetResult m_FindTargetResult;

	private TrajectoryHitPattern m_TargetHitPattern;

	private float trackTime;

	private bool canTrack;

	private float realTrackSpeed;

	private Vector3 spawnVelocity;

	private float m_SqrMax;

	private float m_SqrMin;

	protected override void OnCreate()
	{
		realTrackSpeed = (trackTime = 0f);
		canTrack = true;
		TrackTargetMovementPattern trackTargetMovementPattern = (TrackTargetMovementPattern)base.config;
		bool flag = false;
		Vector3 toDirection = Vector3.zero;
		CompVelocity compVelocity = bullet.GetCompVelocity();
		CompProduct compProduct = bullet.GetCompProduct();
		CompTransform compTransform = bullet.GetCompTransform();
		Transform rootTransform = bullet.GetRootTransform();
		if (trackTargetMovementPattern.useOwnerAim)
		{
			if (!string.IsNullOrEmpty(trackTargetMovementPattern.attachPoint))
			{
				toDirection = ability.caster.GetMono().GetAttachPointAll(trackTargetMovementPattern.attachPoint).GetForward();
				flag = true;
			}
			else
			{
				CompAim compAim = compProduct.productOwner.GetCompAim();
				if (compAim != null && compAim.aiming)
				{
					toDirection = compAim.aimTargetPosition - compAim.ikOriginTrans.position;
					compAim.rotate = false;
					flag = true;
				}
				else if (LuminApplication.LogEnabled)
				{
					Debug.LogWarning(ability.config.name + "启用了瞄准方向,但是没有匹配到可用的瞄准点");
				}
			}
		}
		if (trackTargetMovementPattern.useOwnerAim & flag)
		{
			Quaternion quaternion = Quaternion.FromToRotation(Vector3.forward, toDirection);
			compVelocity.velocity = quaternion * Vector3.forward * trackTargetMovementPattern.speedScale;
			rootTransform.rotation = quaternion;
		}
		m_TargetHitPattern = generalTrajectory.hitPattern;
		where = generalTrajectory.CreateWhereTargets(bullet);
		findTargetResults = ListPool<FindTargetResult>.Get();
		trackTargetMovementPattern.findTargets.FindTargets(bullet, findTargetResults);
		where.FindTargets(findTargetResults, bullet);
		if (findTargetResults.Count > 0)
		{
			m_FindTargetResult = findTargetResults[0];
		}
		compVelocity.velocity = trackTargetMovementPattern.speedScale * (compTransform.rotation * Vector3.forward);
		if (trackTargetMovementPattern.useVelocityDir)
		{
			if (trackTargetMovementPattern.upwards)
			{
				compTransform.rotation = Quaternion.LookRotation(compVelocity.velocity, Vector3.up);
			}
			else
			{
				compTransform.rotation = Quaternion.FromToRotation(Vector3.forward, compVelocity.velocity);
			}
		}
		rootTransform.rotation = compTransform.rotation;
		if (trackTargetMovementPattern.trackTargetType == TrackTargetType.trackRangeByFirePos)
		{
			spawnVelocity = compVelocity.velocity;
			m_SqrMax = trackTargetMovementPattern.lenRange.y * trackTargetMovementPattern.lenRange.y;
			m_SqrMin = trackTargetMovementPattern.lenRange.x * trackTargetMovementPattern.lenRange.x;
		}
	}

	public void DoTrack(float dis, Vector3 vBullet, Vector3 dir)
	{
		if (dis <= config.cannottrackDis)
		{
			if (config.noTrack)
			{
				canTrack = false;
			}
			return;
		}
		CompVelocity compVelocity = bullet.GetCompVelocity();
		vBullet = compVelocity.velocity;
		Vector3 eulerAngles = Quaternion.FromToRotation(vBullet, dir).eulerAngles;
		if (eulerAngles.z < -180f)
		{
			eulerAngles.z += 360f;
		}
		else if (eulerAngles.z > 180f)
		{
			eulerAngles.z -= 360f;
		}
		realTrackSpeed = MathF.Max(Mathf.Abs(config.rotateScale * config.rotateCutve.Evaluate(trackTime)), 0.0001f);
		eulerAngles.z = Mathf.Clamp(eulerAngles.z, 0f - realTrackSpeed, realTrackSpeed);
		Vector3 velocity = Quaternion.Euler(eulerAngles) * compVelocity.velocity;
		switch (config.trackTargetSpeedAxis)
		{
		case TrackTargetSpeedAxis.XY:
			velocity = new Vector3(velocity.x, velocity.y, 0f);
			break;
		case TrackTargetSpeedAxis.XZ:
			velocity = new Vector3(velocity.x, 0f, velocity.z);
			break;
		}
		compVelocity.velocity = velocity;
	}

	public bool CheckOutRange(Vector3 aimPos, Vector3 faceDir, float dis, Vector3 dir)
	{
		float num = Vector3.SignedAngle(faceDir, dir, Vector3.Cross(faceDir, dir));
		if (!(config.angleRange.x > num) && !(num > config.angleRange.y) && !(dis > m_SqrMax))
		{
			return !(dis < m_SqrMin);
		}
		return false;
	}

	public override void FixedUpdate(float dt)
	{
		CompTime compTime = bullet.GetCompTime();
		CompVelocity compVelocity = bullet.GetCompVelocity();
		CompTransform compTransform = bullet.GetCompTransform();
		trackTime += compTime.fixedDeltaTime;
		config = (TrackTargetMovementPattern)base.config;
		RefreshTargetFilterIfNeeded();
		Vector3 velocity = compVelocity.velocity;
		Vector3 velocity2 = compVelocity.velocity;
		if (canTrack)
		{
			if (m_FindTargetResult.IsValid)
			{
				Entity entity = m_FindTargetResult.entity;
				MonoEntity mono = entity.GetMono();
				if (mono != null && entity.IsAlive())
				{
					Vector3 physicsPosition = entity.GetCompTransform().physicsPosition;
					Vector3 vector = physicsPosition;
					int num = m_FindTargetResult.bodyIndex - 1;
					if (m_FindTargetResult.targetSourceType == FindTargetResult.TargetSourceType.Bodypart && mono.bodyParts != null && num >= 0 && num < mono.bodyParts.Length)
					{
						MonoBodyPart monoBodyPart = mono.bodyParts[num];
						if (monoBodyPart != null && monoBodyPart.isActiveAndEnabled && monoBodyPart.aimAble && !monoBodyPart.parryOnly && monoBodyPart.index == m_FindTargetResult.bodyIndex && monoBodyPart.entity == entity && monoBodyPart.myCollider != null && monoBodyPart.myCollider.enabled)
						{
							vector = m_FindTargetResult.SourcePosition;
						}
					}
					else
					{
						vector.z = physicsPosition.z;
					}
					if (config.useAimAttachPoint && mono.attachPoints != null)
					{
						vector = mono.GetAttachPointPosition(config.AimAttachPoint);
					}
					velocity = vector - compTransform.physicsPosition;
					float sqrMagnitude = (vector - compTransform.physicsPosition).sqrMagnitude;
					switch (config.trackTargetType)
					{
					case TrackTargetType.none:
						DoTrack(sqrMagnitude, velocity2, velocity);
						break;
					case TrackTargetType.trackRangeByFirePos:
						if (CheckOutRange(vector, spawnVelocity, sqrMagnitude, velocity))
						{
							DoTrack(sqrMagnitude, velocity2, velocity);
						}
						break;
					case TrackTargetType.trackRangeByCurPos:
						if (CheckOutRange(vector, compVelocity.velocity, sqrMagnitude, velocity))
						{
							DoTrack(sqrMagnitude, velocity2, velocity);
						}
						break;
					}
				}
			}
			else
			{
				config.findTargets.FindTargets(bullet, findTargetResults);
				where.FindTargets(findTargetResults, bullet);
				if (findTargetResults.Count > 0)
				{
					m_FindTargetResult = findTargetResults[0];
				}
				else
				{
					canTrack = false;
				}
			}
		}
		if (config.velocityModifiers != null)
		{
			CompTrajectory compTrajectory = bullet.GetCompTrajectory();
			Vector3 velocity3 = compVelocity.velocity;
			for (int i = 0; i < config.velocityModifiers.Length; i++)
			{
				velocity3 = config.velocityModifiers[i].Modify(velocity3, dt, compTrajectory.life);
			}
			compVelocity.velocity = velocity3;
		}
		(Vector3, Vector3, Quaternion) state = (compVelocity.velocity, compTransform.physicsPosition, compTransform.rotation);
		(Entity, Ability, float) message = (bullet, ability, dt);
		generalTrajectory.Evaluate(in message, in state, out (Vector3, Vector3, Quaternion) nextState);
		compTransform.UpdatePosition(nextState.Item2);
		if (config.useVelocityDir)
		{
			if (config.upwards)
			{
				compTransform.rotation = Quaternion.LookRotation(compVelocity.velocity, Vector3.up);
			}
			else
			{
				compTransform.rotation = Quaternion.FromToRotation(Vector3.forward, compVelocity.velocity);
			}
		}
	}

	public override void Update(float dt)
	{
		UpdatePositionInterpolation();
	}

	protected override void OnReset()
	{
		m_FindTargetResult = default;
		m_TargetHitPattern = null;
		ListPool<FindTargetResult>.Release(findTargetResults);
	}

	private void RefreshTargetFilterIfNeeded()
	{
		TrajectoryHitPattern hitPattern = generalTrajectory.hitPattern;
		if (m_TargetHitPattern != hitPattern)
		{
			m_TargetHitPattern = hitPattern;
			where = generalTrajectory.CreateWhereTargets(bullet);
			m_FindTargetResult = default;
			findTargetResults.Clear();
			canTrack = true;
			config.findTargets.FindTargets(bullet, findTargetResults);
			where.FindTargets(findTargetResults, bullet);
			if (findTargetResults.Count > 0)
			{
				m_FindTargetResult = findTargetResults[0];
			}
		}
	}
}
