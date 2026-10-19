using System.Collections.Generic;
using ACT.Battle;
using Bamboo.ECS;
using Bamboo.Precache;
using UnityEngine;

[RequireComponent(typeof(BoxCollider))]
public class UpdraftRegion : MonoBehaviour, IBattleRuntimeAttachment
{
	private readonly HashSet<MonoEntity> _affected = new HashSet<MonoEntity>();

	private static readonly List<MonoEntity> _exitBuffer = new List<MonoEntity>();

	private InstanceHandle _regionVfxHandle;

	private InstanceHandle _topVfxHandle;

	private Vector3 _forceDir = Vector3.up;

	private float _force = 600f;

	private bool _useDynamicRegion;

	private Vector2 _vfxBaseSize = new Vector2(2f, 10f);

	private BoxCollider _box;

	private LayerMask _envMask = BattleConsts.enviromentMask;

	private bool _useLocalSpaceForce;

	public Transform dynamicRegionVfx;

	public Transform dynamicTopVfx;

	private Vector3 _vfxInitialScale = Vector3.one;

	private bool _hasVfxInitialScale;

	private Vector3 _topVfxInitialLocalPosition = Vector3.zero;

	private bool _hasTopVfxInitialLocalPosition;

	private Vector3 _topVfxInitialScale = Vector3.one;

	private bool _hasTopVfxInitialScale;

	private static readonly RaycastHit[] _rayHitBuffer = new RaycastHit[16];

	private const int RefreshInterval = 3;

	private int _refreshCounter;

	public bool IsReleased { get; private set; }

	private void Awake()
	{
		if (_box == null)
		{
			_box = GetComponent<BoxCollider>();
		}
		_box.isTrigger = true;
	}

	public void Init(Vector3 forceDir, float force, Vector3 boxCenter, Vector3 boxSize, bool useDynamicRegion, Vector2 vfxBaseSize, bool useLocalSpaceForce = false)
	{
		if (_box == null)
		{
			_box = GetComponent<BoxCollider>();
		}
		IsReleased = false;
		_forceDir = ((forceDir.sqrMagnitude > 1E-05f) ? forceDir.normalized : Vector3.up);
		_force = force;
		_useDynamicRegion = useDynamicRegion;
		_vfxBaseSize = vfxBaseSize;
		_useLocalSpaceForce = useLocalSpaceForce;
		_box.isTrigger = true;
		_box.center = boxCenter;
		_box.size = boxSize;
		CacheVfxInitialScale();
		CacheTopVfxInitialLocalPosition();
		CacheTopVfxInitialScale();
		RefreshDynamicRegionVfxScale();
	}

	public void SetEnabled(bool enabled)
	{
		if (_box != null)
		{
			_box.enabled = enabled;
		}
		if (dynamicRegionVfx != null)
		{
			dynamicRegionVfx.gameObject.SetActive(enabled);
		}
		if (dynamicTopVfx != null && !enabled)
		{
			dynamicTopVfx.gameObject.SetActive(value: false);
		}
		if (!enabled)
		{
			FlushAffected();
		}
	}

	public void OnVfxAttached()
	{
		if (!IsReleased)
		{
			_hasVfxInitialScale = false;
			_hasTopVfxInitialLocalPosition = false;
			_hasTopVfxInitialScale = false;
			CacheVfxInitialScale();
			CacheTopVfxInitialLocalPosition();
			CacheTopVfxInitialScale();
			RefreshDynamicRegionVfxScale();
		}
	}

	private void FixedUpdate()
	{
		if (!IsReleased && ++_refreshCounter >= 3)
		{
			_refreshCounter = 0;
			RefreshDynamicRegionVfxScale();
		}
	}

