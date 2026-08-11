using UnityEngine;
using UnityEngine.AI;

namespace Ase.ECS;

public class PathfindingComponent : BaseComponent
{
	private float _moveTime;

	private int _updateTypeId;

	private AnimatorComponent animatorComponent;

	private float attackDistance = 3f;

	private Vector3 currentVelocity;

	private bool enableRotation = true;

	private bool interpolatePathSwitches = true;

	private PathInterpolator interpolator = new PathInterpolator();

	private bool isMoving;

	private uint startMoveFrame;

	private KinematicMoveComponent moveComponent;

	private float moveSpeed = 3f;

	private float _lerpMoveSpeed;

	private NavMeshPath path;

	private float pathSwitchInterpolationTime;

	private Vector3 previousMovementDirection;

	private Vector3 previousMovementOrigin;

	private float remainingDistance = 1f;

	private float rotationSpeed = 360f;

	private Vector3 simulatedPosition;

	private Quaternion simulatedRotation;

	private float switchPathInterpolationSpeed = 5f;

	private bool updatePosition = true;

	private bool updateRotation = true;

	private int agentTypeId;

	private int areaType;

	private bool isPause;

	private bool alwaysForward;

	private Vector3 lastTargetPoint = Vector3.zero;

	private EntityViewComponent EntityView;

	private int _lastMoveState = -1;

	private bool reachedEndOfPath { get; set; }

	private bool isStopped { get; set; }

	public bool IsMoving => isMoving;

	public override void OnAwake(object data = null)
	{
		moveSpeed = mBaseEntity.GetProperty("Speed");
		attackDistance = mBaseEntity.GetProperty("AttackDistance");
		animatorComponent = mBaseEntity.GetComponent<AnimatorComponent>();
		moveComponent = mBaseEntity.GetComponent<KinematicMoveComponent>();
		RefreshAgentTypeId();
		areaType = ((mBaseEntity.GetEntityType() == EntityType.MONSTER && base.Entity.GetWorld().IsStoryWorld) ? (1 << NavMesh.GetAreaFromName("Monster Walkable")) : ((1 << NavMesh.GetAreaFromName("Walkable")) | (1 << NavMesh.GetAreaFromName("Monster Walkable"))));
	}

	public void RefreshAgentTypeId()
	{
		agentTypeId = mBaseEntity.GetSystem<PathfindingSystem>().GetAgentTypeId();
	}

	public override void OnStart(object data = null)
	{
		CheckAnimEnable();
	}

	public void SwitchUpdateRotation(bool updateRotation)
	{
		this.updateRotation = updateRotation;
	}

	public bool IsUpdateRotation()
	{
		return updateRotation;
	}

	private bool CheckAnimEnable()
	{
		if (mBaseEntity is HeroEntity heroEntity)
		{
			if (heroEntity.IsAi || heroEntity.InFreedomBattleMode())
			{
				return true;
			}
			return false;
		}
		return true;
	}

	public void MoveToTarget(Vector3 position, float executeTime, float distance = 2f)
	{
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Expected O, but got Unknown
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_0075: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		moveSpeed = mBaseEntity.GetProperty("Speed");
		RefreshAgentTypeId();
		remainingDistance = Mathf.Clamp(distance, 0.001f, 100f);
		NavMeshPath val = new NavMeshPath();
		val.ClearCorners();
		if (agentTypeId == 0)
		{
			SetPath(val);
			return;
		}
		NavMeshQueryFilter val2 = default(NavMeshQueryFilter);
		((NavMeshQueryFilter)(ref val2)).agentTypeID = agentTypeId;
		((NavMeshQueryFilter)(ref val2)).areaMask = areaType;
		NavMeshQueryFilter val3 = val2;
		NavMesh.CalculatePath(base.transform.position, position, val3, val);
		_moveTime = executeTime;
		SetPath(val);
	}

	public void Teleport(Vector3 destination)
	{
		RefreshAgentTypeId();
		NavMeshHit val = default(NavMeshHit);
		if (NavMesh.SamplePosition(destination, ref val, 100f, -1))
		{
			base.transform.position = ((NavMeshHit)(ref val)).position;
		}
	}

	public void NavMeshStop()
	{
		ClearPath();
	}

	private Vector3 GetAttackPoint(Vector3 targetPosition)
	{
		Vector3 normalized = (targetPosition - base.transform.position).normalized;
		normalized.y = 0f;
		return targetPosition - normalized * attackDistance;
	}

