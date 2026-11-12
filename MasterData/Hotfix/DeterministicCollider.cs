using System.Collections.Generic;
using TrueSync;
using TrueSync.Physics2D;
using UnityEngine;

public class DeterministicCollider : LogicMonoComponent
{
	public int priority = -1;

	private Collider _collider;

	private Vector3 _originUnityColliderCenter;

	private Vector3 _originUnityColliderSize;

	private TrueSyncTransform _tsTransform;

	internal Shape _shape;

	private bool _dirty;

	internal DeterministicColliderShape _colliderShape;

	internal TSVector2 _colliderCenter;

	internal FP _radius;

	internal FP _colliderWidth;

	internal FP _colliderLength;

	internal FP _colliderHeight;

	internal IDeterministicCollisionListener _listener;

	internal bool _ignoreCollision;

	internal AABB _colliderBounds;

	internal DeterministicCollisionQuadTreeNode _quadTreeNode;

	protected List<DeterministicCollider> _collisionInfo;

	protected List<int> _collisionInfoMeta;

	public TrueSyncTransform tsTransform => _tsTransform;

	public int layer
	{
		get
		{
			return gameObject.layer;
		}
		set
		{
			gameObject.layer = value;
		}
	}

	public FP HeightCenter => _tsTransform.PositionY + _colliderHeight * 0.5f;

	public DeterministicColliderShape ColliderShape
	{
		get
		{
			return _colliderShape;
		}
		set
		{
			_colliderShape = value;
			_dirty = true;
		}
	}

	public TSVector2 ColliderCenter
	{
		get
		{
			return _colliderCenter;
		}
		set
		{
			_colliderCenter = value;
			_dirty = true;
		}
	}

	public TSVector2 CenterPosition => _tsTransform.TransformLocalPointToWorldSpace(_colliderCenter);

	public FP Radius
	{
		get
		{
			return _radius;
		}
		set
		{
			_radius = value;
			_dirty = true;
		}
	}

	public FP ColliderWidth
	{
		get
		{
			return _colliderWidth;
		}
		set
		{
			_colliderWidth = value;
			_dirty = true;
		}
	}

	public FP ColliderLength
	{
		get
		{
			return _colliderLength;
		}
		set
		{
			_colliderLength = value;
			_dirty = true;
		}
	}

	public FP ColliderHeight
	{
		get
		{
			return _colliderHeight;
		}
		set
		{
			_colliderHeight = value;
		}
	}

	public IDeterministicCollisionListener collisionListener
	{
		get
		{
			return _listener;
		}
		set
		{
			_listener = value;
		}
	}

	public int CollisionLayerFlag => 1 << gameObject.layer;

	public bool IgnoreCollision
	{
		get
		{
			if (!ActiveSelf || _colliderShape == DeterministicColliderShape.None)
			{
				return true;
			}
			return _ignoreCollision;
		}
		set
		{
			_ignoreCollision = value;
			if (_ignoreCollision)
			{
				DisableCollision();
			}
		}
	}

	public Vector3 colliderCenter
	{
		get
		{
			if (_collider != null)
			{
				return _collider.bounds.center;
			}
			TSVector2 centerPosition = CenterPosition;
			return new Vector3((float)centerPosition.x, (float)_tsTransform.PositionY, (float)centerPosition.y);
		}
	}

	public AABB ColliderBounds
	{
		get
		{
			UpdateColliderTransform();
			return _colliderBounds;
		}
	}

	public Vector3 colliderSize
	{
		get
		{
			if (_collider != null)
			{
				return _collider.bounds.size;
			}
			AABB aABB = ColliderBounds;
			return new Vector3((float)aABB.Width, (float)ColliderHeight, (float)aABB.Height);
		}
	}

	public Bounds colliderBounds
	{
		get
		{
			if (_collider != null)
			{
				return _collider.bounds;
			}
			Vector3 center = colliderCenter;
			Vector3 size = colliderSize;
			return new Bounds(center, size);
		}
	}

