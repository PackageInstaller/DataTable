using System.Collections.Generic;
using TrueSync;
using TrueSync.Physics2D;

public class DeterministicCollisionManager : SceneSingleton<DeterministicCollisionManager>
{
	public bool enableDebugView;

	public bool isSetTsEnable;

	protected readonly List<DeterministicCollider> _collisionDetectList = new List<DeterministicCollider>(20);

	protected readonly List<DeterministicCollider> _internalOverlapedColliders = new List<DeterministicCollider>(20);

	protected readonly List<DeterministicCollider> _internalOverlapedColliders2 = new List<DeterministicCollider>(20);

	protected LogManager.Logger _logger;

	private const float kDebugDrawDuration = 0.1f;

	protected readonly List<DeterministicCollider> _delayInsertColliders = new List<DeterministicCollider>();

	protected readonly List<DeterministicCollider> _delayDropColliders = new List<DeterministicCollider>();

	internal readonly DeterministicCollisionUtils.DeterministicRaycastHitComparer _deterministicRaycastHitComparer = new DeterministicCollisionUtils.DeterministicRaycastHitComparer();

	protected readonly List<DeterministicRaycastHit> _internalHitInfos = new List<DeterministicRaycastHit>();

	protected readonly List<DeterministicRaycastHit> _internalSphereCastHitCandidates = new List<DeterministicRaycastHit>();

	private readonly DeterministicRaycastHit[] _internalSphereCastHitProbes = new DeterministicRaycastHit[3];

	private int _internalSphereCastHitProbeCount;

	protected readonly EdgeShape _internalCheckOverlapEdgeShape = new EdgeShape();

	protected readonly CircleShape _internalCheckOverlapCircleShape = new CircleShape(FP.Zero, FP.Zero);

	protected readonly PolygonShape _internalCheckOverlapPolygonShape = new PolygonShape(FP.Zero);

	protected Transform _internalCheckOverTransform;

	public DeterministicCollisionQuadTreeNode quadTree { get; protected set; }

	public List<DeterministicCollider> colliders { get; protected set; } = new List<DeterministicCollider>(250);

	public bool lockCollidersListUpdate { get; set; }

	protected override void Awake()
	{
		base.Awake();
		_logger = Singleton<LogManager>.Instance.get_Item("DeterministicCollisionDetection");
	}

	public void Initialize(FP worldSize, FP minSize)
	{
		quadTree = new DeterministicCollisionQuadTreeNode(worldSize, minSize, 1.2f, TSVector2.zero);
		_logger.LogInfo("Initialize DeterministicCollisionManager with world size:" + worldSize.ToString() + " min node size:" + minSize.ToString());
	}

	public void RegisterCollider(DeterministicCollider deterministicCollider, bool ignoreLock = false)
	{
		if (lockCollidersListUpdate && !ignoreLock)
		{
			if (!_delayDropColliders.Remove(deterministicCollider))
			{
				_delayInsertColliders.Add(deterministicCollider);
			}
		}
		else if (!colliders.Contains(deterministicCollider))
		{
			colliders.Add(deterministicCollider);
			AddToQuadTree(deterministicCollider);
		}
		else
		{
			_logger.LogWarning("重复注册碰撞体:" + deterministicCollider.gameObject.name);
		}
	}

	public void UnRegisterCollider(DeterministicCollider deterministicCollider, bool ignoreLock = false)
	{
		if (lockCollidersListUpdate && !ignoreLock)
		{
			if (!_delayInsertColliders.Remove(deterministicCollider))
			{
				_delayDropColliders.Add(deterministicCollider);
			}
		}
		else if (colliders.Remove(deterministicCollider))
		{
			RemoveFromQuadTree(deterministicCollider);
		}
		else
		{
			_logger.LogWarning("重复注销碰撞体:" + deterministicCollider.gameObject.name);
		}
	}

	internal void UpdateCollidersList()
	{
		for (int i = 0; i < _delayDropColliders.Count; i++)
		{
			UnRegisterCollider(_delayDropColliders.get_Item(i));
		}
		_delayDropColliders.Clear();
		for (int j = 0; j < _delayInsertColliders.Count; j++)
		{
			RegisterCollider(_delayInsertColliders.get_Item(j));
		}
		_delayInsertColliders.Clear();
	}

	protected void AddToQuadTree(DeterministicCollider deterministicCollider)
	{
		deterministicCollider.UpdateColliderTransform();
		if (quadTree.AddWithGrow(deterministicCollider, out var newRootNode))
		{
			if (quadTree != newRootNode)
			{
				_logger.LogInfo($"四叉树空间扩大到:{quadTree.baseLength}");
			}
			quadTree = newRootNode;
		}
		else
		{
			_logger.LogError("无法将碰撞体加入四叉树空间:" + deterministicCollider.gameObject.name);
		}
	}

