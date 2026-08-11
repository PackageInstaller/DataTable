using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase.ECS;

public class SyncKinematicCharacterMotor : MovementMotorBase
{
	private static Comparison<Collider> _compareCollidersFunc = delegate(Collider a, Collider b)
	{
		if ((UnityEngine.Object)(object)a == null && (UnityEngine.Object)(object)b == null)
		{
			return 0;
		}
		if ((UnityEngine.Object)(object)a == null)
		{
			return 1;
		}
		if ((UnityEngine.Object)(object)b == null)
		{
			return -1;
		}
		float sqrMagnitude = (((Component)(object)a).transform.position + a.bounds.center).sqrMagnitude;
		float sqrMagnitude2 = (((Component)(object)b).transform.position + b.bounds.center).sqrMagnitude;
		return (Mathf.Abs(sqrMagnitude - sqrMagnitude2) <= 0.001f) ? ((Component)(object)a).transform.GetSiblingIndex().CompareTo(((Component)(object)b).transform.GetSiblingIndex()) : (-sqrMagnitude.CompareTo(sqrMagnitude2));
	};

	public override void SetPositionAndRotation(Vector3 position, Quaternion rotation)
	{
		position = Utility.Math.Round(position);
		rotation = Utility.Math.Round(rotation);
		if (IsOpenFallOffCorrection && position.y < FloorBaseDistance)
		{
			position = new Vector3(position.x, FloorBaseDistance, position.z);
		}
		if (_entity.GetEntityType() == EntityType.HERO)
		{
			Vector3 position2 = (_transientPosition = AntiPenetrationPos(position));
			_transform.position = position2;
			_transform.rotation = rotation;
		}
		else
		{
			_transientPosition = position;
			_transform.position = position;
			_transform.rotation = rotation;
		}
	}

	private Vector3 AntiPenetrationPos(Vector3 movePos)
	{
		if (_transform.position == movePos)
		{
			return _transform.position;
		}
		if ((movePos - _transform.position).sqrMagnitude <= 0.36f)
		{
			return movePos;
		}
		bool flag = true;
		bool flag2 = true;
		Vector3 normalized = new Vector3(movePos.x - _transform.position.x, 0f, 0f).normalized;
		Vector3 normalized2 = new Vector3(0f, 0f, movePos.z - _transform.position.z).normalized;
		Vector3 position = _transform.position;
		RaycastHit val = default(RaycastHit);
		if (Physics.Raycast(new Ray(position, normalized), ref val, Mathf.Abs(movePos.x - _transform.position.x)) && string.Equals(((RaycastHit)(ref val)).transform.tag, "AirWall"))
		{
			flag = false;
		}
		RaycastHit val2 = default(RaycastHit);
		if (Physics.Raycast(new Ray(position, normalized2), ref val2, Mathf.Abs(movePos.z - _transform.position.z)) && string.Equals(((RaycastHit)(ref val2)).transform.tag, "AirWall"))
		{
			flag2 = false;
		}
		Vector3 result = movePos;
		if (!flag)
		{
			result.x = _transform.position.x;
		}
		if (!flag2)
		{
			result.z = _transform.position.z;
		}
		return result;
	}

