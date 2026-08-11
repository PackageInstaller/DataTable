using System;
using System.Collections.Generic;
using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[ExecuteAlways]
[SaveDuringPlay]
[DisallowMultipleComponent]
[AddComponentMenu("Cinemachine/CinemachineTargetGroup")]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineTargetGroup.html")]
public class CinemachineTargetGroup : MonoBehaviour, ICinemachineTargetGroup
{
	[Serializable]
	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public struct Target
	{
		[Tooltip("The target objects.  This object's position and orientation will contribute to the group's average position and orientation, in accordance with its weight")]
		public Transform target;

		[Tooltip("How much weight to give the target when averaging.  Cannot be negative")]
		public float weight;

		[Tooltip("The radius of the target, used for calculating the bounding box.  Cannot be negative")]
		public float radius;
	}

	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public enum PositionMode
	{
		GroupCenter,
		GroupAverage
	}

	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public enum RotationMode
	{
		Manual,
		GroupAverage
	}

	public enum UpdateMethod
	{
		Update,
		FixedUpdate,
		LateUpdate
	}

	[Tooltip("How the group's position is calculated.  Select GroupCenter for the center of the bounding box, and GroupAverage for a weighted average of the positions of the members.")]
	public PositionMode m_PositionMode;

	[Tooltip("How the group's rotation is calculated.  Select Manual to use the value in the group's transform, and GroupAverage for a weighted average of the orientations of the members.")]
	public RotationMode m_RotationMode;

	[Tooltip("When to update the group's transform based on the position of the group members")]
	public UpdateMethod m_UpdateMethod = UpdateMethod.LateUpdate;

	[NoSaveDuringPlay]
	[Tooltip("The target objects, together with their weights and radii, that will contribute to the group's average position, orientation, and size.")]
	public Target[] m_Targets = Array.Empty<Target>();

	private float m_MaxWeight;

	private float m_WeightSum;

	private Vector3 m_AveragePos;

	private Bounds m_BoundingBox;

	private BoundingSphere m_BoundingSphere;

	private int m_LastUpdateFrame = -1;

	private List<int> m_ValidMembers = new List<int>();

	private List<bool> m_MemberValidity = new List<bool>();

	public Transform Transform => base.transform;

	public Bounds BoundingBox
	{
		get
		{
			if (m_LastUpdateFrame != Time.frameCount)
			{
				DoUpdate();
			}
			return m_BoundingBox;
		}
		private set
		{
			m_BoundingBox = value;
		}
	}

	public BoundingSphere Sphere
	{
		get
		{
			if (m_LastUpdateFrame != Time.frameCount)
			{
				DoUpdate();
			}
			return m_BoundingSphere;
		}
		private set
		{
			m_BoundingSphere = value;
		}
	}

	public bool IsEmpty
	{
		get
		{
			if (m_LastUpdateFrame != Time.frameCount)
			{
				DoUpdate();
			}
			return m_ValidMembers.Count == 0;
		}
	}

	private bool CachedCountIsValid => m_MemberValidity.Count == ((m_Targets != null) ? m_Targets.Length : 0);

	private void OnValidate()
	{
		int num = ((m_Targets != null) ? m_Targets.Length : 0);
		for (int i = 0; i < num; i++)
		{
			m_Targets[i].weight = Mathf.Max(0f, m_Targets[i].weight);
			m_Targets[i].radius = Mathf.Max(0f, m_Targets[i].radius);
		}
	}

	private void Reset()
	{
		m_PositionMode = PositionMode.GroupCenter;
		m_RotationMode = RotationMode.Manual;
		m_UpdateMethod = UpdateMethod.LateUpdate;
		m_Targets = Array.Empty<Target>();
	}

	public void AddMember(Transform t, float weight, float radius)
	{
		int num = 0;
		if (m_Targets == null)
		{
			m_Targets = new Target[1];
		}
		else
		{
			num = m_Targets.Length;
			Target[] targets = m_Targets;
			m_Targets = new Target[num + 1];
			Array.Copy(targets, m_Targets, num);
		}
		m_Targets[num].target = t;
		m_Targets[num].weight = weight;
		m_Targets[num].radius = radius;
	}

	public void RemoveMember(Transform t)
	{
		int num = FindMember(t);
		if (num >= 0)
		{
			Target[] targets = m_Targets;
			m_Targets = new Target[m_Targets.Length - 1];
			if (num > 0)
			{
				Array.Copy(targets, m_Targets, num);
			}
			if (num < targets.Length - 1)
			{
				Array.Copy(targets, num + 1, m_Targets, num, targets.Length - num - 1);
			}
		}
	}

	public int FindMember(Transform t)
	{
		if (m_Targets != null)
		{
			for (int num = m_Targets.Length - 1; num >= 0; num--)
			{
				if (m_Targets[num].target == t)
				{
					return num;
				}
			}
		}
		return -1;
	}

