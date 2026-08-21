using System;
using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

public class KinematicMoveComponent : BaseComponent
{
	private bool positionAndRoationInputCheck = true;

	private bool positionAndRoationUpdateCheck = true;

	private Vector3 _internalVelocityAdd = Vector3.zero;

	private CapsuleCollider cacheBodyCollider;

	private EntityCollisionLayer cacheEntityCollisionLayer;

	private Vector3 Gravity = new Vector3(0f, -30f, 0f);

	private bool useGravity = true;

	private List<Collider> IgnoredColliders = new List<Collider>();

	public CollisionSetting.CollisionLayer IgnoredLayers;

	private MovementMotorBase movementMotor;

	private GameObject entityViewObject;

	private int obstructCount;

	private bool obstructState;

	private int obstructWallCount;

	private bool obstructWallState;

	private int obstructAirWallCount;

	private bool obstructAirWallState;

	public float nextCheckTime = -1f;

	private Collider lastStandGround;

	private List<Vector3> lastStandPositions;

	private float dropMaxHeight;

	private float droplowLevelHeight;

	private float dropReduceHpPercent;

	private bool dropWaitDead;

	private float startDropY;

	public bool dropHanding;

	public int cameraId;

	public float recordTime = 0.3f;

	private float deceleration = 1f;

	private GameObject deadVirtualCameraPoint;

	private GameObject decelerGroundgObj;

	private Vector3 lastPosition;

	private Quaternion lastRotation;

	private MovePriority movePriority;

	private Collider[] _colliders = (Collider[])(object)new Collider[32];

	private RaycastHit[] _raycastHits4AirWall = (RaycastHit[])(object)new RaycastHit[32];

	private RaycastHit[] _raycastHits = (RaycastHit[])(object)new RaycastHit[16];

	public float Deceleration => deceleration;

	public Vector3 LastPosition => lastPosition;

	public Quaternion LastRotation => lastRotation;

	private RaycastHit[] RaycastHits4AirWall => _raycastHits4AirWall;

	private RaycastHit[] RaycastHits => _raycastHits;

	public override void OnAwake(object data = null)
	{
		if (base.Entity.IsSyncPhysicsEntity)
		{
			if (base.Entity.GetWorld().IsStoryWorld)
			{
				movementMotor = new KinematicCharacterMotor();
			}
			else
			{
				movementMotor = new SyncKinematicCharacterMotor();
			}
			DRConstantConfig dataRow = GameEntry.DataTable.GetDataRow<DRConstantConfig>(1011);
			DRConstantConfig dataRow2 = GameEntry.DataTable.GetDataRow<DRConstantConfig>(1012);
			if (dataRow != null && dataRow2 != null)
			{
				droplowLevelHeight = dataRow.Value;
				dropReduceHpPercent = dataRow2.Value;
				dropMaxHeight = 1f / dropReduceHpPercent;
			}
			movementMotor.Init(this);
		}
	}

