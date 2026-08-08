using System;
using UnityEngine;
using UnityEngine.EventSystems;

public class BlisterEntity : MonoBehaviour
{
	protected EventTrigger trigger;

	public Action<GameObject> onPointerClick;

	protected float collisionDis = 0.5f;

	public bool IsCross(Vector3 targetPos, float dis)
	{
		return Vector3.Distance(base.transform.position, targetPos) <= dis;
	}

	public bool IsCollision(BlisterEntity otherObj)
	{
		return Vector3.Distance(base.transform.position, otherObj.transform.position) <= collisionDis;
	}

	public virtual void OnCollision(BlisterEntity otherObj)
	{
	}

	public virtual void RefreshNodeState()
	{
	}

	public virtual void BlisterBoom()
	{
	}

	public void AddEventListenner()
	{
		trigger = base.gameObject.GetComponent<EventTrigger>();
		if (trigger == null)
		{
			trigger = base.gameObject.AddComponent<EventTrigger>();
		}
		EventTrigger.Entry entry = new EventTrigger.Entry();
		entry.eventID = EventTriggerType.PointerClick;
		entry.callback.AddListener(delegate
		{
			OnClick();
		});
		trigger.triggers.Add(entry);
	}

	public virtual void OnClick()
	{
	}
}
