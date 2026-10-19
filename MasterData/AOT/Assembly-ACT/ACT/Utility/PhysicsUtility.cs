using System;
using System.Collections.Generic;
using ACT.Battle;
using Bamboo.Collections;
using Fundamental;
using UnityEngine;

namespace ACT.Utility;

public static class PhysicsUtility
{
	public static readonly RaycastHitComparer RaycastHitComparer = new RaycastHitComparer();

	private static ArrayPool<Collider> s_CachedColliders = new ArrayPool<Collider>(50);

	private static ArrayPool<RaycastHit> s_CachedHits = new ArrayPool<RaycastHit>(50);

	private static readonly Dictionary<Collider, IColliderEntityRef> colliderEntityRefCache = new Dictionary<Collider, IColliderEntityRef>();

	public static Collider[] cacheColliders => s_CachedColliders.Get();

	public static RaycastHit[] cacheHits => s_CachedHits.Get();

	public static void Release(Collider[] c)
	{
		s_CachedColliders.Release(c);
	}

	public static void Release(RaycastHit[] c)
	{
		s_CachedHits.Release(c);
	}

	public static bool CheckLadder(Vector2 pos, Vector2 size, Bounds bounds)
	{
		if (pos.y - 0f * size.y / 2f > bounds.min.y)
		{
			return pos.y + size.y / 2f < bounds.max.y;
		}
		return false;
	}

	public static RaycastHit CapsuleCast(Vector3 colliderPos, Vector2 size, Vector3 direction, float distance)
	{
		CapsuleCast(colliderPos, size, direction, distance, out var hit);
		return hit;
	}

	public static bool CapsuleCast(Vector3 colliderPos, Vector2 size, Vector3 direction, float distance, out RaycastHit hit)
	{
		var (point, point2) = GetP0P1(colliderPos, size);
		return Physics.CapsuleCast(point, point2, size.x, direction, out hit, distance, BattleConsts.enviromentMask);
	}

	public static (Vector3, Vector3) GetP0P1(Vector3 pos, Vector2 size)
	{
		Vector3 vector = new Vector3(0f, size.y / 2f - size.x, 0f);
		Vector3 item = pos + vector;
		Vector3 item2 = pos - vector;
		return (item, item2);
	}

	[Obsolete]
	public static (Vector3, Vector3) GetCapsuleTopButtomPoint(Vector3 pos, Vector2 size)
	{
		Vector3 vector = new Vector3(0f, size.y / 2f, 0f);
		Vector3 item = pos + vector;
		Vector3 item2 = pos - vector;
		return (item, item2);
	}

	[Obsolete]
	public static RaycastHit CapsuleMove(ref Vector3 pos, Vector2 size, Vector3 normalDir, float distance)
	{
		var (point, point2) = GetP0P1(pos, size);
		if (!Physics.CapsuleCast(point, point2, size.x, normalDir, out var hitInfo, distance, BattleConsts.enviromentMask))
		{
			pos += normalDir * distance;
		}
		else
		{
			pos += normalDir * Mathf.Max(0f, hitInfo.distance);
		}
		return hitInfo;
	}

	public static Vector3 GetGroundPoint(Vector3 startPos, Vector2 size, float checkLength = 10f)
	{
		if (CapsuleCast(startPos, size, Vector3.down, checkLength, out var hit))
		{
			return hit.point + new Vector3(0f, size.y * 0.5f, 0f);
		}
		return startPos;
	}

	public static Vector2 Size(this CapsuleCollider collider)
	{
		return new Vector2(collider.radius, collider.height);
	}

	public static void GetBoxVerticesNonAlloc(Vector3 center, Vector3 size, BArray<Vector3> output)
	{
		if (output.Length != 8)
		{
			throw new NotSupportedException("输出数组长度必须为8！");
		}
		output[0] = center + new Vector3(0f - size.x, 0f - size.y, 0f - size.z) * 0.5f;
		output[1] = center + new Vector3(size.x, 0f - size.y, 0f - size.z) * 0.5f;
		output[2] = center + new Vector3(size.x, 0f - size.y, size.z) * 0.5f;
		output[3] = center + new Vector3(0f - size.x, 0f - size.y, size.z) * 0.5f;
		output[4] = center + new Vector3(0f - size.x, size.y, 0f - size.z) * 0.5f;
		output[5] = center + new Vector3(size.x, size.y, 0f - size.z) * 0.5f;
		output[6] = center + new Vector3(size.x, size.y, size.z) * 0.5f;
		output[7] = center + new Vector3(0f - size.x, size.y, size.z) * 0.5f;
	}

