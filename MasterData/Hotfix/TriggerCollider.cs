using System.Collections.Generic;
using UnityEngine;

public class TriggerCollider : TriggerConditionBase, IDeterministicCollisionListener
{
	public enum EventTriggerType
	{
		onEnter,
		onExit
	}

	public EventTriggerType _EventTriggerType;

	public TriggerManager.colliderType colliderT;

	public List<TriggerColliderSingle> colliders = new List<TriggerColliderSingle>
	{
		Capacity = 0
	};

	protected int collideCount;

	private void Awake()
	{
	}

	public override void SyncPosition()
	{
		base.SyncPosition();
		List<TriggerColliderSingle> list = colliders;
		if (list != null && list.Count > 0)
		{
			for (int i = 0; i < colliders.Count; i++)
			{
				colliders.get_Item(i).ActiveSelf = true;
				colliders.get_Item(i).tsTransform.RefreshTsPos();
			}
		}
	}

	public override void StateReset()
	{
		base.StateReset();
		collideCount = 0;
	}

	public override void OnTrigger()
	{
		if (CanTrigger())
		{
			base.OnTrigger();
		}
	}

	public override void DisableTrigger()
	{
		base.DisableTrigger();
		InitCollider();
		gameObject.layer = 10;
		if (currentSate == TriggerManager.triggerState.pause || currentSate == TriggerManager.triggerState.destroy)
		{
			for (int i = 0; i < colliders.Count; i++)
			{
				colliders.get_Item(i).UnRegister();
			}
		}
	}

	public override void ToActive()
	{
		base.ToActive();
		InitCollider();
		gameObject.layer = 10;
		for (int i = 0; i < colliders.Count; i++)
		{
			colliders.get_Item(i).Register(this);
		}
	}

	protected void InitCollider()
	{
		if (colliders == null || colliders.Count == 0)
		{
			TriggerColliderSingle component = GetComponent<TriggerColliderSingle>();
			if (null != component)
			{
				colliders.Add(component);
			}
			TriggerColliderSingle[] componentsInChildren = GetComponentsInChildren<TriggerColliderSingle>();
			colliders.AddRange(componentsInChildren);
		}
		collideCount = 0;
	}

	private bool CheckTarget(DeterministicCollider other)
	{
		switch (colliderT)
		{
		case TriggerManager.colliderType.playerSelf:
			return other.Entity == SceneSingleton<AdventurePlayerController>.Instance?.activedPlayerActor;
		case TriggerManager.colliderType.enemy:
		{
			LogicEntity entity = other.Entity;
			if (entity != null && SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor != null)
			{
				return SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.IsConfrontWith(entity);
			}
			break;
		}
		case TriggerManager.colliderType.all:
			return true;
		}
		return false;
	}

	public void OnDeterministicCollisionEnter(DeterministicCollider other)
	{
		if (CheckTarget(other))
		{
			EnterCollider(other.gameObject);
		}
	}

	public void OnDeterministicCollisionStay(DeterministicCollider other)
	{
	}

	public void OnDeterministicCollisionExit(DeterministicCollider other)
	{
		if (CheckTarget(other))
		{
			ExitCollider(other.gameObject);
		}
	}

	protected void EnterCollider(GameObject _triggerObj)
	{
		if (_EventTriggerType == EventTriggerType.onEnter)
		{
			collideCount++;
			if (collideCount == 1)
			{
				triggerOwner = _triggerObj;
				OnTrigger();
			}
		}
	}

	protected void ExitCollider(GameObject _triggerObj)
	{
		if (_EventTriggerType == EventTriggerType.onExit)
		{
			collideCount--;
			collideCount = ((collideCount >= 0) ? collideCount : 0);
			if (collideCount == 0)
			{
				triggerOwner = _triggerObj;
				OnTrigger();
			}
		}
	}
}