	public void LoadFromUnityCollider(Collider unityCollider, bool applyTransformScale = false)
	{
		if (unityCollider == null)
		{
			_colliderShape = DeterministicColliderShape.None;
			_colliderHeight = 0f;
		}
		else if (!(unityCollider is SphereCollider sphereCollider))
		{
			if (!(unityCollider is CapsuleCollider capsuleCollider))
			{
				if (unityCollider is BoxCollider boxCollider)
				{
					_colliderShape = DeterministicColliderShape.Rect;
					Vector3 center = boxCollider.center;
					_colliderCenter = new TSVector2(center.x, center.z);
					Vector3 size = boxCollider.size;
					_colliderWidth = size.x;
					_colliderLength = size.z;
					_colliderHeight = Mathf.Max(0f, boxCollider.center.y + boxCollider.size.y * 0.5f);
				}
				else
				{
					Debug.LogError("[" + unityCollider.gameObject.name + "] 碰撞体类型不支持");
					_colliderShape = DeterministicColliderShape.None;
					_colliderHeight = 0f;
				}
			}
			else
			{
				_colliderShape = DeterministicColliderShape.Circle;
				Vector3 center2 = capsuleCollider.center;
				_colliderCenter = new TSVector2(center2.x, center2.z);
				_radius = capsuleCollider.radius;
				_colliderHeight = Mathf.Max(0f, center2.y + capsuleCollider.height * 0.5f);
			}
		}
		else
		{
			_colliderShape = DeterministicColliderShape.Circle;
			Vector3 center3 = sphereCollider.center;
			_colliderCenter = new TSVector2(center3.x, center3.z);
			_radius = sphereCollider.radius;
			_colliderHeight = Mathf.Max(0f, sphereCollider.center.y + sphereCollider.radius);
		}
		if (applyTransformScale)
		{
			Vector3 lossyScale = gameObject.transform.lossyScale;
			_radius *= (FP)lossyScale.x;
			_colliderWidth *= (FP)lossyScale.x;
			_colliderLength *= (FP)lossyScale.z;
			_colliderHeight *= (FP)lossyScale.y;
		}
		_dirty = true;
		UpdateColliderShape();
		_collider = unityCollider;
	}

	public void ScaleUnityColliderShape(float scale, bool applyScaleToDeterministicCollider, bool applyTransformScale = false)
	{
		if (_collider == null)
		{
			return;
		}
		Collider collider = _collider;
		if (!(collider is SphereCollider sphereCollider))
		{
			if (!(collider is CapsuleCollider capsuleCollider))
			{
				if (collider is BoxCollider boxCollider)
				{
					boxCollider.center = _originUnityColliderCenter.normalized * (_originUnityColliderCenter.magnitude * scale);
					boxCollider.size = _originUnityColliderSize * scale;
				}
				else
				{
					Debug.LogError("[" + gameObject.name + "] 不支持缩放碰撞体" + _collider.GetType().Name + "的大小");
				}
			}
			else
			{
				capsuleCollider.center = _originUnityColliderCenter.normalized * (_originUnityColliderCenter.magnitude * scale);
				capsuleCollider.radius = _originUnityColliderSize.x * scale;
				capsuleCollider.height = _originUnityColliderSize.y * scale;
			}
		}
		else
		{
			sphereCollider.center = _originUnityColliderCenter.normalized * (_originUnityColliderCenter.magnitude * scale);
			sphereCollider.radius = _originUnityColliderSize.x * scale;
		}
		if (applyScaleToDeterministicCollider)
		{
			LoadFromUnityCollider(_collider, applyTransformScale);
		}
	}