	public static bool VirtualPlaneOverlapBoxNonAlloc(Vector3 center, Vector3 halfExtends, BArray<Plane> virtualPlanes, Quaternion rotation)
	{
		BArray<Vector3> bArray = BArrayPool<Vector3>.Default.Get(8);
		GetBoxVerticesNonAlloc(center, halfExtends * 2f, bArray);
		for (int i = 0; i < 8; i++)
		{
			bArray[i] = rotation * bArray[i];
		}
		for (int j = 0; j < virtualPlanes.Length; j++)
		{
			Plane plane = virtualPlanes[j];
			bool side = plane.GetSide(bArray[0]);
			for (int k = 1; k < 8; k++)
			{
				if (plane.GetSide(bArray[k]) != side)
				{
					BArrayPool<Vector3>.Default.Recycle(bArray);
					return true;
				}
			}
		}
		BArrayPool<Vector3>.Default.Recycle(bArray);
		return false;
	}

	public static bool VirtualPlaneOverlapSphereNonAlloc(Vector3 center, float radius, BArray<Plane> virtualPlanes)
	{
		for (int i = 0; i < virtualPlanes.Length; i++)
		{
			if (Mathf.Abs(virtualPlanes[i].GetDistanceToPoint(center)) < radius)
			{
				return true;
			}
		}
		return false;
	}

	public static bool VirtualPlaneBoxCastNonAlloc(Vector3 center, Vector3 halfExtends, Vector3 direction, BArray<Plane> virtualPlanes, Quaternion rotation, float maxDistance, out float hitDis)
	{
		BArray<Vector3> bArray = BArrayPool<Vector3>.Default.Get(8);
		BArray<Vector3> bArray2 = BArrayPool<Vector3>.Default.Get(8);
		GetBoxVerticesNonAlloc(center, halfExtends * 2f, bArray);
		for (int i = 0; i < 8; i++)
		{
			bArray[i] = rotation * bArray[i];
			bArray2[i] = bArray[i] + direction * maxDistance;
		}
		hitDis = -1f;
		int num = 0;
		while (true)
		{
			if (num < virtualPlanes.Length)
			{
				Plane plane = virtualPlanes[num];
				bool side = plane.GetSide(bArray[0]);
				if (side != plane.GetSide(bArray2[0]))
				{
					hitDis = Mathf.Abs(plane.GetDistanceToPoint(center));
					break;
				}
				for (int j = 1; j < 8; j++)
				{
					if (plane.GetSide(bArray[j]) != side || plane.GetSide(bArray2[j]) != side)
					{
						goto end_IL_00e9;
					}
				}
				num++;
				continue;
			}
			BArrayPool<Vector3>.Default.Recycle(bArray);
			BArrayPool<Vector3>.Default.Recycle(bArray2);
			return false;
			continue;
			end_IL_00e9:
			break;
		}
		BArrayPool<Vector3>.Default.Recycle(bArray);
		BArrayPool<Vector3>.Default.Recycle(bArray2);
		return true;
	}

	public static bool VirtualPlaneSphereCastNonAlloc(Vector3 center, float radius, Vector3 direction, BArray<Plane> virtualPlanes, float maxDistance, out float hitDis)
	{
		Vector3 point = center + direction * maxDistance;
		hitDis = -1f;
		for (int i = 0; i < virtualPlanes.Length; i++)
		{
			if (Mathf.Abs(virtualPlanes[i].GetDistanceToPoint(center)) < radius || Mathf.Abs(virtualPlanes[i].GetDistanceToPoint(point)) < radius || virtualPlanes[i].GetSide(center) != virtualPlanes[i].GetSide(point))
			{
				hitDis = virtualPlanes[i].GetDistanceToPoint(center);
				return true;
			}
		}
		return false;
	}