	protected void RemoveFromQuadTree(DeterministicCollider deterministicCollider)
	{
		if (!quadTree.Remove(deterministicCollider))
		{
			_logger.LogError("将碰撞体从四叉树空间中移除但碰撞体已不在四叉树中:" + deterministicCollider.gameObject.name);
		}
	}

	public bool Raycast(ref TSVector2 origin, ref TSVector2 direction, out DeterministicRaycastHit hitInfo, FP maxDistance, int layerMask = -5)
	{
		hitInfo = new DeterministicRaycastHit
		{
			isValid = false
		};
		RaycastAll(ref origin, ref direction, _internalHitInfos, maxDistance, layerMask);
		if (_internalHitInfos.Count <= 0)
		{
			return false;
		}
		hitInfo = _internalHitInfos.get_Item(0);
		return true;
	}

	public void RaycastAll(ref TSVector2 origin, ref TSVector2 direction, List<DeterministicRaycastHit> hitInfos, FP maxDistance, int layerMask = -5)
	{
		hitInfos.Clear();
		TSVector2 value = origin + direction * maxDistance;
		TSVector2 min = TSVector2.Min(origin, value);
		TSVector2 max = TSVector2.Max(origin, value);
		AABB checkBounds = new AABB(min, max);
		quadTree.GetColliding(ref checkBounds, _collisionDetectList);
		for (int i = 0; i < _collisionDetectList.Count; i++)
		{
			DeterministicCollider deterministicCollider = _collisionDetectList.get_Item(i);
			if (!DeterministicCollisionUtils.IsColliderFilter(deterministicCollider, layerMask) && deterministicCollider.Raycast(ref origin, ref direction, out var hitInfo, maxDistance))
			{
				hitInfos.Add(hitInfo);
			}
		}
		hitInfos.Sort(_deterministicRaycastHitComparer);
	}

	public bool SphereCast(ref TSVector2 origin, ref TSVector2 direction, out DeterministicRaycastHit hitInfo, FP maxDistance, FP radius, int layerMask = -5)
	{
		hitInfo = new DeterministicRaycastHit
		{
			isValid = false
		};
		SphereCastAll(ref origin, ref direction, _internalHitInfos, maxDistance, radius, layerMask);
		if (_internalHitInfos.Count <= 0)
		{
			return false;
		}
		hitInfo = _internalHitInfos.get_Item(0);
		return true;
	}

	public void SphereCastAll(ref TSVector2 origin, ref TSVector2 direction, List<DeterministicRaycastHit> hitInfos, FP maxDistance, FP radius, int layerMask = -5)
	{
		hitInfos.Clear();
		TSVector2 tSVector = origin - direction * radius;
		FP fP = (maxDistance + 2f * radius) * 0.5f;
		TSVector2 position = tSVector + direction * fP;
		DeterministicCollisionUtils.CreateRectangleShape(_internalCheckOverlapPolygonShape, radius, fP);
		FP angle = direction.GetAngle() * FP.Deg2Rad;
		_internalCheckOverTransform.Set(position, angle);
		if (!CheckOverlap_Internal(_internalCheckOverlapPolygonShape, ref _internalCheckOverTransform, _internalOverlapedColliders, layerMask))
		{
			_internalOverlapedColliders.Clear();
			return;
		}
		for (int i = 0; i < _internalOverlapedColliders.Count; i++)
		{
			DeterministicCollider deterministicCollider = _internalOverlapedColliders.get_Item(i);
			DeterministicRaycastHit item = new DeterministicRaycastHit
			{
				collider = deterministicCollider,
				isValid = true,
				distance = TSVector2.Distance(tSVector, deterministicCollider.tsTransform.Position),
				point = deterministicCollider.tsTransform.Position,
				normal = (tSVector - deterministicCollider.tsTransform.Position).normalized
			};
			hitInfos.Add(item);
		}
		_internalOverlapedColliders.Clear();
		hitInfos.Sort(_deterministicRaycastHitComparer);
	}