	private void OnTriggerStay(Collider other)
	{
		if (IsReleased)
		{
			return;
		}
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!(component == null) && component.entity.IsCharacter())
		{
			CompPhysics compPhysics = component.entity.GetCompPhysics();
			if (compPhysics != null && IsInsideDynamicRegion(component.transform.position))
			{
				Vector3 dir = (_useLocalSpaceForce ? transform.TransformDirection(_forceDir) : _forceDir);
				compPhysics.EnterUpdraft();
				compPhysics.Updraft(dir, _force);
				_affected.Add(component);
			}
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!(component == null) && component.entity.IsCharacter())
		{
			component.entity.GetCompPhysics()?.ExitUpdraft();
			_affected.Remove(component);
		}
	}

	private void OnDisable()
	{
		FlushAffected();
	}

	private void OnDestroy()
	{
		Release();
	}

	public void AttachVfxHandles(InstanceHandle regionHandle, InstanceHandle topHandle)
	{
		_regionVfxHandle = regionHandle;
		_topVfxHandle = topHandle;
	}

	public void ReleaseRuntimeAttachment()
	{
		Release();
	}

	public void Release()
	{
		if (!IsReleased)
		{
			IsReleased = true;
			SetEnabled(enabled: false);
			ReleaseVfxHandles();
		}
	}

	private void ReleaseVfxHandles()
	{
		if (_regionVfxHandle != null)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(_regionVfxHandle);
			_regionVfxHandle = null;
		}
		if (_topVfxHandle != null)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(_topVfxHandle);
			_topVfxHandle = null;
		}
		dynamicRegionVfx = null;
		dynamicTopVfx = null;
	}

	private void FlushAffected()
	{
		if (_affected.Count == 0)
		{
			return;
		}
		_exitBuffer.Clear();
		foreach (MonoEntity item in _affected)
		{
			if (item != null)
			{
				_exitBuffer.Add(item);
			}
		}
		_affected.Clear();
		for (int i = 0; i < _exitBuffer.Count; i++)
		{
			MonoEntity monoEntity = _exitBuffer[i];
			if (!(monoEntity == null) && !(monoEntity.entity == null))
			{
				monoEntity.entity.GetCompPhysics()?.ExitUpdraft();
			}
		}
		_exitBuffer.Clear();
	}

	private bool IsInsideDynamicRegion(Vector3 worldPos)
	{
		if (_box == null)
		{
			return false;
		}
		Vector3 vector = transform.InverseTransformPoint(worldPos);
		Vector3 center = _box.center;
		Vector3 half = _box.size * 0.5f;
		float num = center.y - half.y;
		float dynamicTopLocalY = GetDynamicTopLocalY(num, center, half, out var _);
		float y = vector.y;
		if (y >= num - 0.0001f)
		{
			return y <= dynamicTopLocalY + 0.0001f;
		}
		return false;
	}

	private float GetDynamicTopLocalY(float bottomY, Vector3 center, Vector3 half, out bool hasTopCollision)
	{
		float num = center.y + half.y;
		float num2 = bottomY + 0.01f;
		float num3 = Mathf.Max(0f, num - num2);
		Vector3 position = new Vector3(center.x, num2, center.z);
		Vector3 origin = transform.TransformPoint(position);
		float num4 = num;
		hasTopCollision = false;
		if (!_useDynamicRegion)
		{
			return num4;
		}
		if (_envMask.value != 0 && num3 > 0f)
		{
			int num5 = Physics.RaycastNonAlloc(origin, transform.up, _rayHitBuffer, num3, _envMask, QueryTriggerInteraction.Ignore);
			for (int i = 0; i < num5; i++)
			{
				if (!_rayHitBuffer[i].collider.CompareTag("UpdraftIgnore") && (!hasTopCollision || bottomY + _rayHitBuffer[i].distance < num4))
				{
					num4 = bottomY + _rayHitBuffer[i].distance;
					hasTopCollision = true;
				}
			}
		}
		return num4;
	}

	private void CacheVfxInitialScale()
	{
		if (!(dynamicRegionVfx == null) && !_hasVfxInitialScale)
		{
			_vfxInitialScale = dynamicRegionVfx.localScale;
			_hasVfxInitialScale = true;
		}
	}

	private void CacheTopVfxInitialLocalPosition()
	{
		if (!(dynamicTopVfx == null) && !_hasTopVfxInitialLocalPosition)
		{
			_topVfxInitialLocalPosition = dynamicTopVfx.localPosition;
			_hasTopVfxInitialLocalPosition = true;
		}
	}

	private void CacheTopVfxInitialScale()
	{
		if (!(dynamicTopVfx == null) && !_hasTopVfxInitialScale)
		{
			_topVfxInitialScale = dynamicTopVfx.localScale;
			_hasTopVfxInitialScale = true;
		}
	}

	public void RefreshDynamicRegionVfxScale()
	{
		if (_box == null)
		{
			return;
		}
		Vector3 center = _box.center;
		Vector3 half = _box.size * 0.5f;
		float num = center.y - half.y;
		float dynamicTopLocalY = GetDynamicTopLocalY(num, center, half, out var hasTopCollision);
		float num2 = Mathf.Max(0f, dynamicTopLocalY - num);
		if (dynamicRegionVfx != null)
		{
			CacheVfxInitialScale();
			float num3 = Mathf.Max(0.0001f, _vfxBaseSize.x);
			float num4 = Mathf.Max(0.0001f, _vfxBaseSize.y);
			Vector3 localScale = dynamicRegionVfx.localScale;
			localScale.x = _vfxInitialScale.x * (_box.size.x / num3);
			localScale.y = _vfxInitialScale.y * (num2 / num4);
			dynamicRegionVfx.localScale = localScale;
		}
		if (dynamicTopVfx != null)
		{
			bool flag = hasTopCollision;
			if (dynamicTopVfx.gameObject.activeSelf != flag)
			{
				dynamicTopVfx.gameObject.SetActive(flag);
			}
			if (flag)
			{
				CacheTopVfxInitialLocalPosition();
				CacheTopVfxInitialScale();
				Vector3 topVfxInitialLocalPosition = _topVfxInitialLocalPosition;
				topVfxInitialLocalPosition.y = dynamicTopLocalY;
				dynamicTopVfx.localPosition = topVfxInitialLocalPosition;
				float num5 = Mathf.Max(0.0001f, _vfxBaseSize.x);
				Vector3 localScale2 = dynamicTopVfx.localScale;
				localScale2.x = _topVfxInitialScale.x * (_box.size.x / num5);
				dynamicTopVfx.localScale = localScale2;
			}
		}
	}

	public bool HasEntityInRegion()
	{
		if (_affected != null)
		{
			return _affected.Count > 0;
		}
		return false;
	}
}