	public void OpenAlwaysForward(float excuteTime, float distance, bool alwaysForward = true, bool shieldUpdateRotation = true)
	{
		this.alwaysForward = alwaysForward;
		EntityView = mBaseEntity.GetComponent<EntityViewComponent>();
		GetTheNearestCanMovePoint(EntityView.EntityView.transform.forward + EntityView.EntityView.transform.position, 1f, out lastTargetPoint);
		MoveToTarget(lastTargetPoint, excuteTime, distance);
		if (shieldUpdateRotation)
		{
			updateRotation = false;
		}
	}

	private void UpdateAlwaysForward()
	{
		if (alwaysForward)
		{
			GetTheNearestCanMovePoint(EntityView.EntityView.transform.forward + EntityView.EntityView.transform.position, 1f, out var result);
			if (lastTargetPoint != result)
			{
				MoveToTarget(result, _moveTime, remainingDistance);
				lastTargetPoint = result;
			}
		}
	}

	public void SheildAlwaysForward(bool alwaysForward = false, bool openUpdateRotation = true)
	{
		this.alwaysForward = alwaysForward;
		NavMeshStop();
		if (openUpdateRotation)
		{
			updateRotation = true;
		}
	}

	public override void OnPause()
	{
		base.OnPause();
		isPause = true;
	}

	public override void OnResume()
	{
		base.OnResume();
		isPause = false;
	}