	public bool SphereCastHit(ref TSVector2 origin, ref TSVector2 direction, out DeterministicRaycastHit hitInfo, FP maxDistance, FP radius, int layerMask = -5)
	{
		hitInfo = new DeterministicRaycastHit
		{
			isValid = false
		};
		FP maxDistance2 = maxDistance + radius;
		TSVector2 direction2 = direction.normalized;
		TSVector2 tSVector = new TSVector2(direction2.y, -direction2.x);
		TSVector2 origin2 = origin + direction2 * radius;
		SphereCastAll(ref origin2, ref direction2, _internalSphereCastHitCandidates, maxDistance - radius, radius, layerMask);
		if (_internalSphereCastHitCandidates.Count <= 0)
		{
			return false;
		}
		hitInfo = _internalSphereCastHitCandidates.get_Item(0);
		_internalSphereCastHitProbeCount = 0;
		for (int i = 0; i < 3; i++)
		{
			TSVector2 origin3 = i switch
			{
				1 => origin + tSVector * radius, 
				0 => origin, 
				_ => origin - tSVector * radius, 
			};
			if (Raycast(ref origin3, ref direction2, out var hitInfo2, maxDistance2, layerMask))
			{
				_internalSphereCastHitProbes[_internalSphereCastHitProbeCount++] = hitInfo2;
				if (hitInfo2.collider == hitInfo.collider)
				{
					onHitCollider(ref origin, ref direction2, maxDistance, radius, ref hitInfo, ref hitInfo2);
					return true;
				}
			}
		}
		for (int j = 0; j < _internalSphereCastHitProbeCount; j++)
		{
			DeterministicRaycastHit otherHitInfo = _internalSphereCastHitProbes[j];
			if (IsSphereCastHitCandidate(otherHitInfo.collider))
			{
				hitInfo.collider = otherHitInfo.collider;
				hitInfo.isValid = true;
				onHitCollider(ref origin, ref direction2, maxDistance, radius, ref hitInfo, ref otherHitInfo);
				return true;
			}
		}
		return false;
	}

	private bool IsSphereCastHitCandidate(DeterministicCollider collider)
	{
		if (collider == null)
		{
			return false;
		}
		for (int i = 0; i < _internalSphereCastHitCandidates.Count; i++)
		{
			if (_internalSphereCastHitCandidates.get_Item(i).collider == collider)
			{
				return true;
			}
		}
		return false;
	}

	private void onHitCollider(ref TSVector2 origin, ref TSVector2 direction, FP maxDistance, FP radius, ref DeterministicRaycastHit hitInfo, ref DeterministicRaycastHit otherHitInfo)
	{
		hitInfo.normal = otherHitInfo.normal;
		hitInfo.distance = computeDistance(hitInfo.collider, ref origin, ref direction, radius, maxDistance);
		hitInfo.point = origin + direction * hitInfo.distance;
	}

	private FP computeDistance(DeterministicCollider dtCollider, ref TSVector2 origin, ref TSVector2 direction, FP radius, FP maxDistance)
	{
		FP fP = 0;
		FP fP2 = maxDistance;
		bool flag = false;
		for (int i = 0; i < 4; i++)
		{
			fP2 *= (FP)0.5;
			fP = (flag ? (fP - fP2) : (fP + fP2));
			flag = CheckCircleOverlapCollider(radius, origin + fP * direction, dtCollider);
			if (fP2 < 0.03)
			{
				break;
			}
		}
		if (flag)
		{
			fP -= fP2;
		}
		return fP;
	}

	public bool RoughRaycast(ref TSVector2 origin, ref TSVector2 direction, FP maxDistance, int layerMask = -5)
	{
		TSVector2 value = origin + direction.normalized * maxDistance;
		TSVector2 min = TSVector2.Min(origin, value);
		TSVector2 max = TSVector2.Max(origin, value);
		AABB checkBounds = new AABB(min, max);
		quadTree.GetColliding(ref checkBounds, _collisionDetectList);
		for (int i = 0; i < _collisionDetectList.Count; i++)
		{
			if (_collisionDetectList.get_Item(i).CollisionLayerFlag == layerMask)
			{
				return true;
			}
		}
		return false;
	}

	public DeterministicCollider CheckPointInterior(ref TSVector2 point, int layerMask = -5)
	{
		quadTree.GetColliding(ref point, _collisionDetectList);
		for (int i = 0; i < _collisionDetectList.Count; i++)
		{
			DeterministicCollider deterministicCollider = _collisionDetectList.get_Item(i);
			if (!DeterministicCollisionUtils.IsColliderFilter(deterministicCollider, layerMask) && deterministicCollider.CheckPointInterior(ref point))
			{
				return deterministicCollider;
			}
		}
		return null;
	}

	public bool CheckLineOverlap(TSVector2 lineStart, TSVector2 lineEnd, List<DeterministicCollider> overlapedColliders = null, int layerMask = -5)
	{
		_internalCheckOverlapEdgeShape.Set(lineStart, lineEnd);
		_internalCheckOverTransform.SetIdentity();
		return CheckOverlap_Internal(_internalCheckOverlapEdgeShape, ref _internalCheckOverTransform, overlapedColliders, layerMask);
	}

