using System;
using System.Collections.Generic;
using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

[AddComponentMenu("")]
[SaveDuringPlay]
[ExecuteAlways]
[DisallowMultipleComponent]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineConfiner.html")]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
public class CinemachineConfiner : CinemachineExtension
{
	public enum Mode
	{
		Confine2D,
		Confine3D
	}

	private class VcamExtraState
	{
		public Vector3 m_previousDisplacement;

		public float confinerDisplacement;
	}

	[Tooltip("The confiner can operate using a 2D bounding shape or a 3D bounding volume")]
	public Mode m_ConfineMode;

	[Tooltip("The volume within which the camera is to be contained")]
	public Collider m_BoundingVolume;

	[Tooltip("The 2D shape within which the camera is to be contained")]
	public Collider2D m_BoundingShape2D;

	private Collider2D m_BoundingShape2DCache;

	[Tooltip("If camera is orthographic, screen edges will be confined to the volume.  If not checked, then only the camera center will be confined")]
	public bool m_ConfineScreenEdges = true;

	[Tooltip("How gradually to return the camera to the bounding volume if it goes beyond the borders.  Higher numbers are more gradual.")]
	[Range(0f, 10f)]
	public float m_Damping;

	private List<List<Vector2>> m_pathCache;

	private int m_pathTotalPointCount;

	public bool IsValid
	{
		get
		{
			if (m_ConfineMode != Mode.Confine3D || !((UnityEngine.Object)(object)m_BoundingVolume != null) || !m_BoundingVolume.enabled || !((Component)(object)m_BoundingVolume).gameObject.activeInHierarchy)
			{
				if (m_ConfineMode == Mode.Confine2D && (UnityEngine.Object)(object)m_BoundingShape2D != null && ((Behaviour)(object)m_BoundingShape2D).enabled)
				{
					return ((Component)(object)m_BoundingShape2D).gameObject.activeInHierarchy;
				}
				return false;
			}
			return true;
		}
	}

	public bool CameraWasDisplaced(CinemachineVirtualCameraBase vcam)
	{
		return GetCameraDisplacementDistance(vcam) > 0f;
	}

	public float GetCameraDisplacementDistance(CinemachineVirtualCameraBase vcam)
	{
		return GetExtraState<VcamExtraState>(vcam).confinerDisplacement;
	}

	private void OnValidate()
	{
		m_Damping = Mathf.Max(0f, m_Damping);
	}

	protected override void ConnectToVcam(bool connect)
	{
		base.ConnectToVcam(connect);
	}

