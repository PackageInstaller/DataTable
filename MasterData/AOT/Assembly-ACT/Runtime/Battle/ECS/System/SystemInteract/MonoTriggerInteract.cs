using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using ACT.World;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Pool;

namespace Runtime.Battle.ECS.System.SystemInteract;

public class MonoTriggerInteract : MonoTriggerEvent, ITrigger
{
	private static readonly Collider[] InitialOverlapResults = new Collider[16];

	private HashSet<Collider> _currentColliders;

	private Collider _mainEntityCollider;

	private Collider _pendingTriggerEnterCollider;

	private bool _pendingTriggerEnterWaitMainEntity;

	public Collider Trigger { get; set; }

	public UnityAction<Collider> OnTriggerEnterCallback { get; set; }

	public UnityAction<Collider> OnTriggerExitCallback { get; set; }

	public UnityAction<Collider> OnTriggerStayCallback { get; set; }

	private void Awake()
	{
		_currentColliders = CollectionPool<HashSet<Collider>, Collider>.Get();
		Trigger = GetComponentInChildren<Collider>();
	}

	private void OnDestroy()
	{
		CancelPendingTriggerEnter();
		UnityAction<Collider> onTriggerEnterCallback = (OnTriggerExitCallback = null);
		OnTriggerEnterCallback = onTriggerEnterCallback;
		if ((bool)Trigger)
		{
			Object.Destroy(Trigger);
		}
		CollectionPool<HashSet<Collider>, Collider>.Release(_currentColliders);
		_currentColliders = null;
		_mainEntityCollider = null;
	}

	private void OnEnable()
	{
		ValidateColliders();
	}

	private void OnDisable()
	{
		CancelPendingTriggerEnter();
		ValidateColliders();
		foreach (Collider currentCollider in _currentColliders)
		{
			OnTriggerExitCallback?.Invoke(currentCollider);
		}
		_currentColliders.Clear();
	}

	private void OnTriggerEnter(Collider other)
	{
		InvokeTriggerEnter(other, ignoreKnownCollider: false);
	}

	private void InvokeTriggerEnter(Collider other, bool ignoreKnownCollider)
	{
		if ((bool)other && (!ignoreKnownCollider || !_currentColliders.Contains(other)))
		{
			if (ShouldWaitMainEntity(other))
			{
				RegisterPendingTriggerEnter(other);
			}
			else
			{
				CompleteTriggerEnter(other);
			}
		}
	}