	public bool CheckRectangleOverlap(FP width, FP length, TSVector2 pos, FP rot, List<DeterministicCollider> overlapedColliders = null, int layerMask = -5, bool drawGizmos = false)
	{
		DeterministicCollisionUtils.CreateRectangleShape(_internalCheckOverlapPolygonShape, width * 0.5f, length * 0.5f);
		FP angle = rot * FP.Deg2Rad;
		_internalCheckOverTransform.Set(pos, angle);
		return CheckOverlap_Internal(_internalCheckOverlapPolygonShape, ref _internalCheckOverTransform, overlapedColliders, layerMask);
	}

	public bool CheckCircleOverlapCollider(FP radius, TSVector2 pos, DeterministicCollider dtCollider)
	{
		_internalCheckOverlapCircleShape.Radius = radius;
		_internalCheckOverlapCircleShape.Position = pos;
		_internalCheckOverTransform.SetIdentity();
		_internalCheckOverlapCircleShape.ComputeAABB(out var _, ref _internalCheckOverTransform, 0);
		DeterministicCollisionUtils._internalDistanceInput.ProxyA.Set(_internalCheckOverlapCircleShape, 0);
		DeterministicCollisionUtils._internalDistanceInput.TransformA = _internalCheckOverTransform;
		Transform xfB = dtCollider.tsTransform.dtTransform;
		return DeterministicCollisionUtils.TestOverlap(_internalCheckOverlapCircleShape, dtCollider._shape, ref _internalCheckOverTransform, ref xfB, refreshShapeAProxy: false);
	}

	public bool CheckCircleOverlap(FP radius, TSVector2 pos, List<DeterministicCollider> overlapedColliders = null, int layerMask = -5, bool drawGizmos = false)
	{
		_internalCheckOverlapCircleShape.Radius = radius;
		_internalCheckOverlapCircleShape.Position = pos;
		_internalCheckOverTransform.SetIdentity();
		return CheckOverlap_Internal(_internalCheckOverlapCircleShape, ref _internalCheckOverTransform, overlapedColliders, layerMask);
	}

	public bool CheckRingOverlap(FP radius, FP innerRadius, TSVector2 pos, List<DeterministicCollider> overlapedColliders = null, int layerMask = -5, bool drawGizmos = false)
	{
		if (innerRadius > radius)
		{
			FP fP = radius;
			FP fP2 = innerRadius;
			innerRadius = fP;
			radius = fP2;
		}
		if (CheckCircleOverlap(radius, pos, _internalOverlapedColliders2, layerMask))
		{
			_internalCheckOverlapCircleShape.Radius = innerRadius;
			_internalCheckOverlapCircleShape.Position = pos;
			_internalCheckOverTransform.SetIdentity();
			for (int num = _internalOverlapedColliders2.Count - 1; num >= 0; num--)
			{
				DeterministicCollider deterministicCollider = _internalOverlapedColliders2.get_Item(num);
				if (deterministicCollider._shape.ShapeType == ShapeType.Circle)
				{
					CircleShape circleShape = (CircleShape)deterministicCollider._shape;
					CircleShape internalCheckOverlapCircleShape = _internalCheckOverlapCircleShape;
					TSVector2 value = deterministicCollider.tsTransform.TransformLocalPointToWorldSpace(circleShape.Position);
					TSVector2 position = internalCheckOverlapCircleShape.Position;
					FP fP3 = TSVector2.DistanceSquared(value, position);
					FP fP4 = (internalCheckOverlapCircleShape.Radius - circleShape.Radius) * (internalCheckOverlapCircleShape.Radius - circleShape.Radius);
					if (fP3 < fP4)
					{
						_internalOverlapedColliders2.RemoveAt(num);
					}
				}
				else
				{
					_logger.LogWarning("Check ring overlap with unsupport shape");
				}
			}
		}
		if (overlapedColliders != null)
		{
			overlapedColliders.Clear();
			overlapedColliders.AddRange(_internalOverlapedColliders2);
		}
		bool result = _internalOverlapedColliders2.Count > 0;
		_internalOverlapedColliders2.Clear();
		return result;
	}