	public static bool CapsuleCast(Vector3 characterPosition, float height, float castRadius, Vector3 castDirection, float castDistance, Func<Collider, bool> shouldFilter, int layerMask, out RaycastHit hitResult, out bool startPenetrating)
	{
		bool result = false;
		hitResult = default;
		startPenetrating = false;
		Vector3 point = characterPosition + new Vector3(0f, height, 0f);
		Vector3 point2 = characterPosition + new Vector3(0f, 0f, 0f);
		RaycastHit[] array = cacheHits;
		int num = Physics.CapsuleCastNonAlloc(point2, point, castRadius, castDirection, array, castDistance, layerMask);
		if (num != 0)
		{
			float num2 = float.PositiveInfinity;
			int num3 = -1;
			int num4 = -1;
			for (int i = 0; i < num; i++)
			{
				ref RaycastHit reference = ref array[i];
				if (shouldFilter(reference.collider))
				{
					continue;
				}
				if (reference.distance <= 0f)
				{
					startPenetrating = true;
					if (reference.collider.transform.rotation != Quaternion.identity && num4 == -1)
					{
						num4 = i;
					}
				}
				else if (reference.distance < num2)
				{
					num2 = reference.distance;
					num3 = i;
				}
			}
			if (num4 != -1)
			{
				num3 = num4;
			}
			if (num3 != -1)
			{
				hitResult = array[num3];
				result = true;
			}
		}
		Release(array);
		return result;
	}

	public static void ComputeCapsulePenetrationFix(Vector3 characterPosition, float height, float radius, int layerMask, Func<Collider, bool> shouldFilter, out Vector3 penetratingFix)
	{
		penetratingFix = Vector3.zero;
		Vector3 vector = characterPosition + new Vector3(0f, radius, 0f);
		Vector3 point = vector + new Vector3(0f, Mathf.Max(0f, height - radius * 2f), 0f);
		Collider[] array = Physics.OverlapCapsule(vector, point, radius, layerMask);
		foreach (Collider collider in array)
		{
			if ((shouldFilter == null || !shouldFilter(collider)) && !(collider is MeshCollider { convex: false }))
			{
				Vector3 vector2 = collider.ClosestPoint(characterPosition);
				Vector3 a = characterPosition - vector2;
				float y = a.y;
				if (Mathf.Abs(y) < height / 2f)
				{
					float num = height / 2f - Mathf.Abs(y);
					penetratingFix += Vector3.Scale(a, new Vector3(0f, 1f, 0f)) * num;
				}
			}
		}
	}

	public static bool VirtualPlaneOverlapCustomNonAlloc(Collider[] customColliders, Vector3 worldPosition, Quaternion worldRotation, BArray<Plane> virtualPlanes)
	{
		if (customColliders == null || customColliders.Length == 0)
		{
			return false;
		}
		foreach (Collider collider in customColliders)
		{
			if (collider == null)
			{
				continue;
			}
			Quaternion localRotation = collider.transform.localRotation;
			Vector3 vector = worldPosition + worldRotation * collider.transform.localPosition;
			if (!(collider is BoxCollider boxCollider))
			{
				if (!(collider is SphereCollider sphereCollider))
				{
					if (collider is CapsuleCollider capsuleCollider)
					{
						Vector3 center = vector + worldRotation * capsuleCollider.center;
						Vector3 halfExtends = new Vector3(capsuleCollider.radius * 2f * Mathf.Max(capsuleCollider.transform.lossyScale.x, capsuleCollider.transform.lossyScale.z), capsuleCollider.height * capsuleCollider.transform.lossyScale.y, capsuleCollider.radius * 2f * Mathf.Max(capsuleCollider.transform.lossyScale.x, capsuleCollider.transform.lossyScale.z)) / 2f;
						Quaternion rotation = worldRotation * localRotation;
						if (VirtualPlaneOverlapBoxNonAlloc(center, halfExtends, virtualPlanes, rotation))
						{
							return true;
						}
					}
				}
				else
				{
					Vector3 center2 = vector + worldRotation * sphereCollider.center;
					float radius = sphereCollider.radius * Mathf.Max(sphereCollider.transform.lossyScale.x, Mathf.Max(sphereCollider.transform.lossyScale.y, sphereCollider.transform.lossyScale.z));
					if (VirtualPlaneOverlapSphereNonAlloc(center2, radius, virtualPlanes))
					{
						return true;
					}
				}
			}
			else
			{
				Vector3 center3 = vector + worldRotation * boxCollider.center;
				Quaternion rotation2 = worldRotation * localRotation;
				Vector3 halfExtends2 = Vector3.Scale(boxCollider.size, boxCollider.transform.lossyScale) / 2f;
				if (VirtualPlaneOverlapBoxNonAlloc(center3, halfExtends2, virtualPlanes, rotation2))
				{
					return true;
				}
			}
		}
		return false;
	}

