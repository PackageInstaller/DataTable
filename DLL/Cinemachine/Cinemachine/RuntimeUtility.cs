using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.Undoc)]
public static class RuntimeUtility
{
	private static RaycastHit[] s_HitBuffer = (RaycastHit[])(object)new RaycastHit[16];

	private static int[] s_PenetrationIndexBuffer = new int[16];

	private static SphereCollider s_ScratchCollider;

	private static GameObject s_ScratchColliderGameObject;

	public static void DestroyObject(Object obj)
	{
		if (obj != null)
		{
			Object.Destroy(obj);
		}
	}

	public static bool IsPrefab(GameObject gameObject)
	{
		return false;
	}

	public static bool RaycastIgnoreTag(Ray ray, out RaycastHit hitInfo, float rayLength, int layerMask, in string ignoreTag)
	{
		//IL_00af: Unknown result type (might be due to invalid IL or missing references)
		//IL_0085: Unknown result type (might be due to invalid IL or missing references)
		//IL_008a: Unknown result type (might be due to invalid IL or missing references)
		if (ignoreTag.Length == 0)
		{
			if (Physics.Raycast(ray, ref hitInfo, rayLength, layerMask, (QueryTriggerInteraction)1))
			{
				return true;
			}
		}
		else
		{
			int num = -1;
			int num2 = Physics.RaycastNonAlloc(ray, s_HitBuffer, rayLength, layerMask, (QueryTriggerInteraction)1);
			for (int i = 0; i < num2; i++)
			{
				if (!((Component)(object)((RaycastHit)(ref s_HitBuffer[i])).collider).CompareTag(ignoreTag) && (num < 0 || ((RaycastHit)(ref s_HitBuffer[i])).distance < ((RaycastHit)(ref s_HitBuffer[num])).distance))
				{
					num = i;
				}
			}
			if (num >= 0)
			{
				hitInfo = s_HitBuffer[num];
				if (num2 == s_HitBuffer.Length)
				{
					s_HitBuffer = (RaycastHit[])(object)new RaycastHit[s_HitBuffer.Length * 2];
				}
				return true;
			}
		}
		hitInfo = default(RaycastHit);
		return false;
	}

	public static bool SphereCastIgnoreTag(Vector3 rayStart, float radius, Vector3 dir, out RaycastHit hitInfo, float rayLength, int layerMask, in string ignoreTag)
	{
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_015e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0234: Unknown result type (might be due to invalid IL or missing references)
		//IL_020a: Unknown result type (might be due to invalid IL or missing references)
		//IL_020f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0176: Unknown result type (might be due to invalid IL or missing references)
		//IL_017b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f2: Unknown result type (might be due to invalid IL or missing references)
		int num = -1;
		int num2 = 0;
		float num3 = 0f;
		int num4 = Physics.SphereCastNonAlloc(rayStart, radius, dir, s_HitBuffer, rayLength, layerMask, (QueryTriggerInteraction)1);
		Vector3 vector = default(Vector3);
		float num5 = default(float);
		for (int i = 0; i < num4; i++)
		{
			RaycastHit val = s_HitBuffer[i];
			if (ignoreTag.Length > 0 && ((Component)(object)((RaycastHit)(ref val)).collider).CompareTag(ignoreTag))
			{
				continue;
			}
			if (((RaycastHit)(ref val)).distance == 0f && ((RaycastHit)(ref val)).normal == -dir)
			{
				SphereCollider scratchCollider = GetScratchCollider();
				scratchCollider.radius = radius;
				Collider collider = ((RaycastHit)(ref val)).collider;
				if (!Physics.ComputePenetration((Collider)(object)scratchCollider, rayStart, Quaternion.identity, collider, ((Component)(object)collider).transform.position, ((Component)(object)collider).transform.rotation, ref vector, ref num5))
				{
					continue;
				}
				((RaycastHit)(ref val)).point = rayStart + vector * (num5 - radius);
				((RaycastHit)(ref val)).distance = num5 - radius;
				((RaycastHit)(ref val)).normal = vector;
				s_HitBuffer[i] = val;
				if (((RaycastHit)(ref val)).distance < -0.0001f)
				{
					num3 += ((RaycastHit)(ref val)).distance;
					if (s_PenetrationIndexBuffer.Length > num2 + 1)
					{
						s_PenetrationIndexBuffer[num2++] = i;
					}
				}
			}
			if (num < 0 || ((RaycastHit)(ref val)).distance < ((RaycastHit)(ref s_HitBuffer[num])).distance)
			{
				num = i;
			}
		}
		if (num2 > 1)
		{
			hitInfo = default(RaycastHit);
			for (int j = 0; j < num2; j++)
			{
				RaycastHit val2 = s_HitBuffer[s_PenetrationIndexBuffer[j]];
				float num6 = ((RaycastHit)(ref val2)).distance / num3;
				((RaycastHit)(ref hitInfo)).point = ((RaycastHit)(ref hitInfo)).point + ((RaycastHit)(ref val2)).point * num6;
				((RaycastHit)(ref hitInfo)).distance = ((RaycastHit)(ref hitInfo)).distance + ((RaycastHit)(ref val2)).distance * num6;
				((RaycastHit)(ref hitInfo)).normal = ((RaycastHit)(ref hitInfo)).normal + ((RaycastHit)(ref val2)).normal * num6;
			}
			((RaycastHit)(ref hitInfo)).normal = ((RaycastHit)(ref hitInfo)).normal.normalized;
			return true;
		}
		if (num >= 0)
		{
			hitInfo = s_HitBuffer[num];
			if (num4 == s_HitBuffer.Length)
			{
				s_HitBuffer = (RaycastHit[])(object)new RaycastHit[s_HitBuffer.Length * 2];
			}
			return true;
		}
		hitInfo = default(RaycastHit);
		return false;
	}