	public bool CheckFanOverlap(FP angle, FP radius, TSVector2 pos, FP rot, List<DeterministicCollider> overlapedColliders = null, int layerMask = -5, bool drawGizmos = false)
	{
		angle = TSMath.Clamp(angle, 0f, 360f);
		FP fP = rot + 90f - angle * 0.5f;
		if (angle > 180f)
		{
			FP fP2 = angle * 0.5f;
			FP fP3 = fP2 * 0.5f;
			bool flag = CheckFanOverlap(fP2, radius, pos, rot - fP3, overlapedColliders, layerMask);
			if (overlapedColliders != null)
			{
				_internalOverlapedColliders.AddRange(overlapedColliders);
			}
			else if (flag)
			{
				return true;
			}
			bool flag2 = CheckFanOverlap(fP2, radius, pos, rot + fP3, overlapedColliders, layerMask);
			if (overlapedColliders != null)
			{
				for (int i = 0; i < _internalOverlapedColliders.Count; i++)
				{
					DeterministicCollider item = _internalOverlapedColliders.get_Item(i);
					if (!overlapedColliders.Contains(item))
					{
						overlapedColliders.Add(item);
					}
				}
			}
			_internalOverlapedColliders.Clear();
			return flag | flag2;
		}
		DeterministicCollisionUtils.CreateFanShape(_internalCheckOverlapPolygonShape, angle * FP.Deg2Rad, 12, radius);
		FP angle2 = fP * FP.Deg2Rad;
		_internalCheckOverTransform.Set(pos, angle2);
		return CheckOverlap_Internal(_internalCheckOverlapPolygonShape, ref _internalCheckOverTransform, overlapedColliders, layerMask);
	}

	public bool CheckFanRingOverlap(FP angle, FP radius, FP innerRadius, TSVector2 pos, FP rot, List<DeterministicCollider> overlapedColliders = null, int layerMask = -5, bool drawGizmos = false)
	{
		if (innerRadius > radius)
		{
			FP fP = radius;
			FP fP2 = innerRadius;
			innerRadius = fP;
			radius = fP2;
		}
		_ = rot + 90f - angle * 0.5f;
		if (CheckFanOverlap(angle, radius, pos, rot, _internalOverlapedColliders2, layerMask))
		{
			_internalCheckOverlapCircleShape.Radius = innerRadius;
			_internalCheckOverlapCircleShape.Position = pos;
			_internalCheckOverTransform.SetIdentity();
			for (int num = _internalOverlapedColliders2.Count - 1; num >= 0; num--)
			{
				DeterministicCollider deterministicCollider = _internalOverlapedColliders2.get_Item(num);
				if (deterministicCollider._shape.ShapeType == ShapeType.Circle)
				{
					CircleShape circleShape = (CircleShape)deterministicCollider._shape;
					CircleShape internalCheckOverlapCircleShape = _internalCheckOverlapCircleShape;
					TSVector2 value = deterministicCollider.tsTransform.TransformLocalPointToWorldSpace(circleShape.Position);
					TSVector2 position = internalCheckOverlapCircleShape.Position;
					FP fP3 = TSVector2.DistanceSquared(value, position);
					FP fP4 = (internalCheckOverlapCircleShape.Radius - circleShape.Radius) * (internalCheckOverlapCircleShape.Radius - circleShape.Radius);
					if (fP3 < fP4)
					{
						_internalOverlapedColliders2.RemoveAt(num);
					}
				}
				else
				{
					_logger.LogWarning("Check fan ring overlap with unsupport shape");
				}
			}
		}
		if (overlapedColliders != null)
		{
			overlapedColliders.Clear();
			overlapedColliders.AddRange(_internalOverlapedColliders2);
		}
		bool result = _internalOverlapedColliders2.Count > 0;
		_internalOverlapedColliders2.Clear();
		return result;
	}

	protected bool CheckOverlap_Internal(Shape checkShape, ref Transform xf, List<DeterministicCollider> overlapedColliders, int layerMask)
	{
		overlapedColliders?.Clear();
		checkShape.ComputeAABB(out var aabb, ref xf, 0);
		quadTree.GetColliding(ref aabb, _collisionDetectList);
		DeterministicCollisionUtils._internalDistanceInput.ProxyA.Set(checkShape, 0);
		DeterministicCollisionUtils._internalDistanceInput.TransformA = xf;
		for (int i = 0; i < _collisionDetectList.Count; i++)
		{
			DeterministicCollider deterministicCollider = _collisionDetectList.get_Item(i);
			if (DeterministicCollisionUtils.IsColliderFilter(deterministicCollider, layerMask))
			{
				continue;
			}
			Transform xfB = deterministicCollider.tsTransform.dtTransform;
			if (DeterministicCollisionUtils.TestOverlap(checkShape, deterministicCollider._shape, ref xf, ref xfB, refreshShapeAProxy: false))
			{
				if (overlapedColliders == null)
				{
					return true;
				}
				overlapedColliders.Add(deterministicCollider);
			}
		}
		if (overlapedColliders != null)
		{
			return overlapedColliders.Count > 0;
		}
		return false;
	}