	public static bool VirtualPlaneCustomCastNonAlloc(Collider[] customColliders, Vector3 worldPosition, Quaternion worldRotation, Vector3 direction, BArray<Plane> virtualPlanes, float maxDistance, out float hitDis)
	{
		hitDis = -1f;
		if (customColliders == null || customColliders.Length == 0)
		{
			return false;
		}
		float num = float.MaxValue;
		bool flag = false;
		foreach (Collider collider in customColliders)
		{
			if (collider == null)
			{
				continue;
			}
			Quaternion localRotation = collider.transform.localRotation;
			Vector3 vector = worldPosition + worldRotation * collider.transform.localPosition;
			if (!(collider is BoxCollider boxCollider))
			{
				if (!(collider is SphereCollider sphereCollider))
				{
					if (!(collider is CapsuleCollider capsuleCollider))
					{
						continue;
					}
					Vector3 center = vector + worldRotation * capsuleCollider.center;
					Vector3 halfExtends = new Vector3(capsuleCollider.radius * 2f * Mathf.Max(capsuleCollider.transform.lossyScale.x, capsuleCollider.transform.lossyScale.z), capsuleCollider.height * capsuleCollider.transform.lossyScale.y, capsuleCollider.radius * 2f * Mathf.Max(capsuleCollider.transform.lossyScale.x, capsuleCollider.transform.lossyScale.z)) / 2f;
					Quaternion rotation = worldRotation * localRotation;
					if (VirtualPlaneBoxCastNonAlloc(center, halfExtends, direction, virtualPlanes, rotation, maxDistance, out var hitDis2))
					{
						flag = true;
						if (hitDis2 >= 0f && hitDis2 < num)
						{
							num = hitDis2;
						}
					}
					continue;
				}
				Vector3 center2 = vector + worldRotation * sphereCollider.center;
				float radius = sphereCollider.radius * Mathf.Max(sphereCollider.transform.lossyScale.x, Mathf.Max(sphereCollider.transform.lossyScale.y, sphereCollider.transform.lossyScale.z));
				if (VirtualPlaneSphereCastNonAlloc(center2, radius, direction, virtualPlanes, maxDistance, out var hitDis3))
				{
					flag = true;
					if (hitDis3 >= 0f && hitDis3 < num)
					{
						num = hitDis3;
					}
				}
				continue;
			}
			Vector3 center3 = vector + worldRotation * boxCollider.center;
			Quaternion rotation2 = worldRotation * localRotation;
			Vector3 halfExtends2 = Vector3.Scale(boxCollider.size, boxCollider.transform.lossyScale) / 2f;
			if (VirtualPlaneBoxCastNonAlloc(center3, halfExtends2, direction, virtualPlanes, rotation2, maxDistance, out var hitDis4))
			{
				flag = true;
				if (hitDis4 >= 0f && hitDis4 < num)
				{
					num = hitDis4;
				}
			}
		}
		if (flag && num < float.MaxValue)
		{
			hitDis = num;
			return true;
		}
		return false;
	}