	public void UpdateColliderShape()
	{
		if (_dirty)
		{
			_dirty = false;
			switch (ColliderShape)
			{
			case DeterministicColliderShape.Circle:
			{
				CircleShape shape = new CircleShape(_radius, 0f)
				{
					Position = _colliderCenter
				};
				_shape = shape;
				_colliderWidth = (_colliderLength = _radius * 2f);
				break;
			}
			case DeterministicColliderShape.Rect:
			{
				Vertices vertices = PolygonTools.CreateRectangle(_colliderWidth / 2f, _colliderLength / 2f, _colliderCenter, 0f);
				_shape = new PolygonShape(vertices, 0f);
				_radius = TSMath.Max(_colliderWidth, _colliderLength) * 0.5f;
				break;
			}
			case DeterministicColliderShape.None:
				_shape = null;
				_colliderWidth = (_colliderLength = (_radius = 0f));
				break;
			}
		}
	}

	public void UpdateColliderTransform(bool forceUp = false)
	{
		if (_tsTransform.Dirty || forceUp)
		{
			TrueSync.Physics2D.Transform dtTransform = _tsTransform.dtTransform;
			_shape?.ComputeAABB(out _colliderBounds, ref dtTransform, 0);
			_quadTreeNode?.Update(this);
			_tsTransform.Dirty = false;
		}
	}

	public void ColliderSync()
	{
		UpdateColliderShape();
		UpdateColliderTransform();
	}

	public bool RaycastBounds(ref TSVector2 origin, ref TSVector2 direction, out DeterministicRaycastHit hitInfo, FP maxDistance)
	{
		hitInfo = new DeterministicRaycastHit
		{
			isValid = false
		};
		TSVector2 point = origin + direction * maxDistance;
		RayCastInput input = new RayCastInput
		{
			Point1 = origin,
			Point2 = point,
			MaxFraction = 1f
		};
		bool flag = ColliderBounds.RayCast(out var output, ref input, doInteriorCheck: false);
		if (flag)
		{
			hitInfo.isValid = true;
			hitInfo.point = origin + direction * maxDistance * output.Fraction;
			hitInfo.normal = output.Normal;
			hitInfo.collider = this;
			hitInfo.distance = maxDistance * output.Fraction;
		}
		return flag;
	}

	public bool Raycast(ref TSVector2 origin, ref TSVector2 direction, out DeterministicRaycastHit hitInfo, FP maxDistance, bool preTest = false)
	{
		hitInfo = new DeterministicRaycastHit
		{
			isValid = false
		};
		TSVector2 point = origin + direction * maxDistance;
		RayCastInput input = new RayCastInput
		{
			Point1 = origin,
			Point2 = point,
			MaxFraction = 1f
		};
		if (preTest && !ColliderBounds.RayCast(out var _, ref input, doInteriorCheck: false))
		{
			return false;
		}
		TrueSync.Physics2D.Transform dtTransform = _tsTransform.dtTransform;
		bool flag = _shape.RayCast(out var output2, ref input, ref dtTransform, 0);
		if (flag)
		{
			hitInfo.isValid = true;
			hitInfo.point = origin + direction * maxDistance * output2.Fraction;
			hitInfo.normal = output2.Normal;
			hitInfo.collider = this;
			hitInfo.distance = maxDistance * output2.Fraction;
		}
		return flag;
	}

	public bool CheckPointInterior(ref TSVector2 point)
	{
		TrueSync.Physics2D.Transform dtTransform = _tsTransform.dtTransform;
		return _shape.TestPoint(ref dtTransform, ref point);
	}

	public bool CheckBoundsOverlap(ref AABB other)
	{
		AABB a = ColliderBounds;
		return AABB.TestOverlap(ref a, ref other);
	}

	public bool CheckOverlap(DeterministicCollider other, bool preTest = false)
	{
		if (preTest)
		{
			AABB other2 = other.ColliderBounds;
			if (!CheckBoundsOverlap(ref other2))
			{
				return false;
			}
		}
		TrueSync.Physics2D.Transform xfB = other.Entity.GetLogicComponent<TrueSyncTransform>().dtTransform;
		TrueSync.Physics2D.Transform xfA = _tsTransform.dtTransform;
		return DeterministicCollisionUtils.TestOverlap(_shape, other._shape, ref xfA, ref xfB);
	}