	public void GetTargetByShapeForPoint(List<DeterministicCollider> listValues, DeterministicShape _shape, int layName, bool drawGizmos = false)
	{
		listValues.Clear();
		switch (_shape.shapeType)
		{
		case DeterministicShape.ShapeType.Circle:
			if (_shape.innerRadius > 0f)
			{
				CheckRingOverlapForPoint(_shape, listValues, layName, drawGizmos);
			}
			else
			{
				CheckCircleOverlapForPoint(_shape, listValues, layName, drawGizmos);
			}
			break;
		case DeterministicShape.ShapeType.Fan:
			if (_shape.innerRadius > 0f)
			{
				CheckFanRingOverlapForPoint(_shape, listValues, layName, drawGizmos);
			}
			else
			{
				CheckFanOverlapForPoint(_shape, listValues, layName, drawGizmos);
			}
			break;
		case DeterministicShape.ShapeType.Rectangle:
			CheckRectangleOverlapForPoint(_shape, listValues, layName, drawGizmos);
			break;
		}
	}

	public bool CheckRectangleOverlapForPoint(DeterministicShape _shape, List<DeterministicCollider> overlapedColliders = null, int layerMask = -5, bool drawGizmos = false)
	{
		FP width = _shape.width;
		FP length = _shape.length;
		TSVector2 position = _shape.position;
		FP rotation = _shape.rotation;
		DeterministicCollisionUtils.CreateRectangleShape(_internalCheckOverlapPolygonShape, width * 0.5f, length * 0.5f);
		FP angle = rotation * FP.Deg2Rad;
		_internalCheckOverTransform.Set(position, angle);
		return CheckOverlapForPoint_Internal(_internalCheckOverlapPolygonShape, ref _internalCheckOverTransform, _shape, overlapedColliders, layerMask);
	}

	public bool CheckCircleOverlapColliderForPoint(FP radius, TSVector2 pos, DeterministicCollider dtCollider)
	{
		_internalCheckOverlapCircleShape.Radius = radius;
		_internalCheckOverlapCircleShape.Position = pos;
		_internalCheckOverTransform.SetIdentity();
		_internalCheckOverlapCircleShape.ComputeAABB(out var _, ref _internalCheckOverTransform, 0);
		DeterministicCollisionUtils._internalDistanceInput.ProxyA.Set(_internalCheckOverlapCircleShape, 0);
		DeterministicCollisionUtils._internalDistanceInput.TransformA = _internalCheckOverTransform;
		Transform xfB = dtCollider.tsTransform.dtTransform;
		return DeterministicCollisionUtils.TestOverlap(_internalCheckOverlapCircleShape, dtCollider._shape, ref _internalCheckOverTransform, ref xfB, refreshShapeAProxy: false);
	}

	public bool CheckCircleOverlapForPoint(DeterministicShape _shape, List<DeterministicCollider> overlapedColliders = null, int layerMask = -5, bool drawGizmos = false)
	{
		FP radius = _shape.radius;
		TSVector2 position = _shape.position;
		_internalCheckOverlapCircleShape.Radius = radius;
		_internalCheckOverlapCircleShape.Position = position;
		_internalCheckOverTransform.SetIdentity();
		return CheckOverlapForPoint_Internal(_internalCheckOverlapCircleShape, ref _internalCheckOverTransform, _shape, overlapedColliders, layerMask);
	}

	public bool CheckRingOverlapForPoint(DeterministicShape _shape, List<DeterministicCollider> overlapedColliders = null, int layerMask = -5, bool drawGizmos = false)
	{
		if (_shape.innerRadius > _shape.radius)
		{
			ref FP innerRadius = ref _shape.innerRadius;
			ref FP radius = ref _shape.radius;
			FP radius2 = _shape.radius;
			FP innerRadius2 = _shape.innerRadius;
			innerRadius = radius2;
			radius = innerRadius2;
		}
		FP innerRadius3 = _shape.innerRadius;
		TSVector2 position = _shape.position;
		if (CheckCircleOverlapForPoint(_shape, _internalOverlapedColliders2, layerMask))
		{
			_internalCheckOverlapCircleShape.Radius = innerRadius3;
			_internalCheckOverlapCircleShape.Position = position;
			_internalCheckOverTransform.SetIdentity();
			for (int num = _internalOverlapedColliders2.Count - 1; num >= 0; num--)
			{
				DeterministicCollider deterministicCollider = _internalOverlapedColliders2.get_Item(num);
				if (deterministicCollider._shape.ShapeType == ShapeType.Circle)
				{
					CircleShape circleShape = (CircleShape)deterministicCollider._shape;
					CircleShape internalCheckOverlapCircleShape = _internalCheckOverlapCircleShape;
					TSVector2 value = deterministicCollider.tsTransform.TransformLocalPointToWorldSpace(circleShape.Position);
					TSVector2 position2 = internalCheckOverlapCircleShape.Position;
					FP fP = TSVector2.DistanceSquared(value, position2);
					FP fP2 = (internalCheckOverlapCircleShape.Radius - circleShape.Radius) * (internalCheckOverlapCircleShape.Radius - circleShape.Radius);
					if (fP < fP2)
					{
						_internalOverlapedColliders2.RemoveAt(num);
					}
				}
				else
				{
					_logger.LogWarning("Check ring overlap with unsupport shape");
				}
			}
		}
		if (overlapedColliders != null)
		{
			overlapedColliders.Clear();
			overlapedColliders.AddRange(_internalOverlapedColliders2);
		}
		bool result = _internalOverlapedColliders2.Count > 0;
		_internalOverlapedColliders2.Clear();
		return result;
	}