	public override void OnUpdate(float deltaTime)
	{
		if (isPause || animatorComponent == null || !CheckAnimEnable())
		{
			return;
		}
		if (isMoving)
		{
			bool flag = currentVelocity != Vector3.zero;
			int num = (flag ? 1 : 0);
			if (_lastMoveState != num)
			{
				animatorComponent.SetBool(AnimationParameters.Moving, flag);
				_lastMoveState = num;
			}
			float property = mBaseEntity.GetProperty("Speed");
			if (_lerpMoveSpeed != property)
			{
				_lerpMoveSpeed = TSUtil.MoveSpeedLerp(_lerpMoveSpeed, property, 0.2f);
				animatorComponent.SetFloat(AnimationParameters.MoveSpeed, _lerpMoveSpeed);
			}
		}
		else if (OnCheckAnimChange())
		{
			if (_lastMoveState != 0)
			{
				animatorComponent.SetBool(AnimationParameters.Moving, value: false);
				_lastMoveState = 0;
			}
			if (_lerpMoveSpeed != 0f)
			{
				_lerpMoveSpeed = TSUtil.MoveSpeedLerp(_lerpMoveSpeed, 0f, 0.2f);
				animatorComponent.SetFloat(AnimationParameters.MoveSpeed, _lerpMoveSpeed);
			}
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (!isPause && isMoving)
		{
			_moveTime -= deltaTime;
			if (_moveTime < 0f)
			{
				NavMeshStop();
			}
			UpdateAlwaysForward();
			MovementUpdate(deltaTime, out var nextPosition, out var nextRotation);
			FinalizeMovement(nextPosition, nextRotation);
		}
	}

	private bool OnCheckAnimChange()
	{
		if (mBaseEntity is HeroEntity)
		{
			return mBaseEntity.GetWorld().LocalTick - startMoveFrame >= 3;
		}
		return true;
	}

	private void OnTargetReached()
	{
		isMoving = false;
	}

	private void SetPath(NavMeshPath newPath)
	{
		//IL_0004: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Invalid comparison between Unknown and I4
		if (newPath != null && (int)newPath.status != 2)
		{
			if (interpolatePathSwitches)
			{
				ConfigurePathSwitchInterpolation();
			}
			NavMeshPath val = path;
			path = newPath;
			reachedEndOfPath = false;
			isMoving = true;
			startMoveFrame = mBaseEntity.GetWorld().LocalTick;
			ConfigureNewPath();
			if (val != null)
			{
				val.ClearCorners();
				val = null;
			}
			if (interpolator.remainingDistance <= remainingDistance && !reachedEndOfPath)
			{
				reachedEndOfPath = true;
				OnTargetReached();
			}
		}
	}

	private void ClearPath()
	{
		reachedEndOfPath = false;
		isMoving = false;
		if (path != null)
		{
			path.ClearCorners();
		}
		path = null;
		interpolator.PathClear();
	}

	private void ConfigurePathSwitchInterpolation()
	{
		bool flag = interpolator.valid && interpolator.remainingDistance < 0.0001f;
		if (interpolator.valid && !flag)
		{
			previousMovementOrigin = mBaseEntity.transform.position;
			previousMovementDirection = (interpolator.tangent.normalized * interpolator.remainingDistance).normalized;
			pathSwitchInterpolationTime = 0f;
		}
		else
		{
			previousMovementOrigin = Vector3.zero;
			previousMovementDirection = Vector3.zero;
			pathSwitchInterpolationTime = float.PositiveInfinity;
		}
	}

	private Vector3 GetFeetPosition()
	{
		return mBaseEntity.transform.position;
	}

	private void ConfigureNewPath()
	{
		bool valid = interpolator.valid;
		Vector3 vector = (valid ? interpolator.tangent : Vector3.zero);
		interpolator.SetPath(path.corners);
		interpolator.MoveToClosestPoint(GetFeetPosition());
		if ((interpolatePathSwitches && switchPathInterpolationSpeed > 0.01f) & valid)
		{
			float num = Mathf.Max(0f - Vector3.Dot(vector.normalized, interpolator.tangent.normalized), 0f);
			interpolator.distance -= moveSpeed * num * (1f / switchPathInterpolationSpeed);
		}
	}

	private void MovementUpdate(float deltaTime, out Vector3 nextPosition, out Quaternion nextRotation)
	{
		if (updatePosition)
		{
			simulatedPosition = base.transform.position;
		}
		if (updateRotation)
		{
			simulatedRotation = base.transform.rotation;
		}
		nextPosition = CalculateNextPosition(out var direction, isStopped ? 0f : deltaTime);
		direction.y = 0f;
		nextRotation = (enableRotation ? SimulateRotationTowards(direction, deltaTime) : simulatedRotation);
		currentVelocity = direction;
	}

	private void FinalizeMovement(Vector3 nextPosition, Quaternion nextRotation)
	{
		simulatedPosition = nextPosition;
		simulatedRotation = nextRotation;
		if (updatePosition)
		{
			if (mBaseEntity.GetEntityType() == EntityType.HERO)
			{
				moveComponent.SetPosition(nextPosition, "寻路");
			}
			else
			{
				moveComponent.SetPosition(nextPosition, "寻路");
			}
		}
		if (updateRotation)
		{
			moveComponent.SetRotation(nextRotation, "寻路");
		}
	}

	private Quaternion SimulateRotationTowards(Vector3 direction, float deltaTime)
	{
		if (direction != Vector3.zero)
		{
			Quaternion to = Quaternion.LookRotation(direction, Vector3.up);
			return Quaternion.RotateTowards(simulatedRotation, to, deltaTime * mBaseEntity.GetProperty("RotateSpeed"));
		}
		return simulatedRotation;
	}

	private Vector3 CalculateNextPosition(out Vector3 direction, float deltaTime)
	{
		if (!interpolator.valid)
		{
			direction = Vector3.zero;
			return simulatedPosition;
		}
		interpolator.distance += deltaTime * moveSpeed;
		if (interpolator.remainingDistance <= remainingDistance && !reachedEndOfPath)
		{
			reachedEndOfPath = true;
			OnTargetReached();
		}
		direction = interpolator.tangent;
		pathSwitchInterpolationTime += deltaTime;
		float num = switchPathInterpolationSpeed * pathSwitchInterpolationTime;
		if (interpolatePathSwitches && num < 1f)
		{
			return mBaseEntity.transform.position + previousMovementDirection * (moveSpeed * deltaTime);
		}
		return interpolator.position;
	}

	public bool GetTheNearestCanMovePoint(Vector3 targetPosition, float maxDistance, out Vector3 result)
	{
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		result = Vector3.zero;
		RefreshAgentTypeId();
		if (agentTypeId == 0)
		{
			return false;
		}
		NavMeshQueryFilter val = default(NavMeshQueryFilter);
		((NavMeshQueryFilter)(ref val)).agentTypeID = agentTypeId;
		((NavMeshQueryFilter)(ref val)).areaMask = -1;
		NavMeshQueryFilter val2 = val;
		NavMeshHit val3 = default(NavMeshHit);
		if (NavMesh.SamplePosition(targetPosition, ref val3, 100f, val2))
		{
			result = ((NavMeshHit)(ref val3)).position;
			return true;
		}
		return false;
	}
}
