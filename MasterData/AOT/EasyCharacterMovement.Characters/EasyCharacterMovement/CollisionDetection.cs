using System;
using UnityEngine;

namespace EasyCharacterMovement;

public static class CollisionDetection
{
	private const int kMaxHits = 8;

	private static readonly RaycastHit[] HitsBuffer = new RaycastHit[8];

	public static int Raycast(Vector3 origin, Vector3 direction, float distance, int layerMask, QueryTriggerInteraction queryTriggerInteraction, out RaycastHit closestHit, RaycastHit[] hits, IColliderFilter colliderFilter)
	{
		closestHit = default;
		int num = Physics.RaycastNonAlloc(origin, direction, HitsBuffer, distance, layerMask, queryTriggerInteraction);
		if (num == 0)
		{
			return 0;
		}
		int result = 0;
		float num2 = float.PositiveInfinity;
		Array.Clear(hits, 0, hits.Length);
		for (int i = 0; i < num; i++)
		{
			if (!(HitsBuffer[i].distance <= 0f) && (colliderFilter == null || !colliderFilter.Filter(HitsBuffer[i].collider)))
			{
				if (HitsBuffer[i].distance < num2)
				{
					closestHit = HitsBuffer[i];
					num2 = closestHit.distance;
				}
				hits[result++] = HitsBuffer[i];
			}
		}
		return result;
	}

	public static int SphereCast(Vector3 origin, float radius, Vector3 direction, float distance, int layerMask, QueryTriggerInteraction queryTriggerInteraction, out RaycastHit closestHit, RaycastHit[] hits, IColliderFilter colliderFilter, float backstepDistance)
	{
		closestHit = default;
		Vector3 origin2 = origin - direction * backstepDistance;
		float maxDistance = distance + backstepDistance;
		int num = Physics.SphereCastNonAlloc(origin2, radius, direction, HitsBuffer, maxDistance, layerMask, queryTriggerInteraction);
		if (num == 0)
		{
			return 0;
		}
		int result = 0;
		float num2 = float.PositiveInfinity;
		Array.Clear(hits, 0, hits.Length);
		for (int i = 0; i < num; i++)
		{
			if (!(HitsBuffer[i].distance <= 0f) && (colliderFilter == null || !colliderFilter.Filter(HitsBuffer[i].collider)))
			{
				HitsBuffer[i].distance -= backstepDistance;
				if (HitsBuffer[i].distance < num2)
				{
					closestHit = HitsBuffer[i];
					num2 = closestHit.distance;
				}
				hits[result++] = HitsBuffer[i];
			}
		}
		return result;
	}

	public static int CapsuleCast(Vector3 point1, Vector3 point2, float radius, Vector3 direction, float distance, int layerMask, QueryTriggerInteraction queryTriggerInteraction, out RaycastHit closestHit, RaycastHit[] hits, IColliderFilter colliderFilter, float backstepDistance)
	{
		closestHit = default;
		Vector3 point3 = point1 - direction * backstepDistance;
		Vector3 point4 = point2 - direction * backstepDistance;
		float maxDistance = distance + backstepDistance;
		int num = Physics.CapsuleCastNonAlloc(point3, point4, radius, direction, HitsBuffer, maxDistance, layerMask, queryTriggerInteraction);
		if (num == 0)
		{
			return 0;
		}
		int result = 0;
		float num2 = float.PositiveInfinity;
		Array.Clear(hits, 0, hits.Length);
		for (int i = 0; i < num; i++)
		{
			if (!(HitsBuffer[i].distance <= 0f) && (colliderFilter == null || !colliderFilter.Filter(HitsBuffer[i].collider)))
			{
				HitsBuffer[i].distance -= backstepDistance;
				if (HitsBuffer[i].distance < num2)
				{
					closestHit = HitsBuffer[i];
					num2 = closestHit.distance;
				}
				hits[result++] = HitsBuffer[i];
			}
		}
		return result;
	}

	public static int OverlapCapsule(Vector3 point1, Vector3 point2, float radius, int layerMask, QueryTriggerInteraction queryTriggerInteraction, Collider[] results, IColliderFilter colliderFilter)
	{
		int num = Physics.OverlapCapsuleNonAlloc(point1, point2, radius, results, layerMask, queryTriggerInteraction);
		if (num == 0)
		{
			return 0;
		}
		int num2 = num;
		for (int i = 0; i < num; i++)
		{
			Collider otherCollider = results[i];
			if ((colliderFilter == null || colliderFilter.Filter(otherCollider)) && i < --num2)
			{
				results[i] = results[num2];
			}
		}
		return num2;
	}
}