	public BoundingSphere GetWeightedBoundsForMember(int index)
	{
		if (m_LastUpdateFrame != Time.frameCount)
		{
			DoUpdate();
		}
		if (!IndexIsValid(index) || !m_MemberValidity[index])
		{
			return Sphere;
		}
		return WeightedMemberBoundsForValidMember(ref m_Targets[index], m_AveragePos, m_MaxWeight);
	}

	public Bounds GetViewSpaceBoundingBox(Matrix4x4 observer)
	{
		if (m_LastUpdateFrame != Time.frameCount)
		{
			DoUpdate();
		}
		Matrix4x4 result = observer;
		if (!Matrix4x4.Inverse3DAffine(observer, ref result))
		{
			result = observer.inverse;
		}
		Bounds result2 = new Bounds(result.MultiplyPoint3x4(m_AveragePos), Vector3.zero);
		if (CachedCountIsValid)
		{
			bool flag = false;
			Vector3 vector = 2f * Vector3.one;
			int count = m_ValidMembers.Count;
			for (int i = 0; i < count; i++)
			{
				BoundingSphere boundingSphere = WeightedMemberBoundsForValidMember(ref m_Targets[m_ValidMembers[i]], m_AveragePos, m_MaxWeight);
				boundingSphere.position = result.MultiplyPoint3x4(boundingSphere.position);
				if (flag)
				{
					result2.Encapsulate(new Bounds(boundingSphere.position, boundingSphere.radius * vector));
				}
				else
				{
					result2 = new Bounds(boundingSphere.position, boundingSphere.radius * vector);
				}
				flag = true;
			}
		}
		return result2;
	}

	private bool IndexIsValid(int index)
	{
		if (index >= 0 && m_Targets != null && index < m_Targets.Length)
		{
			return CachedCountIsValid;
		}
		return false;
	}

	private static BoundingSphere WeightedMemberBoundsForValidMember(ref Target t, Vector3 avgPos, float maxWeight)
	{
		Vector3 b = ((t.target == null) ? avgPos : TargetPositionCache.GetTargetPosition(t.target));
		float num = Mathf.Max(0f, t.weight);
		num = ((!(maxWeight > 0.0001f) || !(num < maxWeight)) ? 1f : (num / maxWeight));
		return new BoundingSphere(Vector3.Lerp(avgPos, b, num), t.radius * num);
	}

	public void DoUpdate()
	{
		m_LastUpdateFrame = Time.frameCount;
		UpdateMemberValidity();
		m_AveragePos = CalculateAveragePosition();
		BoundingBox = CalculateBoundingBox();
		m_BoundingSphere = CalculateBoundingSphere();
		switch (m_PositionMode)
		{
		case PositionMode.GroupCenter:
			base.transform.position = Sphere.position;
			break;
		case PositionMode.GroupAverage:
			base.transform.position = m_AveragePos;
			break;
		}
		RotationMode rotationMode = m_RotationMode;
		if (rotationMode != RotationMode.Manual && rotationMode == RotationMode.GroupAverage)
		{
			base.transform.rotation = CalculateAverageOrientation();
		}
	}

	private void UpdateMemberValidity()
	{
		int num = ((m_Targets != null) ? m_Targets.Length : 0);
		m_ValidMembers.Clear();
		m_ValidMembers.Capacity = Mathf.Max(m_ValidMembers.Capacity, num);
		m_MemberValidity.Clear();
		m_MemberValidity.Capacity = Mathf.Max(m_MemberValidity.Capacity, num);
		m_WeightSum = (m_MaxWeight = 0f);
		for (int i = 0; i < num; i++)
		{
			m_MemberValidity.Add(m_Targets[i].target != null && m_Targets[i].weight > 0.0001f && m_Targets[i].target.gameObject.activeInHierarchy);
			if (m_MemberValidity[i])
			{
				m_ValidMembers.Add(i);
				m_MaxWeight = Mathf.Max(m_MaxWeight, m_Targets[i].weight);
				m_WeightSum += m_Targets[i].weight;
			}
		}
	}

	private Vector3 CalculateAveragePosition()
	{
		if (m_WeightSum < 0.0001f)
		{
			return base.transform.position;
		}
		Vector3 zero = Vector3.zero;
		int count = m_ValidMembers.Count;
		for (int i = 0; i < count; i++)
		{
			int num = m_ValidMembers[i];
			float weight = m_Targets[num].weight;
			zero += TargetPositionCache.GetTargetPosition(m_Targets[num].target) * weight;
		}
		return zero / m_WeightSum;
	}

	private Bounds CalculateBoundingBox()
	{
		if (m_MaxWeight < 0.0001f)
		{
			return BoundingBox;
		}
		Bounds result = new Bounds(m_AveragePos, Vector3.zero);
		int count = m_ValidMembers.Count;
		for (int i = 0; i < count; i++)
		{
			BoundingSphere boundingSphere = WeightedMemberBoundsForValidMember(ref m_Targets[m_ValidMembers[i]], m_AveragePos, m_MaxWeight);
			result.Encapsulate(new Bounds(boundingSphere.position, boundingSphere.radius * 2f * Vector3.one));
		}
		return result;
	}