	public override void UpdatePhase1(float deltaTime)
	{
		if (float.IsNaN(BaseVelocity.x) || float.IsNaN(BaseVelocity.y) || float.IsNaN(BaseVelocity.z))
		{
			BaseVelocity = Vector3.zero;
		}
		CharacterController.BeforeCharacterUpdate(deltaTime);
		_transientPosition = _transform.position;
		base.TransientRotation = _transform.rotation;
		_initialSimulationPosition = _transientPosition;
		_initialSimulationRotation = _transientRotation;
		_overlapsCount = 0;
		_lastSolvedOverlapNormalDirty = false;
		if (_teleportMovement)
		{
			_teleportMovement = false;
			return;
		}
		if (_movePositionDirty)
		{
			if (_solveMovementCollisions)
			{
				Vector3 transientVelocity = GetVelocityFromMovement(_movePositionTarget - _transientPosition, deltaTime);
				InternalCharacterMove(ref transientVelocity, deltaTime);
			}
			else
			{
				_transientPosition = _movePositionTarget;
			}
			_movePositionDirty = false;
		}
		LastGroundingStatus.CopyFrom(GroundingStatus);
		GroundingStatus = default(CharacterGroundingReport);
		GroundingStatus.GroundNormal = _characterUp;
		if (_solveMovementCollisions)
		{
			Vector3 vector = _cachedWorldUp;
			float num = 0f;
			int num2 = 0;
			bool flag = false;
			while ((UnityEngine.Object)(object)Capsule != null && num2 < MaxDecollisionIterations && !flag)
			{
				int num3 = CharacterCollisionsOverlap(_transientPosition, _transientRotation, _internalProbedColliders);
				if (num3 > 0)
				{
					for (int i = 0; i < num3; i++)
					{
						Transform transform = ((Component)(object)_internalProbedColliders[i]).transform;
						if (Physics.ComputePenetration((Collider)(object)Capsule, _transientPosition, _transientRotation, _internalProbedColliders[i], transform.position, transform.rotation, ref vector, ref num))
						{
							HitStabilityReport hitStabilityReport = new HitStabilityReport
							{
								IsStable = IsStableOnNormal(vector)
							};
							vector = GetObstructionNormal(vector, hitStabilityReport.IsStable);
							Vector3 vector2 = vector * (num + 0.01f);
							_transientPosition += vector2;
							if (_overlapsCount < _overlaps.Length)
							{
								_overlaps[_overlapsCount] = new OverlapResult(vector, _internalProbedColliders[i]);
								_overlapsCount++;
							}
						}
					}
				}
				else
				{
					flag = true;
				}
				num2++;
			}
		}
		if (_solveWallCollisions)
		{
			CharacterController.SolveWall(_transientPosition, _transientRotation, out _transientPosition, out _transientRotation);
		}
		if (_solveGrounding)
		{
			if (MustUnground())
			{
				_transientPosition += _characterUp * 0.0075f;
			}
			else
			{
				float probingDistance = 0.005f;
				if (!LastGroundingStatus.SnappingPrevented && (LastGroundingStatus.IsStableOnGround || LastMovementIterationFoundAnyGround))
				{
					probingDistance = ((StepHandling == StepHandlingMethod.None) ? CapsuleRadius : Mathf.Max(CapsuleRadius, MaxStepHeight));
					probingDistance += GroundDetectionExtraDistance;
				}
				ProbeGround(ref _transientPosition, _transientRotation, probingDistance, ref GroundingStatus);
				if (!LastGroundingStatus.IsStableOnGround && GroundingStatus.IsStableOnGround)
				{
					BaseVelocity = Vector3.ProjectOnPlane(BaseVelocity, base.CharacterUp);
					BaseVelocity = GetDirectionTangentToSurface(BaseVelocity, GroundingStatus.GroundNormal) * BaseVelocity.magnitude;
				}
			}
		}
		LastMovementIterationFoundAnyGround = false;
		if (_mustUngroundTimeCounter > 0f)
		{
			_mustUngroundTimeCounter -= deltaTime;
		}
		_mustUnground = false;
		if (_solveGrounding)
		{
			CharacterController.PostGroundingUpdate(deltaTime);
		}
	}

	public override void UpdatePhase2(float deltaTime)
	{
		CharacterController.UpdateRotation(ref _transientRotation, deltaTime);
		base.TransientRotation = _transientRotation;
		if (_moveRotationDirty)
		{
			base.TransientRotation = _moveRotationTarget;
			_moveRotationDirty = false;
		}
		CharacterController.UpdateVelocity(ref BaseVelocity, deltaTime);
		if (BaseVelocity.magnitude < 0.01f)
		{
			BaseVelocity = Vector3.zero;
		}
		if (BaseVelocity.sqrMagnitude > 0f)
		{
			if (_solveMovementCollisions)
			{
				InternalCharacterMove(ref BaseVelocity, deltaTime);
			}
			else
			{
				_transientPosition += BaseVelocity * deltaTime;
			}
		}
		CharacterController.AfterCharacterUpdate(deltaTime);
	}