	public override float GetMaxDampTime()
	{
		return m_Damping;
	}

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		if (IsValid && stage == CinemachineCore.Stage.Body)
		{
			VcamExtraState extraState = GetExtraState<VcamExtraState>(vcam);
			Vector3 vector = ((!m_ConfineScreenEdges || !state.Lens.Orthographic) ? ConfinePoint(state.CorrectedPosition) : ConfineScreenEdges(ref state));
			if (m_Damping > 0f && deltaTime >= 0f && base.VirtualCamera.PreviousStateIsValid)
			{
				Vector3 initial = vector - extraState.m_previousDisplacement;
				initial = Damper.Damp(initial, m_Damping, deltaTime);
				vector = extraState.m_previousDisplacement + initial;
			}
			extraState.m_previousDisplacement = vector;
			state.PositionCorrection += vector;
			extraState.confinerDisplacement = vector.magnitude;
		}
	}

	public void InvalidatePathCache()
	{
		m_pathCache = null;
		m_BoundingShape2DCache = null;
	}

	private bool ValidatePathCache()
	{
		if ((UnityEngine.Object)(object)m_BoundingShape2DCache != (UnityEngine.Object)(object)m_BoundingShape2D)
		{
			InvalidatePathCache();
			m_BoundingShape2DCache = m_BoundingShape2D;
		}
		Type type = (((UnityEngine.Object)(object)m_BoundingShape2D == null) ? null : ((object)m_BoundingShape2D).GetType());
		if (type == typeof(PolygonCollider2D))
		{
			Collider2D boundingShape2D = m_BoundingShape2D;
			PolygonCollider2D val = (PolygonCollider2D)(object)((boundingShape2D is PolygonCollider2D) ? boundingShape2D : null);
			if (m_pathCache == null || m_pathCache.Count != val.pathCount || m_pathTotalPointCount != val.GetTotalPointCount())
			{
				m_pathCache = new List<List<Vector2>>();
				for (int i = 0; i < val.pathCount; i++)
				{
					Vector2[] path = val.GetPath(i);
					List<Vector2> list = new List<Vector2>();
					for (int j = 0; j < path.Length; j++)
					{
						list.Add(path[j]);
					}
					m_pathCache.Add(list);
				}
				m_pathTotalPointCount = val.GetTotalPointCount();
			}
			return true;
		}
		if (type == typeof(CompositeCollider2D))
		{
			Collider2D boundingShape2D2 = m_BoundingShape2D;
			CompositeCollider2D val2 = (CompositeCollider2D)(object)((boundingShape2D2 is CompositeCollider2D) ? boundingShape2D2 : null);
			if (m_pathCache == null || m_pathCache.Count != val2.pathCount || m_pathTotalPointCount != val2.pointCount)
			{
				m_pathCache = new List<List<Vector2>>();
				Vector2[] array = new Vector2[val2.pointCount];
				Vector3 lossyScale = ((Component)(object)m_BoundingShape2D).transform.lossyScale;
				Vector2 vector = new Vector2(1f / lossyScale.x, 1f / lossyScale.y);
				for (int k = 0; k < val2.pathCount; k++)
				{
					int path2 = val2.GetPath(k, array);
					List<Vector2> list2 = new List<Vector2>();
					for (int l = 0; l < path2; l++)
					{
						list2.Add(array[l] * vector);
					}
					m_pathCache.Add(list2);
				}
				m_pathTotalPointCount = val2.pointCount;
			}
			return true;
		}
		InvalidatePathCache();
		return false;
	}

	private Vector3 ConfinePoint(Vector3 camPos)
	{
		if (m_ConfineMode == Mode.Confine3D)
		{
			return m_BoundingVolume.ClosestPoint(camPos) - camPos;
		}
		Vector2 vector = camPos;
		Vector2 vector2 = vector;
		if (m_BoundingShape2D.OverlapPoint((Vector2)camPos))
		{
			return Vector3.zero;
		}
		if (!ValidatePathCache())
		{
			return Vector3.zero;
		}
		float num = float.MaxValue;
		for (int i = 0; i < m_pathCache.Count; i++)
		{
			int count = m_pathCache[i].Count;
			if (count <= 0)
			{
				continue;
			}
			Vector2 vector3 = ((Component)(object)m_BoundingShape2D).transform.TransformPoint(m_pathCache[i][count - 1] + m_BoundingShape2D.offset);
			for (int j = 0; j < count; j++)
			{
				Vector2 vector4 = ((Component)(object)m_BoundingShape2D).transform.TransformPoint(m_pathCache[i][j] + m_BoundingShape2D.offset);
				Vector2 vector5 = Vector2.Lerp(vector3, vector4, vector.ClosestPointOnSegment(vector3, vector4));
				float num2 = Vector2.SqrMagnitude(vector - vector5);
				if (num2 < num)
				{
					num = num2;
					vector2 = vector5;
				}
				vector3 = vector4;
			}
		}
		return vector2 - vector;
	}

	private Vector3 ConfineScreenEdges(ref CameraState state)
	{
		Quaternion correctedOrientation = state.CorrectedOrientation;
		float orthographicSize = state.Lens.OrthographicSize;
		float num = orthographicSize * state.Lens.Aspect;
		Vector3 vector = correctedOrientation * Vector3.right * num;
		Vector3 vector2 = correctedOrientation * Vector3.up * orthographicSize;
		Vector3 zero = Vector3.zero;
		Vector3 correctedPosition = state.CorrectedPosition;
		Vector3 vector3 = Vector3.zero;
		for (int i = 0; i < 12; i++)
		{
			Vector3 vector4 = ConfinePoint(correctedPosition - vector2 - vector);
			if (vector4.AlmostZero())
			{
				vector4 = ConfinePoint(correctedPosition + vector2 + vector);
			}
			if (vector4.AlmostZero())
			{
				vector4 = ConfinePoint(correctedPosition - vector2 + vector);
			}
			if (vector4.AlmostZero())
			{
				vector4 = ConfinePoint(correctedPosition + vector2 - vector);
			}
			if (vector4.AlmostZero())
			{
				break;
			}
			if ((vector4 + vector3).AlmostZero())
			{
				zero += vector4 * 0.5f;
				break;
			}
			zero += vector4;
			correctedPosition += vector4;
			vector3 = vector4;
		}
		return zero;
	}
}