	internal void ContactWith(int frameCount, DeterministicCollider other)
	{
		if (_collisionInfo == null)
		{
			_collisionInfo = new List<DeterministicCollider>(16);
			_collisionInfoMeta = new List<int>(16);
		}
		int num = _collisionInfo.IndexOf(other);
		if (num == -1)
		{
			_collisionInfo.Add(other);
			_collisionInfoMeta.Add(frameCount);
			collisionListener?.OnDeterministicCollisionEnter(other);
		}
		else if (_collisionInfoMeta.get_Item(num) != frameCount)
		{
			_collisionInfoMeta.set_Item(num, frameCount);
			collisionListener?.OnDeterministicCollisionStay(other);
		}
	}

	internal void SeparateWith(int frameCount, DeterministicCollider other)
	{
		if (_collisionInfo == null)
		{
			_collisionInfo = new List<DeterministicCollider>(16);
			_collisionInfoMeta = new List<int>(16);
		}
		int num = _collisionInfo.IndexOf(other);
		if (num != -1 && _collisionInfoMeta.get_Item(num) != frameCount)
		{
			_collisionInfo.RemoveAt(num);
			_collisionInfoMeta.RemoveAt(num);
			collisionListener?.OnDeterministicCollisionExit(other);
		}
	}

	internal void SeparateWithRemaining(int frameCount)
	{
		List<DeterministicCollider> collisionInfo = _collisionInfo;
		if (collisionInfo == null || collisionInfo.Count <= 0)
		{
			return;
		}
		for (int num = _collisionInfo.Count - 1; num >= 0; num--)
		{
			if (_collisionInfoMeta.get_Item(num) != frameCount)
			{
				DeterministicCollider deterministicCollider = _collisionInfo.get_Item(num);
				SeparateWith(frameCount, deterministicCollider);
				deterministicCollider.SeparateWith(frameCount, this);
			}
		}
	}

	protected void DisableCollision()
	{
		List<DeterministicCollider> collisionInfo = _collisionInfo;
		if (collisionInfo != null && collisionInfo.Count > 0)
		{
			for (int num = _collisionInfo.Count - 1; num >= 0; num--)
			{
				DeterministicCollider deterministicCollider = _collisionInfo.get_Item(num);
				SeparateWith(-1, deterministicCollider);
				deterministicCollider.SeparateWith(-1, this);
			}
			_collisionInfo.Clear();
			_collisionInfoMeta.Clear();
		}
	}

	protected override void OnInit()
	{
		_tsTransform = Entity.GetLogicComponent<TrueSyncTransform>();
		_tsTransform.ActiveSelf = SceneSingleton<DeterministicCollisionManager>.Instance.isSetTsEnable;
		Collider component = gameObject.GetComponent<Collider>();
		if (component != null)
		{
			if (!(component is SphereCollider sphereCollider))
			{
				if (!(component is CapsuleCollider capsuleCollider))
				{
					if (component is BoxCollider boxCollider)
					{
						_originUnityColliderCenter = boxCollider.center;
						_originUnityColliderSize = boxCollider.size;
					}
				}
				else
				{
					_originUnityColliderCenter = capsuleCollider.center;
					_originUnityColliderSize.x = capsuleCollider.radius;
					_originUnityColliderSize.y = capsuleCollider.height;
				}
			}
			else
			{
				_originUnityColliderCenter = sphereCollider.center;
				_originUnityColliderSize.x = sphereCollider.radius;
			}
		}
		LoadFromUnityCollider(component, applyTransformScale: true);
	}

	public override void OnActive()
	{
		_tsTransform.Dirty = true;
		if (_collider != null)
		{
			SceneSingleton<DeterministicCollisionManager>.Instance.RegisterCollider(this);
		}
		if (!_tsTransform.ActiveSelf)
		{
			_tsTransform.ActiveSelf = SceneSingleton<DeterministicCollisionManager>.Instance.isSetTsEnable;
		}
	}

	public override void OnDeactive()
	{
		if (_collider != null)
		{
			SceneSingleton<DeterministicCollisionManager>.Instance?.UnRegisterCollider(this);
		}
		DisableCollision();
	}
}