	protected override bool InternalCharacterMove(ref Vector3 transientVelocity, float deltaTime)
	{
		if (deltaTime <= 0f)
		{
			return false;
		}
		bool result = true;
		Vector3 remainingMovementDirection = Utility.Math.Round(transientVelocity.normalized);
		float remainingMovementMagnitude = Utility.Math.Round(transientVelocity.magnitude * deltaTime);
		Vector3 originalDirection = remainingMovementDirection;
		int num = 0;
		bool flag = true;
		Vector3 vector = _transientPosition;
		bool previousHitIsStable = false;
		Vector3 previousVelocity = _cachedZeroVector;
		Vector3 previousObstructionNormal = _cachedZeroVector;
		MovementSweepState sweepState = MovementSweepState.Initial;
		for (int i = 0; i < _overlapsCount; i++)
		{
			Vector3 normal = _overlaps[i].Normal;
			if (Vector3.Dot(remainingMovementDirection, normal) < 0f)
			{
				bool flag2 = IsStableOnNormal(normal) && !MustUnground();
				Vector3 vector2 = transientVelocity;
				Vector3 obstructionNormal = GetObstructionNormal(normal, flag2);
				InternalHandleVelocityProjection(flag2, normal, obstructionNormal, originalDirection, ref sweepState, previousHitIsStable, previousVelocity, previousObstructionNormal, ref transientVelocity, ref remainingMovementMagnitude, ref remainingMovementDirection);
				previousHitIsStable = flag2;
				previousVelocity = vector2;
				previousObstructionNormal = obstructionNormal;
			}
		}
		Vector3 vector3 = default(Vector3);
		float num4 = default(float);
		while ((remainingMovementMagnitude > 0f && num <= MaxMovementIterations) & flag)
		{
			bool flag3 = false;
			Vector3 value = default(Vector3);
			Vector3 value2 = default(Vector3);
			float value3 = 0f;
			Collider hitCollider = null;
			if ((UnityEngine.Object)(object)Capsule != null && CheckMovementInitialOverlaps)
			{
				float num2 = 2f;
				int num3 = CharacterCollisionsOverlap(vector, _transientRotation, _internalProbedColliders);
				if (num3 > 0)
				{
					value3 = 0f;
					num2 = 2f;
					for (int j = 0; j < num3; j++)
					{
						Collider val = _internalProbedColliders[j];
						if (Physics.ComputePenetration((Collider)(object)Capsule, vector, _transientRotation, val, ((Component)(object)val).transform.position, ((Component)(object)val).transform.rotation, ref vector3, ref num4))
						{
							float num5 = Vector3.Dot(remainingMovementDirection, vector3);
							if (num5 < 0f && num5 < num2)
							{
								num2 = num5;
								value2 = vector3;
								hitCollider = val;
								value = vector + _transientRotation * base.CharacterTransformToCapsuleCenter + vector3 * num4;
								flag3 = true;
							}
						}
					}
				}
			}
			if (!flag3 && CharacterCollisionsSweep(vector, _transientRotation, remainingMovementDirection, remainingMovementMagnitude + 0.01f, out var closestHit, _internalCharacterHits) > 0)
			{
				value2 = ((RaycastHit)(ref closestHit)).normal;
				value3 = ((RaycastHit)(ref closestHit)).distance;
				hitCollider = ((RaycastHit)(ref closestHit)).collider;
				value = ((RaycastHit)(ref closestHit)).point;
				flag3 = true;
			}
			value2 = Utility.Math.Round(value2);
			value3 = Utility.Math.Round(value3);
			value = Utility.Math.Round(value);
			if (flag3)
			{
				Vector3 value4 = Utility.Math.Round(Utility.Math.Round(remainingMovementDirection) * Mathf.Max(0f, value3 - 0.01f));
				vector += Utility.Math.Round(value4);
				remainingMovementMagnitude -= Utility.Math.Round(value4.magnitude);
				HitStabilityReport stabilityReport = default(HitStabilityReport);
				EvaluateHitStability(hitCollider, value2, value, vector, _transientRotation, transientVelocity, ref stabilityReport);
				bool flag4 = false;
				if (_solveGrounding && StepHandling != StepHandlingMethod.None && stabilityReport.ValidStepDetected && Mathf.Abs(Vector3.Dot(value2, base.CharacterUp)) <= 0.01f)
				{
					Vector3 normalized = Vector3.ProjectOnPlane(-value2, base.CharacterUp).normalized;
					Vector3 vector4 = vector + normalized * 0.03f + base.CharacterUp * MaxStepHeight;
					int num6 = CharacterCollisionsSweep(vector4, _transientRotation, -base.CharacterUp, MaxStepHeight, out var _, _internalCharacterHits, 0f, acceptOnlyStableGroundLayer: true);
					for (int k = 0; k < num6; k++)
					{
						if ((UnityEngine.Object)(object)((RaycastHit)(ref _internalCharacterHits[k])).collider == (UnityEngine.Object)(object)stabilityReport.SteppedCollider)
						{
							vector = vector4 + -base.CharacterUp * (Utility.Math.Round(((RaycastHit)(ref _internalCharacterHits[k])).distance) - 0.01f);
							flag4 = true;
							transientVelocity = Vector3.ProjectOnPlane(transientVelocity, base.CharacterUp);
							remainingMovementDirection = transientVelocity.normalized;
							break;
						}
					}
				}
				if (!flag4)
				{
					Vector3 obstructionNormal2 = GetObstructionNormal(value2, stabilityReport.IsStable);
					bool flag5 = stabilityReport.IsStable && !MustUnground();
					Vector3 vector5 = transientVelocity;
					InternalHandleVelocityProjection(flag5, value2, obstructionNormal2, originalDirection, ref sweepState, previousHitIsStable, previousVelocity, previousObstructionNormal, ref transientVelocity, ref remainingMovementMagnitude, ref remainingMovementDirection);
					previousHitIsStable = flag5;
					previousVelocity = vector5;
					previousObstructionNormal = obstructionNormal2;
				}
			}
			else
			{
				flag = false;
			}
			num++;
			if (num > MaxMovementIterations)
			{
				if (KillRemainingMovementWhenExceedMaxMovementIterations)
				{
					remainingMovementMagnitude = 0f;
				}
				if (KillVelocityWhenExceedMaxMovementIterations)
				{
					transientVelocity = Vector3.zero;
				}
				result = false;
			}
			remainingMovementMagnitude = Utility.Math.Round(remainingMovementMagnitude);
			if (remainingMovementMagnitude <= 0.01f)
			{
				remainingMovementMagnitude = 0f;
			}
		}
		vector = Utility.Math.Round(vector);
		remainingMovementMagnitude = Utility.Math.Round(remainingMovementMagnitude);
		remainingMovementDirection = Utility.Math.Round(remainingMovementDirection);
		vector += remainingMovementDirection * remainingMovementMagnitude;
		_transientPosition = Utility.Math.Round(vector);
		return result;
	}