	public bool CheckFanOverlapForPoint(DeterministicShape _shape, List<DeterministicCollider> overlapedColliders = null, int layerMask = -5, bool drawGizmos = false)
	{
		FP angle = _shape.angle;
		FP radius = _shape.radius;
		TSVector2 position = _shape.position;
		FP fP = _shape.rotation + 90f - angle * 0.5f;
		DeterministicCollisionUtils.CreateFanShape(_internalCheckOverlapPolygonShape, angle * FP.Deg2Rad, 12, radius);
		FP angle2 = fP * FP.Deg2Rad;
		_internalCheckOverTransform.Set(position, angle2);
		return CheckOverlapForPoint_Internal(_internalCheckOverlapPolygonShape, ref _internalCheckOverTransform, _shape, overlapedColliders, layerMask);
	}

	public bool CheckFanRingOverlapForPoint(DeterministicShape _shape, List<DeterministicCollider> overlapedColliders = null, int layerMask = -5, bool drawGizmos = false)
	{
		if (_shape.innerRadius > _shape.radius)
		{
			ref FP innerRadius = ref _shape.innerRadius;
			ref FP radius = ref _shape.radius;
			FP radius2 = _shape.radius;
			FP innerRadius2 = _shape.innerRadius;
			innerRadius = radius2;
			radius = innerRadius2;
		}
		FP angle = _shape.angle;
		FP innerRadius3 = _shape.innerRadius;
		TSVector2 position = _shape.position;
		_ = _shape.rotation + 90f - angle * 0.5f;
		if (CheckFanOverlapForPoint(_shape, _internalOverlapedColliders2, layerMask))
		{
			_internalCheckOverlapCircleShape.Radius = innerRadius3;
			_internalCheckOverlapCircleShape.Position = position;
			_internalCheckOverTransform.SetIdentity();
			for (int num = _internalOverlapedColliders2.Count - 1; num >= 0; num--)
			{
				DeterministicCollider deterministicCollider = _internalOverlapedColliders2.get_Item(num);
				if (deterministicCollider._shape.ShapeType == ShapeType.Circle)
				{
					CircleShape circleShape = (CircleShape)deterministicCollider._shape;
					CircleShape internalCheckOverlapCircleShape = _internalCheckOverlapCircleShape;
					TSVector2 value = deterministicCollider.tsTransform.TransformLocalPointToWorldSpace(circleShape.Position);
					TSVector2 position2 = internalCheckOverlapCircleShape.Position;
					FP fP = TSVector2.DistanceSquared(value, position2);
					FP fP2 = (internalCheckOverlapCircleShape.Radius - circleShape.Radius) * (internalCheckOverlapCircleShape.Radius - circleShape.Radius);
					if (fP < fP2)
					{
						_internalOverlapedColliders2.RemoveAt(num);
					}
				}
				else
				{
					_logger.LogWarning("Check fan ring overlap with unsupport shape");
				}
			}
		}
		if (overlapedColliders != null)
		{
			overlapedColliders.Clear();
			overlapedColliders.AddRange(_internalOverlapedColliders2);
		}
		bool result = _internalOverlapedColliders2.Count > 0;
		_internalOverlapedColliders2.Clear();
		return result;
	}

