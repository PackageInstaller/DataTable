using System;
using UnityEngine;

namespace Cinemachine;

[AddComponentMenu("Cinemachine/CinemachineTargetGroup")]
[SaveDuringPlay]
[ExecuteAlways]
[DisallowMultipleComponent]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.8/manual/CinemachineTargetGroup.html")]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
public class CinemachineTargetGroup : MonoBehaviour, ICinemachineTargetGroup
{
	[Serializable]
	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public struct Target
	{
		[Tooltip("The target objects.  This object's position and orientation will contribute to the group's average position and orientation, in accordance with its weight")]
		public Transform target;

		public CameraFollowTargertType cameraFollowTargertType;

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

	[Tooltip("The target objects, together with their weights and radii, that will contribute to the group's average position, orientation, and size.")]
	[NoSaveDuringPlay]
	public Target[] m_Targets = new Target[0];

	private float m_MaxWeight;

	private Vector3 m_AveragePos;

	private BoundingSphere m_BoundingSphere;

	public Transform Transform => transform;

	public Bounds BoundingBox { get; private set; }

	public BoundingSphere Sphere => m_BoundingSphere;

	public bool IsEmpty
	{
		get
		{
			for (int i = 0; i < m_Targets.Length; i++)
			{
				if (m_Targets[i].target != null && m_Targets[i].weight > 0.0001f)
				{
					return false;
				}
			}
			return true;
		}
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
		if (index < 0 || index >= m_Targets.Length)
		{
			return Sphere;
		}
		return WeightedMemberBounds(m_Targets[index], m_AveragePos, m_MaxWeight);
	}

	public Bounds GetViewSpaceBoundingBox(Matrix4x4 observer)
	{
		Matrix4x4 inverse = observer.inverse;
		Bounds result = new Bounds(inverse.MultiplyPoint3x4(m_AveragePos), Vector3.zero);
		for (int i = 0; i < m_Targets.Length; i++)
		{
			BoundingSphere weightedBoundsForMember = GetWeightedBoundsForMember(i);
			weightedBoundsForMember.position = inverse.MultiplyPoint3x4(weightedBoundsForMember.position);
			result.Encapsulate(new Bounds(weightedBoundsForMember.position, weightedBoundsForMember.radius * 2f * Vector3.one));
		}
		return result;
	}

	private static BoundingSphere WeightedMemberBounds(Target t, Vector3 avgPos, float maxWeight)
	{
		float num = 0f;
		Vector3 b = avgPos;
		if (t.target != null)
		{
			b = TargetPositionCache.GetTargetPosition(t.target);
			num = Mathf.Max(0f, t.weight);
			num = ((!(maxWeight > 0.0001f) || !(num < maxWeight)) ? 1f : (num / maxWeight));
		}
		return new BoundingSphere(Vector3.Lerp(avgPos, b, num), t.radius * num);
	}

	public virtual void DoUpdate()
	{
		m_AveragePos = CalculateAveragePosition(out m_MaxWeight);
		BoundingBox = CalculateBoundingBox(m_AveragePos, m_MaxWeight);
		m_BoundingSphere = CalculateBoundingSphere(m_MaxWeight);
		switch (m_PositionMode)
		{
		case PositionMode.GroupCenter:
			transform.position = Sphere.position;
			break;
		case PositionMode.GroupAverage:
			transform.position = m_AveragePos;
			break;
		}
		RotationMode rotationMode = m_RotationMode;
		if (rotationMode != RotationMode.Manual && rotationMode == RotationMode.GroupAverage)
		{
			transform.rotation = CalculateAverageOrientation();
		}
	}

	private BoundingSphere CalculateBoundingSphere(float maxWeight)
	{
		BoundingSphere result = new BoundingSphere
		{
			position = transform.position
		};
		bool flag = false;
		for (int i = 0; i < m_Targets.Length; i++)
		{
			if (m_Targets[i].target == null || m_Targets[i].weight < 0.0001f)
			{
				continue;
			}
			BoundingSphere boundingSphere = WeightedMemberBounds(m_Targets[i], m_AveragePos, maxWeight);
			if (!flag)
			{
				flag = true;
				result = boundingSphere;
				continue;
			}
			float num = (boundingSphere.position - result.position).magnitude + boundingSphere.radius;
			if (num > result.radius)
			{
				result.radius = (result.radius + num) * 0.5f;
				result.position = (result.radius * result.position + (num - result.radius) * boundingSphere.position) / num;
			}
		}
		return result;
	}

	private Vector3 CalculateAveragePosition(out float maxWeight)
	{
		Vector3 zero = Vector3.zero;
		float num = 0f;
		maxWeight = 0f;
		for (int i = 0; i < m_Targets.Length; i++)
		{
			if (m_Targets[i].target != null)
			{
				num += m_Targets[i].weight;
				zero += TargetPositionCache.GetTargetPosition(m_Targets[i].target) * m_Targets[i].weight;
				maxWeight = Mathf.Max(maxWeight, m_Targets[i].weight);
			}
		}
		if (num > 0.0001f)
		{
			return zero / num;
		}
		return transform.position;
	}

	private Quaternion CalculateAverageOrientation()
	{
		if (m_MaxWeight <= 0.0001f)
		{
			return transform.rotation;
		}
		float num = 0f;
		Quaternion identity = Quaternion.identity;
		for (int i = 0; i < m_Targets.Length; i++)
		{
			if (m_Targets[i].target != null)
			{
				float num2 = m_Targets[i].weight / m_MaxWeight;
				Quaternion targetRotation = TargetPositionCache.GetTargetRotation(m_Targets[i].target);
				identity *= Quaternion.Slerp(Quaternion.identity, targetRotation, num2);
				num += num2;
			}
		}
		return Quaternion.Slerp(Quaternion.identity, identity, 1f / num);
	}

	private Bounds CalculateBoundingBox(Vector3 avgPos, float maxWeight)
	{
		Bounds result = new Bounds(avgPos, Vector3.zero);
		if (maxWeight > 0.0001f)
		{
			for (int i = 0; i < m_Targets.Length; i++)
			{
				if (m_Targets[i].target != null)
				{
					BoundingSphere boundingSphere = WeightedMemberBounds(m_Targets[i], m_AveragePos, maxWeight);
					result.Encapsulate(new Bounds(boundingSphere.position, boundingSphere.radius * 2f * Vector3.one));
				}
			}
		}
		return result;
	}

	private void OnValidate()
	{
		for (int i = 0; i < m_Targets.Length; i++)
		{
			m_Targets[i].weight = Mathf.Max(0f, m_Targets[i].weight);
			m_Targets[i].radius = Mathf.Max(0f, m_Targets[i].radius);
		}
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
		zRange = Vector2.zero;
		Matrix4x4 inverse = observer.inverse;
		Bounds bounds = default;
		bool flag = false;
		for (int i = 0; i < m_Targets.Length; i++)
		{
			BoundingSphere weightedBoundsForMember = GetWeightedBoundsForMember(i);
			Vector3 vector = inverse.MultiplyPoint3x4(weightedBoundsForMember.position);
			if (!(vector.z < 0.0001f))
			{
				float num = weightedBoundsForMember.radius / vector.z;
				Vector3 vector2 = new Vector3(num, num, 0f);
				Vector3 vector3 = vector / vector.z;
				if (!flag)
				{
					bounds.center = vector3;
					bounds.extents = vector2;
					zRange = new Vector2(vector.z - weightedBoundsForMember.radius, vector.z + weightedBoundsForMember.radius);
					flag = true;
				}
				else
				{
					bounds.Encapsulate(vector3 + vector2);
					bounds.Encapsulate(vector3 - vector2);
					zRange.x = Mathf.Min(zRange.x, vector.z - weightedBoundsForMember.radius);
					zRange.y = Mathf.Max(zRange.y, vector.z + weightedBoundsForMember.radius);
				}
			}
		}
		Vector3 min = bounds.min;
		Vector3 max = bounds.max;
		minAngles = new Vector2(Vector3.SignedAngle(Vector3.forward, new Vector3(0f, min.y, 1f), Vector3.left), Vector3.SignedAngle(Vector3.forward, new Vector3(min.x, 0f, 1f), Vector3.up));
		maxAngles = new Vector2(Vector3.SignedAngle(Vector3.forward, new Vector3(0f, max.y, 1f), Vector3.left), Vector3.SignedAngle(Vector3.forward, new Vector3(max.x, 0f, 1f), Vector3.up));
	}
}