	private void CompleteTriggerEnter(Collider other)
	{
		_currentColliders.Add(other);
		OnTriggerEnterCallback?.Invoke(other);
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!component)
		{
			return;
		}
		Entity entity = component.entity;
		if (entity != null)
		{
			OnEnterEvt(entity, this);
			if (entity == MonoECS.instance.mainEntity)
			{
				_mainEntityCollider = other;
			}
		}
	}

	private bool ShouldWaitMainEntity(Collider other)
	{
		if (MonoECS.instance != null && MonoECS.instance.mainEntity.IsValid)
		{
			return false;
		}
		MonoEntity component = other.GetComponent<MonoEntity>();
		if ((object)component != null)
		{
			Entity entity = component.entity;
			if (entity.IsValid)
			{
				return entity.IsCharacter();
			}
		}
		return false;
	}

	private void RegisterPendingTriggerEnter(Collider other)
	{
		CancelPendingTriggerEnter();
		_pendingTriggerEnterCollider = other;
		_pendingTriggerEnterWaitMainEntity = true;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RuntimeBattleTeam_MainCharacterChanged, OnPendingTriggerEnterMainEntityChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, OnPendingTriggerEnterMainEntityChanged);
		TryCompletePendingTriggerEnter();
	}

	private void CancelPendingTriggerEnter()
	{
		if (_pendingTriggerEnterWaitMainEntity)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RuntimeBattleTeam_MainCharacterChanged, OnPendingTriggerEnterMainEntityChanged);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, OnPendingTriggerEnterMainEntityChanged);
		}
		_pendingTriggerEnterCollider = null;
		_pendingTriggerEnterWaitMainEntity = false;
	}

	private void OnPendingTriggerEnterMainEntityChanged(BaseEventContent obj)
	{
		if (!(MonoECS.instance == null) && MonoECS.instance.mainEntity.IsValid)
		{
			TryCompletePendingTriggerEnter();
		}
	}

	private void TryCompletePendingTriggerEnter()
	{
		if (!_pendingTriggerEnterCollider || MonoECS.instance == null || !MonoECS.instance.mainEntity.IsValid)
		{
			return;
		}
		MonoEntity component = _pendingTriggerEnterCollider.GetComponent<MonoEntity>();
		if ((object)component != null)
		{
			Entity entity = component.entity;
			if (entity.IsValid && !(entity != MonoECS.instance.mainEntity))
			{
				Collider pendingTriggerEnterCollider = _pendingTriggerEnterCollider;
				CancelPendingTriggerEnter();
				CompleteTriggerEnter(pendingTriggerEnterCollider);
			}
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (other == _pendingTriggerEnterCollider)
		{
			CancelPendingTriggerEnter();
			return;
		}
		_currentColliders.Remove(other);
		OnTriggerExitCallback?.Invoke(other);
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!component)
		{
			return;
		}
		Entity entity = component.entity;
		if (entity != null)
		{
			OnEnterEvt(entity, this);
			if (entity == MonoECS.instance.mainEntity)
			{
				_mainEntityCollider = null;
			}
		}
	}

	private void OnTriggerStay(Collider other)
	{
		_currentColliders.Add(other);
		OnTriggerStayCallback?.Invoke(other);
	}

	private void ValidateColliders()
	{
		_currentColliders.RemoveWhere((Collider x) => x == null);
	}

	public void AddTriggerByTriggerConfig(TriggerConfig config)
	{
		if ((bool)Trigger)
		{
			if (!Application.isPlaying)
			{
				Object.DestroyImmediate(Trigger);
			}
			else
			{
				Object.Destroy(Trigger);
			}
		}
		switch (config.triggerType)
		{
		case TriggerType.Capsule:
		{
			CapsuleCollider capsuleCollider = gameObject.AddComponent<CapsuleCollider>();
			capsuleCollider.radius = config.capsuleTriggerRadius;
			capsuleCollider.height = config.capsuleTriggerHeight;
			capsuleCollider.direction = config.capsuleTriggerDirection;
			capsuleCollider.center = config.capsuleTriggerCenter;
			Trigger = capsuleCollider;
			break;
		}
		case TriggerType.Box:
		{
			BoxCollider boxCollider = gameObject.AddComponent<BoxCollider>();
			boxCollider.center = config.bounds.center;
			boxCollider.size = config.bounds.size;
			Trigger = boxCollider;
			break;
		}
		case TriggerType.Sphere:
		{
			SphereCollider sphereCollider = gameObject.AddComponent<SphereCollider>();
			sphereCollider.center = config.triggerCenter;
			sphereCollider.radius = config.radius;
			Trigger = sphereCollider;
			break;
		}
		}
		Trigger.isTrigger = true;
		Trigger.enabled = HasValidTriggerSize(config);
	}

	private static bool HasValidTriggerSize(TriggerConfig config)
	{
		return config.triggerType switch
		{
			TriggerType.Capsule => config.capsuleTriggerRadius > 0f && config.capsuleTriggerHeight > 0f, 
			TriggerType.Box => config.bounds.size.x > 0f && config.bounds.size.y > 0f && config.bounds.size.z > 0f, 
			TriggerType.Sphere => config.radius > 0f, 
			_ => true, 
		};
	}

	public void TriggerExit()
	{
		if ((bool)_mainEntityCollider)
		{
			_currentColliders.Remove(_mainEntityCollider);
			OnTriggerExitCallback?.Invoke(_mainEntityCollider);
		}
	}

	public void TriggerCurrentOverlaps(int layerMask)
	{
		if (!Trigger || !isActiveAndEnabled || !Trigger.enabled || !Trigger.gameObject.activeInHierarchy)
		{
			return;
		}
		Physics.SyncTransforms();
		int num = OverlapTrigger(Trigger, layerMask);
		for (int i = 0; i < num; i++)
		{
			Collider collider = InitialOverlapResults[i];
			InitialOverlapResults[i] = null;
			if (!(collider == Trigger))
			{
				InvokeTriggerEnter(collider, ignoreKnownCollider: true);
			}
		}
	}

	private static int OverlapTrigger(Collider trigger, int layerMask)
	{
		if (!(trigger is BoxCollider boxCollider))
		{
			if (!(trigger is SphereCollider sphereCollider))
			{
				if (trigger is CapsuleCollider capsule)
				{
					GetCapsuleWorldPoints(capsule, out var point, out var point2, out var radius);
					return Physics.OverlapCapsuleNonAlloc(point, point2, radius, InitialOverlapResults, layerMask, QueryTriggerInteraction.Collide);
				}
				Bounds bounds = trigger.bounds;
				return Physics.OverlapBoxNonAlloc(bounds.center, bounds.extents, InitialOverlapResults, Quaternion.identity, layerMask, QueryTriggerInteraction.Collide);
			}
			return Physics.OverlapSphereNonAlloc(sphereCollider.transform.TransformPoint(sphereCollider.center), GetSphereWorldRadius(sphereCollider), InitialOverlapResults, layerMask, QueryTriggerInteraction.Collide);
		}
		return Physics.OverlapBoxNonAlloc(boxCollider.transform.TransformPoint(boxCollider.center), ScaleAbs(boxCollider.size, boxCollider.transform.lossyScale) * 0.5f, InitialOverlapResults, boxCollider.transform.rotation, layerMask, QueryTriggerInteraction.Collide);
	}

	private static Vector3 ScaleAbs(Vector3 size, Vector3 scale)
	{
		return new Vector3(Mathf.Abs(size.x * scale.x), Mathf.Abs(size.y * scale.y), Mathf.Abs(size.z * scale.z));
	}

	private static float GetSphereWorldRadius(SphereCollider sphere)
	{
		Vector3 lossyScale = sphere.transform.lossyScale;
		return sphere.radius * Mathf.Max(Mathf.Abs(lossyScale.x), Mathf.Abs(lossyScale.y), Mathf.Abs(lossyScale.z));
	}

	private static void GetCapsuleWorldPoints(CapsuleCollider capsule, out Vector3 point0, out Vector3 point1, out float radius)
	{
		Transform transform = capsule.transform;
		Vector3 lossyScale = transform.lossyScale;
		int num = Mathf.Clamp(capsule.direction, 0, 2);
		Vector3 vector = num switch
		{
			0 => transform.right, 
			1 => transform.up, 
			_ => transform.forward, 
		};
		float num2 = num switch
		{
			0 => Mathf.Abs(lossyScale.x), 
			1 => Mathf.Abs(lossyScale.y), 
			_ => Mathf.Abs(lossyScale.z), 
		};
		float num3 = num switch
		{
			0 => Mathf.Max(Mathf.Abs(lossyScale.y), Mathf.Abs(lossyScale.z)), 
			1 => Mathf.Max(Mathf.Abs(lossyScale.x), Mathf.Abs(lossyScale.z)), 
			_ => Mathf.Max(Mathf.Abs(lossyScale.x), Mathf.Abs(lossyScale.y)), 
		};
		radius = capsule.radius * num3;
		float num4 = Mathf.Max(capsule.height * num2, radius * 2f);
		Vector3 vector2 = transform.TransformPoint(capsule.center);
		float num5 = Mathf.Max(0f, num4 * 0.5f - radius);
		point0 = vector2 + vector * num5;
		point1 = vector2 - vector * num5;
	}
}