	private BoundingSphere CalculateBoundingSphere()
	{
		int count = m_ValidMembers.Count;
		if (count == 0 || m_MaxWeight < 0.0001f)
		{
			return m_BoundingSphere;
		}
		BoundingSphere result = WeightedMemberBoundsForValidMember(ref m_Targets[m_ValidMembers[0]], m_AveragePos, m_MaxWeight);
		for (int i = 1; i < count; i++)
		{
			BoundingSphere boundingSphere = WeightedMemberBoundsForValidMember(ref m_Targets[m_ValidMembers[i]], m_AveragePos, m_MaxWeight);
			float num = (boundingSphere.position - result.position).magnitude + boundingSphere.radius;
			if (num > result.radius)
			{
				result.radius = (result.radius + num) * 0.5f;
				result.position = (result.radius * result.position + (num - result.radius) * boundingSphere.position) / num;
			}
		}
		return result;
	}

	private Quaternion CalculateAverageOrientation()
	{
		if (m_WeightSum > 0.001f)
		{
			Vector3 zero = Vector3.zero;
			Vector3 zero2 = Vector3.zero;
			int count = m_ValidMembers.Count;
			for (int i = 0; i < count; i++)
			{
				int num = m_ValidMembers[i];
				float num2 = m_Targets[num].weight / m_WeightSum;
				Quaternion targetRotation = TargetPositionCache.GetTargetRotation(m_Targets[num].target);
				zero += targetRotation * Vector3.forward * num2;
				zero2 += targetRotation * Vector3.up * num2;
			}
			if (zero.sqrMagnitude > 0.0001f && zero2.sqrMagnitude > 0.0001f)
			{
				return Quaternion.LookRotation(zero, zero2);
			}
		}
		return base.transform.rotation;
	}

	private void FixedUpdate()
	{
		if (m_UpdateMethod == UpdateMethod.FixedUpdate)
		{
			DoUpdate();
		}
	}

	private void Update()
	{
		if (!Application.isPlaying || m_UpdateMethod == UpdateMethod.Update)
		{
			DoUpdate();
		}
	}

	private void LateUpdate()
	{
		if (m_UpdateMethod == UpdateMethod.LateUpdate)
		{
			DoUpdate();
		}
	}

	public void GetViewSpaceAngularBounds(Matrix4x4 observer, out Vector2 minAngles, out Vector2 maxAngles, out Vector2 zRange)
	{
		if (m_LastUpdateFrame != Time.frameCount)
		{
			DoUpdate();
		}
		Matrix4x4 result = observer;
		if (!Matrix4x4.Inverse3DAffine(observer, ref result))
		{
			result = observer.inverse;
		}
		float radius = m_BoundingSphere.radius;
		Bounds bounds = new Bounds
		{
			center = result.MultiplyPoint3x4(m_AveragePos),
			extents = new Vector3(radius, radius, radius)
		};
		zRange = new Vector2(bounds.center.z - radius, bounds.center.z + radius);
		if (CachedCountIsValid)
		{
			bool flag = false;
			int count = m_ValidMembers.Count;
			for (int i = 0; i < count; i++)
			{
				BoundingSphere boundingSphere = WeightedMemberBoundsForValidMember(ref m_Targets[m_ValidMembers[i]], m_AveragePos, m_MaxWeight);
				Vector3 vector = result.MultiplyPoint3x4(boundingSphere.position);
				if (!(vector.z < 0.0001f))
				{
					float num = boundingSphere.radius / vector.z;
					Vector3 vector2 = new Vector3(num, num, 0f);
					Vector3 vector3 = vector / vector.z;
					if (!flag)
					{
						bounds.center = vector3;
						bounds.extents = vector2;
						zRange = new Vector2(vector.z, vector.z);
						flag = true;
					}
					else
					{
						bounds.Encapsulate(vector3 + vector2);
						bounds.Encapsulate(vector3 - vector2);
						zRange.x = Mathf.Min(zRange.x, vector.z);
						zRange.y = Mathf.Max(zRange.y, vector.z);
					}
				}
			}
		}
		Vector3 min = bounds.min;
		Vector3 max = bounds.max;
		minAngles = new Vector2(Vector3.SignedAngle(Vector3.forward, new Vector3(0f, min.y, 1f), Vector3.left), Vector3.SignedAngle(Vector3.forward, new Vector3(min.x, 0f, 1f), Vector3.up));
		maxAngles = new Vector2(Vector3.SignedAngle(Vector3.forward, new Vector3(0f, max.y, 1f), Vector3.left), Vector3.SignedAngle(Vector3.forward, new Vector3(max.x, 0f, 1f), Vector3.up));
	}
}