	protected override bool InternalIsColliderValidForCollisions(Collider coll)
	{
		if (!CharacterController.IsColliderValidForCollisions(coll))
		{
			return false;
		}
		return true;
	}

	protected override bool InternalIsColliderValidForGroundCollisions(Collider coll, RaycastHit hit)
	{
		return true;
	}

	public override int CharacterCollisionsOverlap(Vector3 position, Quaternion rotation, Collider[] overlappedColliders, float inflate = 0f, bool acceptOnlyStableGroundLayer = false)
	{
		int num = CollidableLayers;
		if (acceptOnlyStableGroundLayer)
		{
			num = (int)CollidableLayers & (int)StableGroundLayers;
		}
		Vector3 vector = position + rotation * _characterTransformToCapsuleBottomHemi;
		Vector3 vector2 = position + rotation * _characterTransformToCapsuleTopHemi;
		if (inflate != 0f)
		{
			vector += rotation * Vector3.down * inflate;
			vector2 += rotation * Vector3.up * inflate;
		}
		int num2 = 0;
		ref PhysicsScene reference = ref physicsScene;
		Vector3 vector3 = vector;
		Vector3 vector4 = vector2;
		CapsuleCollider capsule = Capsule;
		for (int num3 = (num2 = ((PhysicsScene)(ref reference)).OverlapCapsule(vector3, vector4, (capsule != null) ? capsule.radius : (0f + inflate), overlappedColliders, num, (QueryTriggerInteraction)1)) - 1; num3 >= 0; num3--)
		{
			if (!CheckIfColliderValidForCollisions(overlappedColliders[num3]))
			{
				num2--;
				overlappedColliders[num3] = null;
			}
		}
		if (num2 > 0)
		{
			overlappedColliders.ShellSort(_compareCollidersFunc);
		}
		return num2;
	}

