using UnityEngine;

namespace Ase;

public class KinematicCharacterMotor : MovementMotorBase
{
	public override void UpdatePhase1(float deltaTime)
	{
		if (float.IsNaN(BaseVelocity.x) || float.IsNaN(BaseVelocity.y) || float.IsNaN(BaseVelocity.z))
		{
			BaseVelocity = Vector3.zero;
		}
		if (float.IsNaN(_attachedRigidbodyVelocity.x) || float.IsNaN(_attachedRigidbodyVelocity.y) || float.IsNaN(_attachedRigidbodyVelocity.z))
		{
			_attachedRigidbodyVelocity = Vector3.zero;
		}
		_rigidbodiesPushedThisMove.Clear();
		CharacterController.BeforeCharacterUpdate(deltaTime);
		_transientPosition = _transform.position;
		base.TransientRotation = _transform.rotation;
		_initialSimulationPosition = _transientPosition;
		_initialSimulationRotation = _transientRotation;
		_rigidbodyProjectionHitCount = 0;
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
				if (InternalCharacterMove(ref transientVelocity, deltaTime) && InteractiveRigidbodyHandling)
				{
					ProcessVelocityForRigidbodyHits(ref transientVelocity, deltaTime);
				}
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
			while ((Object)(object)Capsule != null && num2 < MaxDecollisionIterations && !flag)
			{
				int num3 = CharacterCollisionsOverlap(_transientPosition, _transientRotation, _internalProbedColliders);
				if (num3 > 0)
				{
					for (int i = 0; i < num3; i++)
					{
						if (!((Object)(object)GetInteractiveRigidbody(_internalProbedColliders[i]) == null))
						{
							continue;
						}
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
							break;
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
		if (!InteractiveRigidbodyHandling)
		{
			return;
		}
		_lastAttachedRigidbody = _attachedRigidbody;
		if ((bool)(Object)(object)AttachedRigidbodyOverride)
		{
			_attachedRigidbody = AttachedRigidbodyOverride;
		}
		else if (GroundingStatus.IsStableOnGround && (bool)(Object)(object)GroundingStatus.GroundCollider.attachedRigidbody)
		{
			Rigidbody interactiveRigidbody = GetInteractiveRigidbody(GroundingStatus.GroundCollider);
			if ((bool)(Object)(object)interactiveRigidbody)
			{
				_attachedRigidbody = interactiveRigidbody;
			}
		}
		else
		{
			_attachedRigidbody = null;
		}
		Vector3 linearVelocity = Vector3.zero;
		Vector3 angularVelocity = Vector3.zero;
		if ((bool)(Object)(object)_attachedRigidbody)
		{
			GetVelocityFromRigidbodyMovement(_attachedRigidbody, _transientPosition, deltaTime, out linearVelocity, out angularVelocity);
		}
		if (PreserveAttachedRigidbodyMomentum && (Object)(object)_lastAttachedRigidbody != null && (Object)(object)_attachedRigidbody != (Object)(object)_lastAttachedRigidbody)
		{
			BaseVelocity += _attachedRigidbodyVelocity;
			BaseVelocity -= linearVelocity;
		}
		_attachedRigidbodyVelocity = _cachedZeroVector;
		if ((bool)(Object)(object)_attachedRigidbody)
		{
			_attachedRigidbodyVelocity = linearVelocity;
			Vector3 normalized = Vector3.ProjectOnPlane(Quaternion.Euler(57.29578f * angularVelocity * deltaTime) * _characterForward, _characterUp).normalized;
			base.TransientRotation = Quaternion.LookRotation(normalized, _characterUp);
		}
		if ((bool)(Object)(object)GroundingStatus.GroundCollider && (bool)(Object)(object)GroundingStatus.GroundCollider.attachedRigidbody && (Object)(object)GroundingStatus.GroundCollider.attachedRigidbody == (Object)(object)_attachedRigidbody && (Object)(object)_attachedRigidbody != null && (Object)(object)_lastAttachedRigidbody == null)
		{
			BaseVelocity -= Vector3.ProjectOnPlane(_attachedRigidbodyVelocity, _characterUp);
		}
		if (_attachedRigidbodyVelocity.sqrMagnitude > 0f)
		{
			_isMovingFromAttachedRigidbody = true;
			if (_solveMovementCollisions)
			{
				InternalCharacterMove(ref _attachedRigidbodyVelocity, deltaTime);
			}
			else
			{
				_transientPosition += _attachedRigidbodyVelocity * deltaTime;
			}
			_isMovingFromAttachedRigidbody = false;
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
		if (_solveMovementCollisions && InteractiveRigidbodyHandling)
		{
			if (InteractiveRigidbodyHandling && (bool)(Object)(object)_attachedRigidbody)
			{
				CapsuleCollider capsule = Capsule;
				float num = ((capsule != null) ? capsule.radius : 0f);
				if (CharacterGroundSweep(_transientPosition + _characterUp * num, _transientRotation, -_characterUp, num, out var closestHit) && (Object)(object)((RaycastHit)(ref closestHit)).collider.attachedRigidbody == (Object)(object)_attachedRigidbody && IsStableOnNormal(((RaycastHit)(ref closestHit)).normal))
				{
					float num2 = num - ((RaycastHit)(ref closestHit)).distance;
					_transientPosition = _transientPosition + _characterUp * num2 + _characterUp * 0.01f;
				}
			}
			if (InteractiveRigidbodyHandling)
			{
				Vector3 vector = _cachedWorldUp;
				float num3 = 0f;
				int num4 = 0;
				bool flag = false;
				while ((Object)(object)Capsule != null && num4 < MaxDecollisionIterations && !flag)
				{
					int num5 = CharacterCollisionsOverlap(_transientPosition, _transientRotation, _internalProbedColliders);
					if (num5 > 0)
					{
						for (int i = 0; i < num5; i++)
						{
							Transform transform = ((Component)(object)_internalProbedColliders[i]).transform;
							if (!Physics.ComputePenetration((Collider)(object)Capsule, _transientPosition, _transientRotation, _internalProbedColliders[i], transform.position, transform.rotation, ref vector, ref num3))
							{
								continue;
							}
							HitStabilityReport hitStabilityReport = new HitStabilityReport
							{
								IsStable = IsStableOnNormal(vector)
							};
							vector = GetObstructionNormal(vector, hitStabilityReport.IsStable);
							Vector3 vector2 = vector * (num3 + 0.01f);
							_transientPosition += vector2;
							if (InteractiveRigidbodyHandling)
							{
								Rigidbody interactiveRigidbody = GetInteractiveRigidbody(_internalProbedColliders[i]);
								if ((Object)(object)interactiveRigidbody != null)
								{
									HitStabilityReport hitStabilityReport2 = new HitStabilityReport
									{
										IsStable = IsStableOnNormal(vector)
									};
									if (hitStabilityReport2.IsStable)
									{
										LastMovementIterationFoundAnyGround = hitStabilityReport2.IsStable;
									}
									if ((Object)(object)interactiveRigidbody != (Object)(object)_attachedRigidbody)
									{
										_ = _transientPosition + _transientRotation * _characterTransformToCapsuleCenter;
										Vector3 transientPosition = _transientPosition;
										StoreRigidbodyHit(interactiveRigidbody, base.Velocity, transientPosition, vector, hitStabilityReport2);
									}
								}
							}
							if (_overlapsCount < _overlaps.Length)
							{
								_overlaps[_overlapsCount] = new OverlapResult(vector, _internalProbedColliders[i]);
								_overlapsCount++;
							}
							break;
						}
					}
					else
					{
						flag = true;
					}
					num4++;
				}
			}
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
		if (InteractiveRigidbodyHandling)
		{
			ProcessVelocityForRigidbodyHits(ref BaseVelocity, deltaTime);
		}
		if (HasPlanarConstraint)
		{
			_transientPosition = _initialSimulationPosition + Vector3.ProjectOnPlane(_transientPosition - _initialSimulationPosition, PlanarConstraintAxis.normalized);
		}
		if (DiscreteCollisionEvents)
		{
			int num6 = CharacterCollisionsOverlap(_transientPosition, _transientRotation, _internalProbedColliders, 0.02f);
			for (int j = 0; j < num6; j++)
			{
				CharacterController.OnDiscreteCollisionDetected(_internalProbedColliders[j]);
			}
		}
		if (_solveWallCollisions)
		{
			CharacterController.SolveWall(_transientPosition, _transientRotation, out _transientPosition, out _transientRotation);
		}
		CharacterController.AfterCharacterUpdate(deltaTime);
	}

	protected override bool InternalCharacterMove(ref Vector3 transientVelocity, float deltaTime)
	{
		if (deltaTime <= 0f)
		{
			return false;
		}
		if (HasPlanarConstraint)
		{
			transientVelocity = Vector3.ProjectOnPlane(transientVelocity, PlanarConstraintAxis.normalized);
		}
		bool result = true;
		Vector3 remainingMovementDirection = transientVelocity.normalized;
		float remainingMovementMagnitude = transientVelocity.magnitude * deltaTime;
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
		Vector3 vector4 = default(Vector3);
		float num5 = default(float);
		while ((remainingMovementMagnitude > 0f && num <= MaxMovementIterations) & flag)
		{
			bool flag3 = false;
			Vector3 hitPoint = default(Vector3);
			Vector3 vector3 = default(Vector3);
			float num2 = 0f;
			Collider val = null;
			if ((Object)(object)Capsule != null && CheckMovementInitialOverlaps)
			{
				int num3 = CharacterCollisionsOverlap(vector, _transientRotation, _internalProbedColliders);
				if (num3 > 0)
				{
					num2 = 0f;
					float num4 = 2f;
					for (int j = 0; j < num3; j++)
					{
						Collider val2 = _internalProbedColliders[j];
						if (Physics.ComputePenetration((Collider)(object)Capsule, vector, _transientRotation, val2, ((Component)(object)val2).transform.position, ((Component)(object)val2).transform.rotation, ref vector4, ref num5))
						{
							float num6 = Vector3.Dot(remainingMovementDirection, vector4);
							if (num6 < 0f && num6 < num4)
							{
								num4 = num6;
								vector3 = vector4;
								val = val2;
								hitPoint = vector + _transientRotation * base.CharacterTransformToCapsuleCenter + vector4 * num5;
								flag3 = true;
							}
						}
					}
				}
			}
			if (!flag3 && CharacterCollisionsSweep(vector, _transientRotation, remainingMovementDirection, remainingMovementMagnitude + 0.01f, out var closestHit, _internalCharacterHits) > 0)
			{
				vector3 = ((RaycastHit)(ref closestHit)).normal;
				num2 = ((RaycastHit)(ref closestHit)).distance;
				val = ((RaycastHit)(ref closestHit)).collider;
				hitPoint = ((RaycastHit)(ref closestHit)).point;
				flag3 = true;
			}
			if (flag3)
			{
				Vector3 vector5 = remainingMovementDirection * Mathf.Max(0f, num2 - 0.01f);
				vector += vector5;
				remainingMovementMagnitude -= vector5.magnitude;
				HitStabilityReport stabilityReport = default(HitStabilityReport);
				EvaluateHitStability(val, vector3, hitPoint, vector, _transientRotation, transientVelocity, ref stabilityReport);
				bool flag4 = false;
				if (_solveGrounding && StepHandling != StepHandlingMethod.None && stabilityReport.ValidStepDetected && Mathf.Abs(Vector3.Dot(vector3, _characterUp)) <= 0.01f)
				{
					Vector3 normalized = Vector3.ProjectOnPlane(-vector3, _characterUp).normalized;
					Vector3 vector6 = vector + normalized * 0.03f + _characterUp * MaxStepHeight;
					int num7 = CharacterCollisionsSweep(vector6, _transientRotation, -_characterUp, MaxStepHeight, out var _, _internalCharacterHits, 0f, acceptOnlyStableGroundLayer: true);
					for (int k = 0; k < num7; k++)
					{
						if ((Object)(object)((RaycastHit)(ref _internalCharacterHits[k])).collider == (Object)(object)stabilityReport.SteppedCollider)
						{
							vector = vector6 + -_characterUp * (((RaycastHit)(ref _internalCharacterHits[k])).distance - 0.01f);
							flag4 = true;
							transientVelocity = Vector3.ProjectOnPlane(transientVelocity, base.CharacterUp);
							remainingMovementDirection = transientVelocity.normalized;
							break;
						}
					}
				}
				if (!flag4)
				{
					Vector3 obstructionNormal2 = GetObstructionNormal(vector3, stabilityReport.IsStable);
					CharacterController.OnMovementHit(val, vector3, hitPoint, ref stabilityReport);
					if (InteractiveRigidbodyHandling && (bool)(Object)(object)val.attachedRigidbody)
					{
						StoreRigidbodyHit(val.attachedRigidbody, transientVelocity, hitPoint, obstructionNormal2, stabilityReport);
					}
					bool flag5 = stabilityReport.IsStable && !MustUnground();
					Vector3 vector7 = transientVelocity;
					InternalHandleVelocityProjection(flag5, vector3, obstructionNormal2, originalDirection, ref sweepState, previousHitIsStable, previousVelocity, previousObstructionNormal, ref transientVelocity, ref remainingMovementMagnitude, ref remainingMovementDirection);
					previousHitIsStable = flag5;
					previousVelocity = vector7;
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
		}
		vector += remainingMovementDirection * remainingMovementMagnitude;
		_transientPosition = vector;
		return result;
	}

	protected override bool InternalIsColliderValidForCollisions(Collider coll)
	{
		Rigidbody attachedRigidbody = coll.attachedRigidbody;
		if ((bool)(Object)(object)attachedRigidbody)
		{
			bool isKinematic = attachedRigidbody.isKinematic;
			if (_isMovingFromAttachedRigidbody && (!isKinematic || (Object)(object)attachedRigidbody == (Object)(object)_attachedRigidbody))
			{
				return false;
			}
			if (RigidbodyInteractionType == RigidbodyInteractionType.Kinematic && !isKinematic)
			{
				if ((bool)(Object)(object)coll.attachedRigidbody)
				{
					coll.attachedRigidbody.WakeUp();
				}
				return false;
			}
		}
		if (!CharacterController.IsColliderValidForCollisions(coll))
		{
			return false;
		}
		return true;
	}

	protected override bool InternalIsColliderValidForGroundCollisions(Collider coll, RaycastHit hit)
	{
		if (IsGroundCollider(coll) && Vector3.Dot(((RaycastHit)(ref hit)).normal, Vector3.up) <= 0f)
		{
			return false;
		}
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
				if (num3 < num2)
				{
					overlappedColliders[num3] = overlappedColliders[num2];
				}
			}
		}
		return num2;
	}

	public override int CharacterCollisionsSweep(Vector3 position, Quaternion rotation, Vector3 direction, float distance, out RaycastHit closestHit, RaycastHit[] hits, float inflate = 0f, bool acceptOnlyStableGroundLayer = false)
	{
		//IL_00e0: Unknown result type (might be due to invalid IL or missing references)
		//IL_0116: Unknown result type (might be due to invalid IL or missing references)
		//IL_011b: Unknown result type (might be due to invalid IL or missing references)
		//IL_015f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0164: Unknown result type (might be due to invalid IL or missing references)
		//IL_0146: Unknown result type (might be due to invalid IL or missing references)
		//IL_0173: Unknown result type (might be due to invalid IL or missing references)
		//IL_0175: Unknown result type (might be due to invalid IL or missing references)
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
		int num3 = ((PhysicsScene)(ref reference)).CapsuleCast(vector3, vector4, (capsule != null) ? capsule.radius : (0f + inflate), direction, hits, distance + 0.002f, num, (QueryTriggerInteraction)1);
		closestHit = default(RaycastHit);
		float num4 = float.PositiveInfinity;
		num2 = num3;
		for (int num5 = num3 - 1; num5 >= 0; num5--)
		{
			ref RaycastHit reference2 = ref hits[num5];
			((RaycastHit)(ref reference2)).distance = ((RaycastHit)(ref reference2)).distance - 0.002f;
			RaycastHit val = hits[num5];
			float distance2 = ((RaycastHit)(ref val)).distance;
			if (distance2 <= 0f || !CheckIfColliderValidForCollisions(((RaycastHit)(ref val)).collider) || !InternalIsColliderValidForGroundCollisions(((RaycastHit)(ref val)).collider, val))
			{
				num2--;
				if (num5 < num2)
				{
					hits[num5] = hits[num2];
				}
			}
			else if (distance2 < num4)
			{
				closestHit = val;
				num4 = distance2;
			}
		}
		return num2;
	}

	public override int CharacterCollisionsRaycast(Vector3 position, Vector3 direction, float distance, out RaycastHit closestHit, RaycastHit[] hits, bool acceptOnlyStableGroundLayer = false)
	{
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_0059: Unknown result type (might be due to invalid IL or missing references)
		//IL_009b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b0: Unknown result type (might be due to invalid IL or missing references)
		int num = CollidableLayers;
		if (acceptOnlyStableGroundLayer)
		{
			num = (int)CollidableLayers & (int)StableGroundLayers;
		}
		int num2 = 0;
		int num3 = ((PhysicsScene)(ref physicsScene)).Raycast(position, direction, hits, distance, num, (QueryTriggerInteraction)1);
		closestHit = default(RaycastHit);
		float num4 = float.PositiveInfinity;
		num2 = num3;
		for (int num5 = num3 - 1; num5 >= 0; num5--)
		{
			RaycastHit val = hits[num5];
			float distance2 = ((RaycastHit)(ref val)).distance;
			if (distance2 <= 0f || !CheckIfColliderValidForCollisions(((RaycastHit)(ref val)).collider) || !InternalIsColliderValidForGroundCollisions(((RaycastHit)(ref val)).collider, val))
			{
				num2--;
				if (num5 < num2)
				{
					hits[num5] = hits[num2];
				}
			}
			else if (distance2 < num4)
			{
				closestHit = val;
				num4 = distance2;
			}
		}
		return num2;
	}

	protected override bool CharacterGroundSweep(Vector3 position, Quaternion rotation, Vector3 direction, float distance, out RaycastHit closestHit)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ad: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ea: Unknown result type (might be due to invalid IL or missing references)
		closestHit = default(RaycastHit);
		ref PhysicsScene reference = ref physicsScene;
		Vector3 vector = position + rotation * _characterTransformToCapsuleBottomHemi - direction * 0.1f;
		Vector3 vector2 = position + rotation * _characterTransformToCapsuleTopHemi - direction * 0.1f;
		CapsuleCollider capsule = Capsule;
		int num = ((PhysicsScene)(ref reference)).CapsuleCast(vector, vector2, (capsule != null) ? capsule.radius : 0f, direction, _internalCharacterHits, distance + 0.1f, (int)CollidableLayers & (int)StableGroundLayers, (QueryTriggerInteraction)1);
		bool result = false;
		float num2 = float.PositiveInfinity;
		for (int i = 0; i < num; i++)
		{
			RaycastHit val = _internalCharacterHits[i];
			float distance2 = ((RaycastHit)(ref val)).distance;
			if (distance2 >= 0f && CheckIfColliderValidForCollisions(((RaycastHit)(ref val)).collider) && InternalIsColliderValidForGroundCollisions(((RaycastHit)(ref val)).collider, val) && distance2 < num2)
			{
				closestHit = val;
				((RaycastHit)(ref closestHit)).distance = ((RaycastHit)(ref closestHit)).distance - 0.1f;
				num2 = distance2;
				result = true;
			}
		}
		return result;
	}
}
