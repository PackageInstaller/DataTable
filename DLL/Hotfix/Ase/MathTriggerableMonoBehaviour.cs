using Ase.ECS;
using UnityEngine;

namespace Ase;

public class MathTriggerableMonoBehaviour : MonoBehaviour, IMathTriggerable
{
	private Bounds bounds;

	private Collider collider;

	private BaseEntity entity;

	public bool IsActor
	{
		get
		{
			if (entity == null && TryGetComponent<EntityView>(out var component))
			{
				entity = component.Entity;
			}
			return entity?.IsActorEntity ?? false;
		}
	}

	public GameObject Owner => base.gameObject;

	public Vector3 Position => base.transform.position;

	public Bounds Bounds()
	{
		if ((bool)(Object)(object)collider)
		{
			return collider.bounds;
		}
		bounds.center = Position;
		return bounds;
	}

	protected virtual void OnEnable()
	{
		collider = GetComponent<Collider>();
		bounds = new Bounds(Position, Vector3.one);
		RegisterAsTriggerable();
	}

	protected virtual void OnDisable()
	{
		collider = null;
		entity = null;
		UnregisterAsTriggerable();
	}

	protected virtual void OnDestroy()
	{
		UnregisterAsTriggerable();
	}

	public void RegisterAsTriggerable()
	{
		Singleton<MathTriggerSystem>.Instance?.RegisterTriggerable(this);
	}

	public void UnregisterAsTriggerable()
	{
		Singleton<MathTriggerSystem>.Instance?.UnregisterTriggerable(this);
	}
}