	private int CompareColliders(Collider a, Collider b)
	{
		if ((UnityEngine.Object)(object)a == null && (UnityEngine.Object)(object)b == null)
		{
			return 0;
		}
		if ((UnityEngine.Object)(object)a == null)
		{
			return 1;
		}
		if ((UnityEngine.Object)(object)b == null)
		{
			return -1;
		}
		float sqrMagnitude = (((Component)(object)a).transform.position + a.bounds.center).sqrMagnitude;
		float sqrMagnitude2 = (((Component)(object)b).transform.position + b.bounds.center).sqrMagnitude;
		return -sqrMagnitude.CompareTo(sqrMagnitude2);
	}

	private int CompareHit(RaycastHit a, RaycastHit b)
	{
		if (((RaycastHit)(ref a)).transform == null || ((RaycastHit)(ref b)).transform == null)
		{
			return 0;
		}
		if (((RaycastHit)(ref a)).transform == null)
		{
			return 1;
		}
		if (((RaycastHit)(ref b)).transform == null)
		{
			return -1;
		}
		float sqrMagnitude = ((RaycastHit)(ref a)).transform.position.sqrMagnitude;
		float sqrMagnitude2 = ((RaycastHit)(ref b)).transform.position.sqrMagnitude;
		return -sqrMagnitude.CompareTo(sqrMagnitude2);
	}

	public override int CharacterCollisionsSweep(Vector3 position, Quaternion rotation, Vector3 direction, float distance, out RaycastHit closestHit, RaycastHit[] hits, float inflate = 0f, bool acceptOnlyStableGroundLayer = false)
	{
		//IL_00f8: Unknown result type (might be due to invalid IL or missing references)
		//IL_0136: Unknown result type (might be due to invalid IL or missing references)
		//IL_015f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0164: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d0: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d2: Unknown result type (might be due to invalid IL or missing references)
		//IL_020b: Unknown result type (might be due to invalid IL or missing references)
		//IL_020d: Unknown result type (might be due to invalid IL or missing references)
		int num = CollidableLayers;
		if (acceptOnlyStableGroundLayer)
		{
			num = (int)CollidableLayers & (int)StableGroundLayers;
		}
		Vector3 vector = position + rotation * _characterTransformToCapsuleBottomHemi - direction * 0.002f;
		Vector3 vector2 = position + rotation * _characterTransformToCapsuleTopHemi - direction * 0.002f;
		if (inflate != 0f)
		{
			vector += rotation * Vector3.down * inflate;
			vector2 += rotation * Vector3.up * inflate;
		}
		int num2 = 0;
		ref PhysicsScene reference = ref physicsScene;
		Vector3 vector3 = vector;
		Vector3 vector4 = vector2;
		CapsuleCollider capsule = Capsule;
		int num3 = ((PhysicsScene)(ref reference)).CapsuleCast(vector3, vector4, (capsule != null) ? capsule.radius : (0f + inflate), direction.normalized, hits, distance + 0.002f, num, (QueryTriggerInteraction)1);
		List<RaycastHit> list = new List<RaycastHit>();
		for (int i = 0; i < num3; i++)
		{
			list.Add(hits[i]);
		}
		list.Sort((RaycastHit a, RaycastHit b) => ((RaycastHit)(ref a)).distance.CompareTo(((RaycastHit)(ref b)).distance));
		closestHit = default(RaycastHit);
		float num4 = float.PositiveInfinity;
		float num5 = float.MaxValue;
		num2 = num3;
		_ = string.Empty;
		for (int num6 = 0; num6 < num3; num6++)
		{
			RaycastHit val = list[num6];
			float num7 = Utility.Math.Round(((RaycastHit)(ref val)).distance);
			if (num7 <= CharacterController.GetCollisionOffset(((RaycastHit)(ref val)).collider) || !CheckIfColliderValidForCollisions(((RaycastHit)(ref val)).collider))
			{
				num2--;
				continue;
			}
			float sqrMagnitude = ((RaycastHit)(ref val)).collider.bounds.center.sqrMagnitude;
			if (num7 < num4)
			{
				num5 = sqrMagnitude;
				closestHit = val;
				num4 = num7;
			}
			else if (Math.Abs(num7 - num4) <= 0.0001f && Math.Abs(sqrMagnitude - num5) > 0.0001f && sqrMagnitude < num5)
			{
				num5 = sqrMagnitude;
				closestHit = val;
				num4 = num7;
			}
		}
		return num2;
	}

