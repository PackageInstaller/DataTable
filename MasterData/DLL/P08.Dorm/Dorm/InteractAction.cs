using System;
using System.Collections.Generic;
using Dorm.Character;
using UnityEngine;

namespace Dorm;

[Serializable]
public struct InteractAction
{
	public int id;

	public Transform interactPos;

	public Transform exitPos;

	internal IEnumerable<Vector3> EnumerateTagCheckPos()
	{
		if ((bool)interactPos)
		{
			yield return interactPos.position;
		}
		if ((bool)exitPos && exitPos != interactPos)
		{
			yield return exitPos.position;
		}
	}

	public static Collider[] CalcColliderOverlappedOnPos(Vector3 pos, float radius, float height)
	{
		Vector3 point = pos + radius * Vector3.up;
		Vector3 point2 = pos + (height - radius) * Vector3.up;
		int ignoreGroundRaycastAndCharaLayer = DormEntityAction.ignoreGroundRaycastAndCharaLayer;
		return Physics.OverlapCapsule(point, point2, radius, ignoreGroundRaycastAndCharaLayer, QueryTriggerInteraction.Ignore);
	}

	public Collider[] ColliderOnInteractPos(float radius, float height)
	{
		if (!interactPos)
		{
			return null;
		}
		return CalcColliderOverlappedOnPos(interactPos.position, radius, height);
	}

	public Collider[] ColliderOnExitPos(float radius, float height)
	{
		if (!exitPos)
		{
			return null;
		}
		return CalcColliderOverlappedOnPos(exitPos.position, radius, height);
	}
}
