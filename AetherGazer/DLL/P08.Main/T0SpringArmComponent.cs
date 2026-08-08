using System;
using UnityEngine;

[Serializable]
public class T0SpringArmComponent
{
	[HideInInspector]
	public Transform handle;

	[HideInInspector]
	public Transform target;

	public bool smooth;

	public float smoothSpeed;

	public float lerpTolerence = 0.02f;

	public float tolerence = 0.5f;

	public void Init(Transform target, Transform handleAttach)
	{
		GameObject gameObject = new GameObject(handleAttach.name + "_SpringArm");
		gameObject.transform.parent = null;
		handle = gameObject.transform;
		this.target = target;
		handle.transform.position = target.position;
		handle.rotation = target.rotation;
		handle.transform.localScale = Vector3.one;
	}

	public void Reset(Transform target)
	{
		this.target = target;
		handle.transform.position = target.position;
		handle.rotation = target.rotation;
	}

	public void Tick()
	{
		if (!(handle != null) || !(target != null))
		{
			return;
		}
		Vector3 position = target.position;
		float num = Vector3.Distance(handle.position, position);
		if (num > tolerence)
		{
			handle.position = position;
		}
		else if (num > lerpTolerence)
		{
			if (smooth)
			{
				handle.position = Vector3.Lerp(handle.position, position, smoothSpeed * Time.deltaTime);
			}
			else
			{
				handle.position = position;
			}
		}
		handle.rotation = target.rotation;
	}

	public void ForceResetHandlePos(Vector3 pos, Quaternion rot)
	{
		handle.position = pos;
		handle.rotation = rot;
	}

	public void Dispose()
	{
	}
}