	public override int CharacterCollisionsRaycast(Vector3 position, Vector3 direction, float distance, out RaycastHit closestHit, RaycastHit[] hits, bool acceptOnlyStableGroundLayer = false)
	{
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_010f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0111: Unknown result type (might be due to invalid IL or missing references)
		int num = CollidableLayers;
		if (acceptOnlyStableGroundLayer)
		{
			num = (int)CollidableLayers & (int)StableGroundLayers;
		}
		int num2 = 0;
		int num3 = ((PhysicsScene)(ref physicsScene)).Raycast(position, direction, hits, distance, num, (QueryTriggerInteraction)1);
		closestHit = default(RaycastHit);
		float num4 = float.PositiveInfinity;
		float num5 = float.MaxValue;
		_ = string.Empty;
		num2 = num3;
		for (int i = 0; i < num3; i++)
		{
			RaycastHit val = hits[i];
			float num6 = Utility.Math.Round(((RaycastHit)(ref val)).distance);
			if (num6 <= CharacterController.GetCollisionOffset(((RaycastHit)(ref val)).collider) || !CheckIfColliderValidForCollisions(((RaycastHit)(ref val)).collider))
			{
				num2--;
				continue;
			}
			float sqrMagnitude = ((RaycastHit)(ref val)).collider.bounds.center.sqrMagnitude;
			if (num6 < num4)
			{
				num5 = sqrMagnitude;
				closestHit = val;
				num4 = num6;
			}
			else if (Math.Abs(num6 - num4) <= 0.0001f && Math.Abs(sqrMagnitude - num5) > 0.0001f && sqrMagnitude < num5)
			{
				num5 = sqrMagnitude;
				closestHit = val;
				num4 = num6;
			}
		}
		return num2;
	}

	protected override bool CharacterGroundSweep(Vector3 position, Quaternion rotation, Vector3 direction, float distance, out RaycastHit closestHit)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ad: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fb: Unknown result type (might be due to invalid IL or missing references)
		//IL_0100: Unknown result type (might be due to invalid IL or missing references)
		//IL_012a: Unknown result type (might be due to invalid IL or missing references)
		//IL_012c: Unknown result type (might be due to invalid IL or missing references)
		closestHit = default(RaycastHit);
		ref PhysicsScene reference = ref physicsScene;
		Vector3 vector = position + rotation * _characterTransformToCapsuleBottomHemi - direction * 0.1f;
		Vector3 vector2 = position + rotation * _characterTransformToCapsuleTopHemi - direction * 0.1f;
		CapsuleCollider capsule = Capsule;
		int num = ((PhysicsScene)(ref reference)).CapsuleCast(vector, vector2, (capsule != null) ? capsule.radius : 0f, direction, _internalCharacterHits, distance + 0.1f, (int)CollidableLayers & (int)StableGroundLayers, (QueryTriggerInteraction)1);
		List<RaycastHit> list = new List<RaycastHit>();
		if (num > 0)
		{
			for (int i = 0; i < num; i++)
			{
				list.Add(_internalCharacterHits[i]);
			}
		}
		list.Sort((RaycastHit a, RaycastHit b) => ((RaycastHit)(ref a)).distance.CompareTo(((RaycastHit)(ref b)).distance));
		bool result = false;
		float num2 = float.PositiveInfinity;
		if (num > 0)
		{
			for (int num3 = 0; num3 < num; num3++)
			{
				RaycastHit val = list[num3];
				float distance2 = ((RaycastHit)(ref val)).distance;
				if (distance2 > 0f && CheckIfColliderValidForCollisions(((RaycastHit)(ref val)).collider) && distance2 < num2)
				{
					closestHit = val;
					((RaycastHit)(ref closestHit)).distance = ((RaycastHit)(ref closestHit)).distance - 0.1f;
					num2 = distance2;
					result = true;
				}
			}
		}
		return result;
	}
}