	protected bool CheckOverlapForPoint_Internal(Shape checkShape, ref Transform xf, DeterministicShape _shape, List<DeterministicCollider> overlapedColliders, int layerMask)
	{
		overlapedColliders?.Clear();
		checkShape.ComputeAABB(out var aabb, ref xf, 0);
		quadTree.GetColliding(ref aabb, _collisionDetectList);
		for (int i = 0; i < _collisionDetectList.Count; i++)
		{
			DeterministicCollider deterministicCollider = _collisionDetectList.get_Item(i);
			if (DeterministicCollisionUtils.IsColliderFilter(deterministicCollider, layerMask))
			{
				continue;
			}
			bool flag = false;
			switch (_shape.shapeType)
			{
			case DeterministicShape.ShapeType.Circle:
				flag = DeterministicCollisionUtils.TestSimpleOverLap_Circle2Circle(_shape.position, _shape.radius, _shape.innerRadius, deterministicCollider.tsTransform.Position, 0);
				break;
			case DeterministicShape.ShapeType.Fan:
				flag = DeterministicCollisionUtils.TestSimpleOverLap_Fan2Circle(_shape.position, _shape.rotation, _shape.angle, _shape.radius, _shape.innerRadius, deterministicCollider.tsTransform.Position, 0);
				break;
			case DeterministicShape.ShapeType.Rectangle:
				flag = DeterministicCollisionUtils.TestSimpleOverLap_Rect2Circle(_shape.position, _shape.rotation, _shape.width, _shape.length, deterministicCollider.tsTransform.Position, 0);
				break;
			}
			if (flag)
			{
				if (overlapedColliders == null)
				{
					return true;
				}
				overlapedColliders.Add(deterministicCollider);
			}
		}
		if (overlapedColliders != null)
		{
			return overlapedColliders.Count > 0;
		}
		return false;
	}

	internal void CollisionDetectionPreSolve()
	{
		for (int i = 0; i < colliders.Count; i++)
		{
			DeterministicCollider deterministicCollider = colliders.get_Item(i);
			if (deterministicCollider != null)
			{
				deterministicCollider.ColliderSync();
			}
		}
	}

	public void ContactEvaluate(int frameCount, DeterministicCollider colliderA, DeterministicCollider colliderB, bool duplex)
	{
		if (colliderA.IgnoreCollision || colliderB.IgnoreCollision)
		{
			colliderA.SeparateWith(frameCount, colliderB);
			if (duplex)
			{
				colliderB.SeparateWith(frameCount, colliderA);
			}
		}
		else if (colliderA.CheckOverlap(colliderB, preTest: true))
		{
			colliderA.ContactWith(frameCount, colliderB);
			if (duplex)
			{
				colliderB.ContactWith(frameCount, colliderA);
			}
		}
		else
		{
			colliderA.SeparateWith(frameCount, colliderB);
			if (duplex)
			{
				colliderB.SeparateWith(frameCount, colliderA);
			}
		}
	}

	public void GetTargetByShape(List<DeterministicCollider> listValues, DeterministicShape _shape, int layName, bool drawGizmos = false)
	{
		listValues.Clear();
		switch (_shape.shapeType)
		{
		case DeterministicShape.ShapeType.Circle:
			CheckCircleArea(listValues, _shape, layName, drawGizmos);
			break;
		case DeterministicShape.ShapeType.Fan:
			CheckFanArea(listValues, _shape, layName, drawGizmos);
			break;
		case DeterministicShape.ShapeType.Rectangle:
			CheckRectangleArea(listValues, _shape, layName, drawGizmos);
			break;
		}
	}

	protected void CheckCircleArea(List<DeterministicCollider> listValues, DeterministicShape _shape, int layMask, bool drawGizmos = false)
	{
		FP radius = _shape.radius;
		FP innerRadius = _shape.innerRadius;
		TSVector2 position = _shape.position;
		if (innerRadius > 0f)
		{
			CheckRingOverlap(radius, innerRadius, position, listValues, layMask, drawGizmos);
		}
		else
		{
			CheckCircleOverlap(radius, position, listValues, layMask, drawGizmos);
		}
	}

	protected void CheckFanArea(List<DeterministicCollider> listValues, DeterministicShape _shape, int layMask, bool drawGizmos = false)
	{
		FP angle = _shape.angle;
		FP radius = _shape.radius;
		FP innerRadius = _shape.innerRadius;
		TSVector2 position = _shape.position;
		FP rotation = _shape.rotation;
		if (innerRadius > 0f)
		{
			CheckFanRingOverlap(angle, radius, innerRadius, position, rotation, listValues, layMask, drawGizmos);
		}
		else
		{
			CheckFanOverlap(angle, radius, position, rotation, listValues, layMask, drawGizmos);
		}
	}

	protected void CheckRectangleArea(List<DeterministicCollider> listValues, DeterministicShape _shape, int layMask, bool drawGizmos = false)
	{
		FP width = _shape.width;
		FP length = _shape.length;
		TSVector2 position = _shape.position;
		FP rotation = _shape.rotation;
		CheckRectangleOverlap(width, length, position, rotation, listValues, layMask, drawGizmos);
	}
}