	public static int OverlapCustomCollider(Collider collider, Vector3 worldPosition, Quaternion worldRotation, Collider[] outputColliders, int layerMask)
	{
		if (collider == null)
		{
			return 0;
		}
		Quaternion localRotation = collider.transform.localRotation;
		Vector3 vector = worldPosition + worldRotation * collider.transform.localPosition;
		if (!(collider is BoxCollider boxCollider))
		{
			if (!(collider is SphereCollider sphereCollider))
			{
				if (collider is CapsuleCollider capsuleCollider)
				{
					Vector3 vector2 = vector + worldRotation * capsuleCollider.center;
					float num = capsuleCollider.radius * Mathf.Max(capsuleCollider.transform.lossyScale.x, capsuleCollider.transform.lossyScale.z);
					float num2 = capsuleCollider.height * capsuleCollider.transform.lossyScale.y;
					Vector3 point = vector2 + new Vector3(0f, num2 / 2f - num, 0f);
					Vector3 point2 = vector2 - new Vector3(0f, num2 / 2f - num, 0f);
					return Physics.OverlapCapsuleNonAlloc(point, point2, num, outputColliders, layerMask);
				}
				return 0;
			}
			Vector3 position = vector + worldRotation * sphereCollider.center;
			float radius = sphereCollider.radius * Mathf.Max(sphereCollider.transform.lossyScale.x, Mathf.Max(sphereCollider.transform.lossyScale.y, sphereCollider.transform.lossyScale.z));
			return Physics.OverlapSphereNonAlloc(position, radius, outputColliders, layerMask);
		}
		Vector3 center = vector + worldRotation * boxCollider.center;
		Quaternion orientation = worldRotation * localRotation;
		Vector3 halfExtents = Vector3.Scale(boxCollider.size, boxCollider.transform.lossyScale) / 2f;
		return Physics.OverlapBoxNonAlloc(center, halfExtents, outputColliders, orientation, layerMask);
	}

	public static int CastCustomCollider(Collider collider, Vector3 worldPosition, Quaternion worldRotation, Vector3 direction, RaycastHit[] outputHits, float maxDistance, int layerMask)
	{
		if (collider == null)
		{
			return 0;
		}
		Quaternion localRotation = collider.transform.localRotation;
		Vector3 vector = worldPosition + worldRotation * collider.transform.localPosition;
		if (!(collider is BoxCollider boxCollider))
		{
			if (!(collider is SphereCollider sphereCollider))
			{
				if (collider is CapsuleCollider capsuleCollider)
				{
					Vector3 vector2 = vector + worldRotation * capsuleCollider.center;
					float num = capsuleCollider.radius * Mathf.Max(capsuleCollider.transform.lossyScale.x, capsuleCollider.transform.lossyScale.z);
					float num2 = capsuleCollider.height * capsuleCollider.transform.lossyScale.y;
					return Physics.CapsuleCastNonAlloc(point2: vector2 + new Vector3(0f, num2 / 2f - num, 0f), point1: vector2 - new Vector3(0f, num2 / 2f - num, 0f), radius: num, direction: direction, results: outputHits, maxDistance: maxDistance, layerMask: layerMask);
				}
				return 0;
			}
			Vector3 origin = vector + worldRotation * sphereCollider.center;
			float radius = sphereCollider.radius * Mathf.Max(sphereCollider.transform.lossyScale.x, Mathf.Max(sphereCollider.transform.lossyScale.y, sphereCollider.transform.lossyScale.z));
			return Physics.SphereCastNonAlloc(origin, radius, direction, outputHits, maxDistance, layerMask);
		}
		Vector3 center = vector + worldRotation * boxCollider.center;
		Quaternion orientation = worldRotation * localRotation;
		Vector3 halfExtents = Vector3.Scale(boxCollider.size, boxCollider.transform.lossyScale) / 2f;
		return Physics.BoxCastNonAlloc(center, halfExtents, direction, outputHits, orientation, maxDistance, layerMask);
	}

	public static bool IsPositionInsideBounds(Vector3 boundsCenter, Vector3 boundsExtents, Quaternion boundRotation, Vector3 pos)
	{
		Vector3 vector = Quaternion.Inverse(boundRotation) * (pos - boundsCenter);
		if (Mathf.Abs(vector.x) <= boundsExtents.x && Mathf.Abs(vector.y) <= boundsExtents.y)
		{
			return Mathf.Abs(vector.z) <= boundsExtents.z;
		}
		return false;
	}

	public static IColliderEntityRef GetEntityRef(Collider col)
	{
		if (!colliderEntityRefCache.TryGetValue(col, out var value))
		{
			value = col.GetComponentInParent<IColliderEntityRef>();
			if (value != null)
			{
				colliderEntityRefCache[col] = value;
			}
		}
		return value;
	}

	public static void RemoveEntityRef(Collider col)
	{
		if (colliderEntityRefCache.ContainsKey(col))
		{
			colliderEntityRefCache.Remove(col);
		}
	}

	public static T GetEntityRef<T>(Collider col) where T : class, IColliderEntityRef
	{
		if (colliderEntityRefCache.TryGetValue(col, out var value))
		{
			return value as T;
		}
		return null;
	}
}