	internal static SphereCollider GetScratchCollider()
	{
		if (s_ScratchColliderGameObject == null)
		{
			s_ScratchColliderGameObject = new GameObject("Cinemachine Scratch Collider");
			s_ScratchColliderGameObject.hideFlags = HideFlags.HideAndDontSave;
			s_ScratchColliderGameObject.transform.position = Vector3.zero;
			s_ScratchColliderGameObject.SetActive(value: true);
			s_ScratchCollider = s_ScratchColliderGameObject.AddComponent<SphereCollider>();
			((Collider)s_ScratchCollider).isTrigger = true;
			Rigidbody obj = s_ScratchColliderGameObject.AddComponent<Rigidbody>();
			obj.detectCollisions = false;
			obj.isKinematic = true;
		}
		return s_ScratchCollider;
	}

	internal static void DestroyScratchCollider()
	{
		if (s_ScratchColliderGameObject != null)
		{
			s_ScratchColliderGameObject.SetActive(value: false);
			DestroyObject((Object)(object)s_ScratchColliderGameObject.GetComponent<Rigidbody>());
		}
		DestroyObject((Object)(object)s_ScratchCollider);
		DestroyObject(s_ScratchColliderGameObject);
		s_ScratchColliderGameObject = null;
		s_ScratchCollider = null;
	}

	public static AnimationCurve NormalizeCurve(AnimationCurve curve, bool normalizeX, bool normalizeY)
	{
		if (!normalizeX && !normalizeY)
		{
			return curve;
		}
		Keyframe[] keys = curve.keys;
		if (keys.Length != 0)
		{
			float num = keys[0].time;
			float num2 = num;
			float num3 = keys[0].value;
			float num4 = num3;
			for (int i = 0; i < keys.Length; i++)
			{
				num = Mathf.Min(num, keys[i].time);
				num2 = Mathf.Max(num2, keys[i].time);
				num3 = Mathf.Min(num3, keys[i].value);
				num4 = Mathf.Max(num4, keys[i].value);
			}
			float num5 = num2 - num;
			float num6 = ((num5 < 0.0001f) ? 1f : (1f / num5));
			num5 = num4 - num3;
			float num7 = ((num5 < 1f) ? 1f : (1f / num5));
			float num8 = 0f;
			if (num5 < 1f)
			{
				num8 = ((!(num3 > 0f) || !(num3 + num5 <= 1f)) ? (1f - num5) : num3);
			}
			for (int j = 0; j < keys.Length; j++)
			{
				if (normalizeX)
				{
					keys[j].time = (keys[j].time - num) * num6;
				}
				if (normalizeY)
				{
					keys[j].value = (keys[j].value - num3) * num7 + num8;
				}
			}
			curve.keys = keys;
		}
		return curve;
	}
}