	public override void OnStart(object data = null)
	{
		if (base.Entity.IsSyncPhysicsEntity)
		{
			movementMotor.RegisterBodyCollider(cacheBodyCollider);
			entityViewObject = mBaseEntity.GetEntityObject();
			mBaseEntity.GetSystem<KinematicCharacterSystem>().RegisterCharacterMotor(movementMotor);
			CreateDeadVirtualCamera();
			SetFloorBaseDistance(mBaseEntity.GetWorld().GetMapData()?.GetFloorBaseDistance() ?? 0f);
			movePriority = MovePriority.None;
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		SetMovePriority(MovePriority.None);
	}

	public void SetFloorBaseDistance(float floorBaseDistance)
	{
		movementMotor.SetFloorBaseDistance(floorBaseDistance);
	}

	public void OpenFallOffCorrection(bool isOpenFallOffCorrection)
	{
		movementMotor.OpenFallOffCorrection(isOpenFallOffCorrection);
	}

	public override void OnEntityDead()
	{
		base.OnEntityDead();
		if (base.Entity.IsSyncPhysicsEntity)
		{
			movementMotor.OnDead();
		}
	}

	public void AddIgnoredLayer(CollisionSetting.CollisionLayer layer)
	{
		IgnoredLayers |= layer;
	}

	public void RemoveIgnoredLayer(CollisionSetting.CollisionLayer layer)
	{
		IgnoredLayers &= ~layer;
	}

	public void AddIgnoredCollider(Collider collider)
	{
		if (!IgnoredColliders.Contains(collider))
		{
			IgnoredColliders.Add(collider);
		}
	}

	public void RemoveIgnoredCollider(Collider collider)
	{
		if (IgnoredColliders.Contains(collider))
		{
			IgnoredColliders.Remove(collider);
		}
	}

	public void SetMovePriority(MovePriority priority)
	{
		movePriority = priority;
	}

	public void SetPosition(Vector3 position, string content, MovePriority priority = MovePriority.Normal)
	{
		if (movePriority <= priority)
		{
			movePriority = priority;
			position = Utility.Math.Round(position);
			movementMotor.MoveCharacter(position);
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"位移标记： {content} 位置 ： {position * 10000f}", mBaseEntity);
			}
		}
	}

	public void ImmediatelyMove(Vector3 position)
	{
		movementMotor.SetPosition(position);
		if ((bool)entityViewObject)
		{
			entityViewObject.transform.position = position;
		}
		LockstepData.Instance?.WriteAuthorityEntityId($"位移标记 ： {position * 10000f}", mBaseEntity);
	}

	public void StackedMovePosition(Vector3 position, string content)
	{
		position = Utility.Math.Round(position);
		movementMotor.StackedMoveCharacter(position);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"叠加移动： {content} 位置 ： {position * 10000f}", mBaseEntity);
		}
	}

	public void SolveWall(Vector3 position, Quaternion rotation, out Vector3 afterCheckPosition, out Quaternion afterCheckRoatation)
	{
		afterCheckRoatation = rotation;
		afterCheckPosition = position;
		if (positionAndRoationUpdateCheck)
		{
			afterCheckPosition = GetPoint(position);
			if (CheckRotation(position, rotation))
			{
				afterCheckRoatation = base.transform.rotation;
			}
		}
	}

	public float GetCollisionOffset(Collider collider)
	{
		if ((UnityEngine.Object)(object)collider == null)
		{
			return 0f;
		}
		if (((Component)(object)collider).gameObject.CompareTag("AirWall"))
		{
			return 0f;
		}
		if (((Component)(object)collider).gameObject.layer == LayerMask.NameToLayer("Battle"))
		{
			return 0.01f;
		}
		return 0f;
	}

	private Vector3 GetPoint(Vector3 position)
	{
		//IL_00ca: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cf: Unknown result type (might be due to invalid IL or missing references)
		//IL_0156: Unknown result type (might be due to invalid IL or missing references)
		//IL_015b: Unknown result type (might be due to invalid IL or missing references)
		Vector3 vector = position;
		Vector3 position2 = base.transform.position;
		Quaternion rotation = base.transform.rotation;
		CapsuleCollider obj = cacheBodyCollider;
		Vector3 vector3;
		if (obj == null)
		{
			Vector3 zero = Vector3.zero;
			Vector3 vector2 = -Vector3.up;
			CapsuleCollider obj2 = cacheBodyCollider;
			vector3 = zero + vector2 * ((obj2 != null) ? obj2.height : 0f);
		}
		else
		{
			vector3 = obj.center;
		}
		Vector3 vector4 = position2 + rotation * vector3;
		Vector3 position3 = base.transform.position;
		Quaternion rotation2 = base.transform.rotation;
		CapsuleCollider obj3 = cacheBodyCollider;
		Vector3 vector5;
		if (obj3 == null)
		{
			Vector3 zero2 = Vector3.zero;
			Vector3 up = Vector3.up;
			CapsuleCollider obj4 = cacheBodyCollider;
			vector5 = zero2 + up * ((obj4 != null) ? obj4.height : 0f);
		}
		else
		{
			vector5 = obj3.center;
		}
		Vector3 vector6 = position3 + rotation2 * vector5;
		PhysicsScene physicsScene = mBaseEntity.GetWorld().GetPhysicsScene();
		CapsuleCollider obj5 = cacheBodyCollider;
		RaycastHit val = default(RaycastHit);
		bool flag = ((PhysicsScene)(ref physicsScene)).CapsuleCast(vector4, vector6, (obj5 != null) ? obj5.radius : 0f, (vector - base.transform.position).normalized, ref val, (vector - base.transform.position).magnitude, -1, (QueryTriggerInteraction)1) && IsVaildCollider(((RaycastHit)(ref val)).collider);
		int num = 0;
		while (flag && num < 5)
		{
			num++;
			physicsScene = mBaseEntity.GetWorld().GetPhysicsScene();
			CapsuleCollider obj6 = cacheBodyCollider;
			flag = ((PhysicsScene)(ref physicsScene)).CapsuleCast(vector4, vector6, (obj6 != null) ? obj6.radius : 0f, (vector - base.transform.position).normalized, ref val, (vector - base.transform.position).magnitude, -1, (QueryTriggerInteraction)1) && IsVaildCollider(((RaycastHit)(ref val)).collider);
			if (flag)
			{
				Vector3 point = ((RaycastHit)(ref val)).point;
				point.y = base.transform.position.y;
				vector = CalculateNewTargetPoint(base.transform.position, position, (position - base.transform.position).normalized, point, ((RaycastHit)(ref val)).normal);
			}
		}
		if (flag)
		{
			vector = base.transform.position;
		}
		return vector;
	}

	private Vector3 CalculateNewTargetPoint(Vector3 currentPosition, Vector3 targetPosition, Vector3 currentDirection, Vector3 hitPoint, Vector3 hitNormal)
	{
		Vector3 rhs = hitPoint - currentPosition;
		Vector3 normalized = Vector3.Cross(Vector3.up, rhs).normalized;
		float num = Vector3.Dot(normalized, targetPosition - hitPoint);
		Vector3 vector = hitPoint + normalized * num;
		CapsuleCollider obj = cacheBodyCollider;
		return vector + hitNormal * ((obj != null) ? obj.radius : 0.02f);
	}

	private bool IsVaildCollider(Collider collider, bool isCheckedCld = false)
	{
		if (!isCheckedCld && (UnityEngine.Object)(object)collider == null)
		{
			return false;
		}
		if (((Component)(object)collider).gameObject.CompareTag("AirWall"))
		{
			return !collider.isTrigger;
		}
		if (((Component)(object)collider).gameObject.layer == LayerMask.NameToLayer("Battle"))
		{
			return false;
		}
		if (((Component)(object)collider).gameObject.layer == LayerMask.NameToLayer("AreaTrigger"))
		{
			return false;
		}
		if (((Component)(object)collider).TryGetComponent(out CollisionLayer _))
		{
			return false;
		}
		if (IsGroundCollider(collider))
		{
			return false;
		}
		return !collider.isTrigger;
	}

	private bool IsGroundCollider(Collider collider)
	{
		if (((Component)(object)collider).gameObject.layer == LayerMask.NameToLayer("Ground"))
		{
			return true;
		}
		return false;
	}

	public void Teleport(Vector3 position, MovePriority priority = MovePriority.Teleport)
	{
		if (movePriority <= priority)
		{
			movePriority = priority;
			movementMotor.TeleportToPoint(position, base.transform.rotation);
		}
	}

	public void Teleport(Vector3 position, Quaternion rotation)
	{
		movementMotor.TeleportToPoint(position, rotation);
		if ((bool)entityViewObject)
		{
			entityViewObject.transform.position = position;
			entityViewObject.transform.rotation = rotation;
		}
	}

	public void ImmediatelyRotate(Quaternion rotation)
	{
		movementMotor.SetRotation(rotation);
		if ((bool)entityViewObject)
		{
			entityViewObject.transform.rotation = rotation;
		}
	}

	public void SetRotation(Quaternion rotation, string content)
	{
		if (!movementMotor.TransientRotation.eulerAngles.Equals(rotation.eulerAngles))
		{
			if (positionAndRoationInputCheck && CheckRotation(base.transform.position, rotation))
			{
				rotation = base.transform.rotation;
			}
			movementMotor.RotateCharacter(rotation);
		}
	}

	public void SetRotationForce(Quaternion rotation, string content)
	{
		if (!movementMotor.TransientRotation.eulerAngles.Equals(rotation.eulerAngles))
		{
			movementMotor.RotateCharacter(rotation);
		}
	}

	private Collider[] GetCollidersForCheckRotation()
	{
		for (int i = 0; i < _colliders.Length; i++)
		{
			_colliders[i] = null;
		}
		return _colliders;
	}

	private bool CheckRotation(Vector3 position, Quaternion targetRotation)
	{
		//IL_00be: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c3: Unknown result type (might be due to invalid IL or missing references)
		if (mBaseEntity == null || mBaseEntity.GetWorld() == null)
		{
			return false;
		}
		Collider[] collidersForCheckRotation = GetCollidersForCheckRotation();
		CapsuleCollider obj = cacheBodyCollider;
		Vector3 vector2;
		if (obj == null)
		{
			Vector3 zero = Vector3.zero;
			Vector3 vector = -Vector3.up;
			CapsuleCollider obj2 = cacheBodyCollider;
			vector2 = zero + vector * ((obj2 != null) ? obj2.height : 0f);
		}
		else
		{
			vector2 = obj.center;
		}
		Vector3 vector3 = position + targetRotation * vector2;
		CapsuleCollider obj3 = cacheBodyCollider;
		Vector3 vector4;
		if (obj3 == null)
		{
			Vector3 zero2 = Vector3.zero;
			Vector3 up = Vector3.up;
			CapsuleCollider obj4 = cacheBodyCollider;
			vector4 = zero2 + up * ((obj4 != null) ? obj4.height : 0f);
		}
		else
		{
			vector4 = obj3.center;
		}
		Vector3 vector5 = position + targetRotation * vector4;
		PhysicsScene physicsScene = mBaseEntity.GetWorld().GetPhysicsScene();
		CapsuleCollider obj5 = cacheBodyCollider;
		if (((PhysicsScene)(ref physicsScene)).OverlapCapsule(vector3, vector5, (obj5 != null) ? obj5.radius : 0f, collidersForCheckRotation, -1, (QueryTriggerInteraction)1) > 0)
		{
			for (int i = 0; i < collidersForCheckRotation.Length && !((UnityEngine.Object)(object)collidersForCheckRotation[i] == null); i++)
			{
				if (IsVaildCollider(collidersForCheckRotation[i], isCheckedCld: true))
				{
					return true;
				}
			}
		}
		return false;
	}

	public void RegisterCollisionLayer(EntityCollisionLayer layer)
	{
		cacheEntityCollisionLayer = layer;
	}

	public void RegisterBodyCollider(CapsuleCollider bodyCollider)
	{
		cacheBodyCollider = bodyCollider;
	}

	public void UpdateRotation(ref Quaternion currentRotation, float deltaTime)
	{
	}

	public void UpdateVelocity(ref Vector3 currentVelocity, float deltaTime)
	{
		if (!mBaseEntity.IsSurvival)
		{
			return;
		}
		if (movementMotor.GroundingStatus.IsStableOnGround)
		{
			float magnitude = currentVelocity.magnitude;
			Vector3 groundNormal = movementMotor.GroundingStatus.GroundNormal;
			currentVelocity = movementMotor.GetDirectionTangentToSurface(currentVelocity, groundNormal) * magnitude;
			currentVelocity.x = 0f;
			currentVelocity.z = 0f;
			if (!useGravity)
			{
			}
		}
		else if (useGravity)
		{
			if (dropWaitDead)
			{
				currentVelocity.x = 0f;
				currentVelocity.z = 0f;
			}
			currentVelocity += Gravity * deltaTime;
		}
		if (_internalVelocityAdd.sqrMagnitude > 0f)
		{
			currentVelocity += _internalVelocityAdd;
			_internalVelocityAdd = Vector3.zero;
		}
	}

	public void PostGroundingUpdate(float deltaTime)
	{
		if (!mBaseEntity.GetWorld().IsStoryWorld || !mBaseEntity.IsActorEntity || mBaseEntity.GetComponent<ClimbMovementComponent>().IsClimbing)
		{
			return;
		}
		if (movementMotor.LastGroundingStatus.Teleport)
		{
			movementMotor.LastGroundingStatus.Teleport = false;
			return;
		}
		if (movementMotor.GroundingStatus.IsStableOnGround)
		{
			if (decelerGroundgObj != ((Component)(object)movementMotor.GroundingStatus.GroundCollider).gameObject)
			{
				decelerGroundgObj = ((Component)(object)movementMotor.GroundingStatus.GroundCollider).gameObject;
				GroundDecelerationTag component = ((Component)(object)movementMotor.GroundingStatus.GroundCollider).gameObject.GetComponent<GroundDecelerationTag>();
				if (component == null)
				{
					deceleration = 1f;
				}
				else
				{
					deceleration = component.DecelerationValue;
				}
			}
		}
		else
		{
			deceleration = 1f;
		}
		if (movementMotor.GroundingStatus.IsStableOnGround && !movementMotor.LastGroundingStatus.IsStableOnGround)
		{
			DrawSphere(movementMotor.GroundingStatus.GroundPoint);
			OnLanded();
		}
		else if (!movementMotor.GroundingStatus.IsStableOnGround && movementMotor.LastGroundingStatus.IsStableOnGround)
		{
			DrawSphere(movementMotor.LastGroundingStatus.GroundPoint);
			StartDrop();
		}
		else if (!movementMotor.GroundingStatus.IsStableOnGround && !movementMotor.LastGroundingStatus.IsStableOnGround)
		{
			DrawSphere(movementMotor.LastGroundingStatus.GroundPoint);
			DropHanding();
		}
	}

	private void DrawSphere(Vector3 groundPoint)
	{
		_ = base.Entity.GetWorld().IsStoryWorld;
	}

	private void ExitDropState()
	{
		foreach (HeroEntity item in mBaseEntity.GetSystem<EntitySystem>().GetTeamHero())
		{
			if (!item.IsActorEntity)
			{
				item.GetComponent<AIParadoxComponent>().SetVariableValues("HeroAiStage", HeroAIStageEnum.Drop);
			}
		}
		movementMotor.OnDead();
	}

	private void StartDrop()
	{
		dropHanding = true;
		startDropY = movementMotor.TransientPosition.y;
	}

	private async void DropHanding()
	{
		if (!dropWaitDead && dropHanding && startDropY - movementMotor.TransientPosition.y >= dropMaxHeight)
		{
			dropWaitDead = true;
			ShowDeadVirtualCamera();
			await UniTask.WaitForSeconds(1f);
			ForceToDead();
		}
	}

	private bool RaycastDetecLine(Vector3 position, Vector3 direct, out RaycastHit finalRaycastHit, float checkDistance, float step)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d4: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d5: Unknown result type (might be due to invalid IL or missing references)
		//IL_0166: Unknown result type (might be due to invalid IL or missing references)
		//IL_0168: Unknown result type (might be due to invalid IL or missing references)
		RaycastHit val = default(RaycastHit);
		float num = float.MaxValue;
		bool result = false;
		List<Vector3> list = new List<Vector3>();
		list.Add(position);
		for (int i = 0; i < 8; i++)
		{
			float f = (float)(i * 2) * MathF.PI / 8f;
			float x = position.x + Mathf.Cos(f) * cacheBodyCollider.radius;
			float z = position.z + Mathf.Sin(f) * cacheBodyCollider.radius;
			list.Add(new Vector3(x, position.y, z));
		}
		RaycastHit val2 = default(RaycastHit);
		foreach (Vector3 item in list)
		{
			Vector3 vector = item;
			float num2 = checkDistance;
			while (num2 > 0f)
			{
				if (Physics.Raycast(vector, direct, ref val2, num2, 1 << LayerMask.NameToLayer("Ground")) && ((RaycastHit)(ref val2)).distance < num)
				{
					HitStabilityReport stabilityReport = default(HitStabilityReport);
					movementMotor.EvaluateHitStability(((RaycastHit)(ref val2)).collider, ((RaycastHit)(ref val2)).normal, ((RaycastHit)(ref val2)).point, ((RaycastHit)(ref val2)).point, movementMotor.TransientRotation, -movementMotor.CharacterUp, ref stabilityReport);
					if (stabilityReport.IsStable && Vector3.Angle(Vector3.up, ((RaycastHit)(ref val2)).normal) <= 60f && Vector3.Dot(((RaycastHit)(ref val2)).normal, Vector3.up) > 0f)
					{
						num = ((RaycastHit)(ref val2)).distance;
						val = val2;
						num2 = 0f;
						result = true;
					}
					else
					{
						vector = ((RaycastHit)(ref val2)).point - new Vector3(0f, step, 0f);
						num2 -= ((RaycastHit)(ref val2)).distance + step;
					}
				}
				else
				{
					num2 = 0f;
				}
			}
		}
		finalRaycastHit = val;
		return result;
	}

	private List<RaycastHit> RaycastDetec(Vector3 bottom, Vector3 top, float checkDistance, float step)
	{
		//IL_0087: Unknown result type (might be due to invalid IL or missing references)
		List<RaycastHit> list = new List<RaycastHit>();
		RaycastHit item = default(RaycastHit);
		while (checkDistance > 0f)
		{
			Vector3 vector = bottom;
			Vector3 vector2 = top;
			CapsuleCollider obj = cacheBodyCollider;
			if (Physics.CapsuleCast(vector, vector2, (obj != null) ? obj.radius : 0f, -movementMotor.CharacterUp, ref item, checkDistance, 1 << LayerMask.NameToLayer("Ground")))
			{
				float num = top.y - ((RaycastHit)(ref item)).point.y;
				top.y -= num + step;
				bottom.y -= num + step;
				checkDistance -= num + step;
				list.Add(item);
			}
			else
			{
				checkDistance = 0f;
			}
		}
		return list;
	}

	public override void OnEntityReborn()
	{
		base.OnEntityReborn();
		if (dropHanding)
		{
			dropHanding = false;
			startDropY = 0f;
			ExitDropState();
		}
		if (dropWaitDead)
		{
			dropWaitDead = false;
			ExitDropState();
		}
		CloseDeadVirtualCamera();
	}

	private void OnLanded()
	{
		if (!dropHanding)
		{
			return;
		}
		ExitDropState();
		float num = startDropY - movementMotor.TransientPosition.y;
		if (num <= droplowLevelHeight)
		{
			dropHanding = false;
		}
		else if (num > 0f)
		{
			float propertyMax = mBaseEntity.GetPropertyMax("Hp");
			float propertyCur = mBaseEntity.GetPropertyCur("Hp");
			float num2 = num * dropReduceHpPercent * propertyMax;
			if (num2 >= propertyCur)
			{
				ForceToDead();
				return;
			}
			ReduceHp(Mathf.CeilToInt(num2));
			dropHanding = false;
		}
	}

	private void CreateDeadVirtualCamera()
	{
		if (base.Entity.IsActorEntity)
		{
			_ = cameraId;
			_ = 0;
		}
	}

	private void ShowDeadVirtualCamera()
	{
		if (base.Entity.IsActorEntity)
		{
			_ = cameraId;
			_ = 0;
		}
	}

	private void CloseDeadVirtualCamera()
	{
		if (base.Entity.IsActorEntity)
		{
			_ = cameraId;
			_ = 0;
		}
	}

	private void DestroyDeadVirtualCamera()
	{
		if (base.Entity.IsActorEntity && cameraId > 0)
		{
			base.Entity.GetSystem<VirtualCameraSystem>().RestBlendTime();
			cameraId = 0;
			if (deadVirtualCameraPoint != null)
			{
				UnityEngine.Object.Destroy(deadVirtualCameraPoint);
				deadVirtualCameraPoint = null;
			}
		}
	}

	private void RecordLastStandPosition(bool force = false)
	{
		recordTime -= Time.deltaTime;
		if (force || recordTime <= 0f)
		{
			recordTime = 0.3f;
			if (lastStandPositions == null)
			{
				lastStandPositions = new List<Vector3>();
			}
			lastStandPositions.Add(movementMotor.InitialSimulationPosition);
			if (lastStandPositions.Count > 20)
			{
				lastStandPositions.RemoveAt(0);
			}
		}
	}

	private Vector3 GetVaildPosition()
	{
		if (lastStandPositions == null || lastStandPositions.Count <= 0)
		{
			return base.Entity.transform.position;
		}
		Vector3 position = lastStandPositions[lastStandPositions.Count - 1];
		for (int num = lastStandPositions.Count - 1; num >= 0; num--)
		{
			if (base.Entity.GetSystem<PathfindingSystem>().GetVaildPoint(lastStandPositions[num], out position))
			{
				return position;
			}
		}
		return position;
	}

	public void BeforeCharacterUpdate(float deltaTime)
	{
		obstructCount = 0;
		obstructAirWallCount = 0;
		obstructWallCount = 0;
	}

	public void AfterCharacterUpdate(float deltaTime)
	{
		obstructState = obstructCount > 0;
		obstructAirWallState = obstructAirWallCount > 0;
		obstructWallState = obstructWallCount > 0;
		if (movementMotor.GroundingStatus.FoundAnyGround && movementMotor.GroundingStatus.IsStableOnGround)
		{
			RecordLastStandPosition();
		}
	}

	public bool IsColliderValidForCollisions(Collider coll)
	{
		if (IgnoredColliders.Contains(coll))
		{
			return false;
		}
		if (cacheEntityCollisionLayer == null)
		{
			return false;
		}
		if (cacheEntityCollisionLayer.others.Contains(coll))
		{
			return false;
		}
		if (((Component)(object)coll).TryGetComponent(out CollisionLayer component))
		{
			if (ImmuneColliderCheck(coll, component))
			{
				return false;
			}
			if (IgnoredLayers != CollisionSetting.CollisionLayer.None && CollisionSetting.CollisionCheck(IgnoredLayers, component.Layer))
			{
				return false;
			}
			if (CollisionSetting.ObstacleCheck(CollisionSetting.GetObstacleLayer(cacheEntityCollisionLayer.Layer), component.Layer))
			{
				obstructCount++;
				return true;
			}
			if (CollisionSetting.ObstacleCheck(CollisionSetting.GetObstacleLayer(component.Layer), cacheEntityCollisionLayer.Layer))
			{
				return false;
			}
			if (CollisionSetting.CollisionCheck(CollisionSetting.GetMaskLayer(cacheEntityCollisionLayer.Layer), component.Layer))
			{
				return cacheEntityCollisionLayer.Mass <= component.Mass;
			}
			return false;
		}
		if (((Component)(object)coll).CompareTag("AirWall"))
		{
			obstructAirWallCount++;
		}
		return true;
	}

	private bool ImmuneColliderCheck(Collider collider, CollisionLayer collisionLayer)
	{
		if (collisionLayer.CollisionType != "Entity")
		{
			return false;
		}
		StateComponent component = mBaseEntity.GetComponent<StateComponent>();
		if (component == null)
		{
			return false;
		}
		if (((Component)(object)collider).TryGetComponent(out EntityView component2) && component2.Entity != null)
		{
			StateComponent component3 = component2.Entity.GetComponent<StateComponent>();
			if (component3 != null)
			{
				if (!component.ImmuneRelationCollider(mBaseEntity, component3.Entity))
				{
					return component3.ImmuneRelationCollider(mBaseEntity, component3.Entity);
				}
				return true;
			}
		}
		if (component.ImmuneCollider())
		{
			return true;
		}
		return false;
	}

	public override void OnEntityRelease()
	{
		if (base.Entity.IsSyncPhysicsEntity)
		{
			base.OnEntityRelease();
			mBaseEntity.GetSystem<KinematicCharacterSystem>().UnregisterCharacterMotor(movementMotor);
		}
	}

	public bool GetObstructState()
	{
		return obstructState;
	}

	public bool GetObstructAirWallState()
	{
		//IL_00bf: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c4: Unknown result type (might be due to invalid IL or missing references)
		if (!mBaseEntity.IsActorEntity && mBaseEntity.GetEntityType() == EntityType.HERO)
		{
			if (nextCheckTime > Time.time)
			{
				return false;
			}
			nextCheckTime = Time.time + 0.5f;
			BaseEntity baseEntity = mBaseEntity.GetSystem<EntitySystem>()?.GetEntity(mBaseEntity.GetWorld().ActorId);
			if (baseEntity == null)
			{
				return false;
			}
			Vector3 position = baseEntity.transform.position;
			Vector3 position2 = base.transform.position;
			position.y++;
			position2.y = position.y;
			Vector3 vector = position2 - position;
			RaycastHit[] raycastHits4AirWall = RaycastHits4AirWall;
			PhysicsScene physicsScene = mBaseEntity.GetWorld().GetPhysicsScene();
			int num = ((PhysicsScene)(ref physicsScene)).Raycast(position, vector.normalized, raycastHits4AirWall, vector.magnitude, -1, (QueryTriggerInteraction)1);
			if (num > 0)
			{
				for (int i = 0; i < num; i++)
				{
					if ((UnityEngine.Object)(object)((RaycastHit)(ref raycastHits4AirWall[i])).collider != null && ((Component)(object)((RaycastHit)(ref raycastHits4AirWall[i])).collider).gameObject.CompareTag("AirWall"))
					{
						return true;
					}
				}
			}
			return false;
		}
		return obstructAirWallState;
	}

	private void ReduceHp(int hp)
	{
		mBaseEntity.GetComponent<HpComponent>().ReduceHp(hp);
	}

	private void ForceToDead()
	{
		mBaseEntity.GetComponent<HpComponent>().ForceToDead();
	}

	public bool GetObstructWallState()
	{
		return obstructWallState;
	}

	public override void OnDispose()
	{
		if (movementMotor != null)
		{
			movementMotor.OnDispose();
			movementMotor = null;
		}
		DestroyDeadVirtualCamera();
		base.OnDispose();
	}

	public Vector3 GetCurrentMoveDir()
	{
		return movementMotor.GetCurrentMoveDir();
	}

	public void SetUseGravity(bool useGravity)
	{
		this.useGravity = useGravity;
	}

	public void SetGroundSolvingActivation(bool stabilitySolvingActive)
	{
		movementMotor?.SetGroundSolvingActivation(stabilitySolvingActive);
	}

	public void SetMovementCollisionsSolvingActivation(bool movementCollisionsSolvingActive)
	{
		movementMotor?.SetMovementCollisionsSolvingActivation(movementCollisionsSolvingActive);
	}

	public void SetWallCollisionSolvingActivation(bool wallCollisionSolvingActivation)
	{
		movementMotor?.SetWallCollisionSolvingActivation(wallCollisionSolvingActivation);
	}

	public void OnDiscreteCollisionDetected(Collider hitCollider)
	{
	}

	public void OnGroundHit(Collider hitCollider, Vector3 hitNormal, Vector3 hitPoint, ref HitStabilityReport hitStabilityReport)
	{
	}

	public void OnMovementHit(Collider hitCollider, Vector3 hitNormal, Vector3 hitPoint, ref HitStabilityReport hitStabilityReport)
	{
	}

	public void ProcessHitStabilityReport(Collider hitCollider, Vector3 hitNormal, Vector3 hitPoint, Vector3 atCharacterPosition, Quaternion atCharacterRotation, ref HitStabilityReport hitStabilityReport)
	{
	}

	public MovementMotorBase GetMotor()
	{
		return movementMotor;
	}

	public bool CheckMovementCollision(float distance, Vector3 checkDir, out RaycastHit raycastHit, float radius = 0f)
	{
		//IL_0080: Unknown result type (might be due to invalid IL or missing references)
		//IL_0085: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b8: Unknown result type (might be due to invalid IL or missing references)
		Vector3 vector = movementMotor.TransientPosition + movementMotor.TransientRotation * movementMotor.CharacterTransformToCapsuleBottomHemi;
		Vector3 vector2 = movementMotor.TransientPosition + movementMotor.TransientRotation * movementMotor.CharacterTransformToCapsuleTopHemi;
		if (radius == 0f)
		{
			radius = cacheBodyCollider.radius;
		}
		RaycastHit[] raycastHits = RaycastHits;
		PhysicsScene physicsScene = base.Entity.GetWorld().GetPhysicsScene();
		int num = ((PhysicsScene)(ref physicsScene)).CapsuleCast(vector, vector2, radius, checkDir, raycastHits, distance, 1 << LayerMask.NameToLayer("Battle"), (QueryTriggerInteraction)1);
		if (num > 0 && CheckIsCollisionMonster(num, raycastHits, out raycastHit))
		{
			return true;
		}
		raycastHit = default(RaycastHit);
		return false;
	}

	private bool CheckIsCollisionMonster(int hitCount, RaycastHit[] raycastHits, out RaycastHit outRaycastHit)
	{
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b8: Unknown result type (might be due to invalid IL or missing references)
		//IL_005c: Unknown result type (might be due to invalid IL or missing references)
		//IL_005d: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a5: Unknown result type (might be due to invalid IL or missing references)
		for (int i = 0; i < hitCount; i++)
		{
			RaycastHit val = raycastHits[i];
			if (!((UnityEngine.Object)(object)((RaycastHit)(ref val)).collider == null))
			{
				if (((Component)(object)((RaycastHit)(ref val)).collider).TryGetComponent(out EntityCollisionLayer component) && cacheEntityCollisionLayer.Layer == CollisionSetting.CollisionLayer.Hero && (component.Layer == CollisionSetting.CollisionLayer.Monster || component.Layer == CollisionSetting.CollisionLayer.Boss || component.Layer == CollisionSetting.CollisionLayer.Interactive))
				{
					outRaycastHit = val;
					return true;
				}
				if (component != null && cacheEntityCollisionLayer.Layer == CollisionSetting.CollisionLayer.ShadowHero && (component.Layer == CollisionSetting.CollisionLayer.ShadowMonster || component.Layer == CollisionSetting.CollisionLayer.ShadowBoss || component.Layer == CollisionSetting.CollisionLayer.Interactive))
				{
					outRaycastHit = val;
					return true;
				}
			}
		}
		outRaycastHit = default(RaycastHit);
		return false;
	}
}
