using System;
using UnityEngine;

namespace ACT.Battle;

[Serializable]
public struct AttachPoint
{
	public string key;

	public Transform transform;

	public Transform forward;

	public Vector3 GetPos()
	{
		if (transform != null)
		{
			return transform.position;
		}
		return Vector3.zero;
	}

	public Vector3 GetForward()
	{
		if (forward != null)
		{
			return forward.forward;
		}
		if (transform != null)
		{
			return transform.forward;
		}
		return Vector3.right;
	}

	public Quaternion GetRotation()
	{
		if (forward != null)
		{
			return forward.rotation;
		}
		if (transform != null)
		{
			return transform.rotation;
		}
		return Quaternion.identity;
	}

	public Quaternion GetInverse()
	{
		if (forward != null)
		{
			return Quaternion.Inverse(forward.localRotation);
		}
		return Quaternion.identity;
	}
}
