using System;
using UnityEngine;

public class WorldOBB : MonoBehaviour
{
	public bool triggerOnce;

	public bool triggerDelay;

	public float delayTime;

	public BoxCollider boxCollider;

	private Action<WorldOBB> triggerAction;

	private bool isTrigger;

	private float lastTriggerTime;

	private bool isInDelay;

	private void OnValidate()
	{
		if (boxCollider == null)
		{
			boxCollider = GetComponent<BoxCollider>();
		}
	}

	public bool CheckOverlap(Vector3 pos)
	{
		Vector3 position = boxCollider.transform.position;
		Vector3 vector = pos - position;
		Quaternion rotation = boxCollider.transform.rotation;
		rotation = Quaternion.Inverse(rotation);
		return ContainsAABB(rotation * vector + position);
	}

	private bool ContainsAABB(Vector3 pos)
	{
		Vector3 vector = transform.position + boxCollider.center;
		Vector3 vector2 = Mul(boxCollider.size, transform.lossyScale) * 0.5f;
		Vector3 max = vector + vector2;
		Vector3 min = vector - vector2;
		if (LessThanMax(max, pos))
		{
			return MoreThanMin(min, pos);
		}
		return false;
	}

	private bool LessThanMax(Vector3 max, Vector3 target)
	{
		if (target.x <= max.x && target.y <= max.y)
		{
			return target.z <= max.z;
		}
		return false;
	}

	private bool MoreThanMin(Vector3 min, Vector3 target)
	{
		if (target.x >= min.x && target.y >= min.y)
		{
			return target.z >= min.z;
		}
		return false;
	}

	private Vector3 Mul(Vector3 a, Vector3 b)
	{
		return new Vector3(a.x * b.x, a.y * b.y, a.z * b.z);
	}

	public void AddListener(Action<WorldOBB> action)
	{
		triggerAction = (Action<WorldOBB>)Delegate.Combine(triggerAction, action);
	}

	public void RemoveListener(Action<WorldOBB> action)
	{
		triggerAction = (Action<WorldOBB>)Delegate.Remove(triggerAction, action);
	}

	public void OnUpdate(Vector3 pos)
	{
		if (isTrigger && triggerOnce && !triggerDelay)
		{
			return;
		}
		if (CheckOverlap(pos))
		{
			if (isInDelay && Time.time - lastTriggerTime > delayTime)
			{
				triggerAction?.Invoke(this);
				isInDelay = false;
			}
			if (!isTrigger)
			{
				if (triggerDelay)
				{
					lastTriggerTime = Time.time;
					isInDelay = true;
				}
				else
				{
					triggerAction?.Invoke(this);
				}
				isTrigger = true;
			}
		}
		else
		{
			if (!triggerOnce)
			{
				isTrigger = false;
			}
			isInDelay = false;
		}
	}
}
