using System;
using System.Collections.Generic;
using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineConfiner2D.html")]
[AddComponentMenu("")]
[DisallowMultipleComponent]
[ExecuteAlways]
[SaveDuringPlay]
public class CinemachineConfiner2D : CinemachineExtension
{
	private class VcamExtraState
	{
		public Vector3 m_PreviousDisplacement;

		public Vector3 m_DampedDisplacement;

		public ConfinerOven.BakedSolution m_BakedSolution;

		public CinemachineVirtualCameraBase m_vcam;
	}

	private struct ShapeCache
	{
		public ConfinerOven m_confinerOven;

		public List<List<Vector2>> m_OriginalPath;

		public Matrix4x4 m_DeltaWorldToBaked;

		public Matrix4x4 m_DeltaBakedToWorld;

		private float m_aspectRatio;

		private float m_maxWindowSize;

		internal float m_maxComputationTimePerFrameInSeconds;

		private Matrix4x4 m_bakedToWorld;

		private Collider2D m_boundingShape2D;

		public void Invalidate()
		{
			m_aspectRatio = 0f;
			m_maxWindowSize = -1f;
			m_DeltaBakedToWorld = (m_DeltaWorldToBaked = Matrix4x4.identity);
			m_boundingShape2D = null;
			m_OriginalPath = null;
			m_confinerOven = null;
		}

		public bool ValidateCache(Collider2D boundingShape2D, float maxWindowSize, float aspectRatio, out bool confinerStateChanged)
		{
			confinerStateChanged = false;
			if (IsValid(in boundingShape2D, in aspectRatio, in maxWindowSize))
			{
				if (m_confinerOven.State == ConfinerOven.BakingState.BAKING)
				{
					m_confinerOven.BakeConfiner(m_maxComputationTimePerFrameInSeconds);
					confinerStateChanged = m_confinerOven.State != ConfinerOven.BakingState.BAKING;
				}
				CalculateDeltaTransformationMatrix();
				if (((Vector2)m_DeltaWorldToBaked.lossyScale).IsUniform())
				{
					return true;
				}
			}
			Invalidate();
			confinerStateChanged = true;
			Type type = (((UnityEngine.Object)(object)boundingShape2D == null) ? null : ((object)boundingShape2D).GetType());
			if (type == typeof(PolygonCollider2D))
			{
				PolygonCollider2D val = (PolygonCollider2D)(object)((boundingShape2D is PolygonCollider2D) ? boundingShape2D : null);
				m_OriginalPath = new List<List<Vector2>>();
				m_bakedToWorld = ((Component)(object)boundingShape2D).transform.localToWorldMatrix;
				for (int i = 0; i < val.pathCount; i++)
				{
					Vector2[] path = val.GetPath(i);
					List<Vector2> list = new List<Vector2>();
					for (int j = 0; j < path.Length; j++)
					{
						list.Add(m_bakedToWorld.MultiplyPoint3x4(path[j]));
					}
					m_OriginalPath.Add(list);
				}
			}
			else
			{
				if (!(type == typeof(CompositeCollider2D)))
				{
					return false;
				}
				CompositeCollider2D val2 = (CompositeCollider2D)(object)((boundingShape2D is CompositeCollider2D) ? boundingShape2D : null);
				m_OriginalPath = new List<List<Vector2>>();
				m_bakedToWorld = ((Component)(object)boundingShape2D).transform.localToWorldMatrix;
				Vector2[] array = new Vector2[val2.pointCount];
				for (int k = 0; k < val2.pathCount; k++)
				{
					int path2 = val2.GetPath(k, array);
					List<Vector2> list2 = new List<Vector2>();
					for (int l = 0; l < path2; l++)
					{
						list2.Add(m_bakedToWorld.MultiplyPoint3x4(array[l]));
					}
					m_OriginalPath.Add(list2);
				}
			}
			m_confinerOven = new ConfinerOven(in m_OriginalPath, in aspectRatio, maxWindowSize);
			m_aspectRatio = aspectRatio;
			m_boundingShape2D = boundingShape2D;
			m_maxWindowSize = maxWindowSize;
			CalculateDeltaTransformationMatrix();
			return true;
		}

		private bool IsValid(in Collider2D boundingShape2D, in float aspectRatio, in float maxOrthoSize)
		{
			if ((UnityEngine.Object)(object)boundingShape2D != null && (UnityEngine.Object)(object)m_boundingShape2D != null && (UnityEngine.Object)(object)m_boundingShape2D == (UnityEngine.Object)(object)boundingShape2D && m_OriginalPath != null && m_confinerOven != null && Mathf.Abs(m_aspectRatio - aspectRatio) < 0.0001f)
			{
				return Mathf.Abs(m_maxWindowSize - maxOrthoSize) < 0.0001f;
			}
			return false;
		}

		private void CalculateDeltaTransformationMatrix()
		{
			Matrix4x4 matrix4x = Matrix4x4.Translate(-m_boundingShape2D.offset) * ((Component)(object)m_boundingShape2D).transform.worldToLocalMatrix;
			m_DeltaWorldToBaked = m_bakedToWorld * matrix4x;
			m_DeltaBakedToWorld = m_DeltaWorldToBaked.inverse;
		}
	}

	[Tooltip("The 2D shape within which the camera is to be contained.  Can be a 2D polygon or 2D composite collider.")]
	public Collider2D m_BoundingShape2D;

	[Tooltip("Damping applied around corners to avoid jumps.  Higher numbers are more gradual.")]
	[Range(0f, 5f)]
	public float m_Damping;

	[Tooltip("To optimize computation and memory costs, set this to the largest view size that the camera is expected to have.  The confiner will not compute a polygon cache for frustum sizes larger than this.  This refers to the size in world units of the frustum at the confiner plane (for orthographic cameras, this is just the orthographic size).  If set to 0, then this parameter is ignored and a polygon cache will be calculated for all potential window sizes.")]
	public float m_MaxWindowSize;

	private float m_MaxComputationTimePerFrameInSeconds = 1f / 120f;

	private const float k_cornerAngleTreshold = 10f;

	private ShapeCache m_shapeCache;

	public void InvalidateCache()
	{
		m_shapeCache.Invalidate();
	}

	public bool ValidateCache(float cameraAspectRatio)
	{
		bool confinerStateChanged;
		return m_shapeCache.ValidateCache(m_BoundingShape2D, m_MaxWindowSize, cameraAspectRatio, out confinerStateChanged);
	}

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		if (stage != CinemachineCore.Stage.Body)
		{
			return;
		}
		float aspect = state.Lens.Aspect;
		if (!m_shapeCache.ValidateCache(m_BoundingShape2D, m_MaxWindowSize, aspect, out var confinerStateChanged))
		{
			return;
		}
		Vector3 correctedPosition = state.CorrectedPosition;
		Vector3 vector = m_shapeCache.m_DeltaWorldToBaked.MultiplyPoint3x4(correctedPosition);
		float frustumHeight = CalculateHalfFrustumHeight(in state, in vector.z) * m_shapeCache.m_DeltaWorldToBaked.lossyScale.x;
		VcamExtraState extraState = GetExtraState<VcamExtraState>(vcam);
		extraState.m_vcam = vcam;
		if (confinerStateChanged || extraState.m_BakedSolution == null || !extraState.m_BakedSolution.IsValid())
		{
			extraState.m_BakedSolution = m_shapeCache.m_confinerOven.GetBakedSolution(frustumHeight);
		}
		vector = extraState.m_BakedSolution.ConfinePoint((Vector2)vector);
		Vector3 vector2 = m_shapeCache.m_DeltaBakedToWorld.MultiplyPoint3x4(vector);
		Vector3 vector3 = state.CorrectedOrientation * Vector3.forward;
		vector2 -= vector3 * Vector3.Dot(vector3, vector2 - correctedPosition);
		Vector3 previousDisplacement = extraState.m_PreviousDisplacement;
		Vector3 vector4 = (extraState.m_PreviousDisplacement = vector2 - correctedPosition);
		if (!base.VirtualCamera.PreviousStateIsValid || deltaTime < 0f || m_Damping <= 0f)
		{
			extraState.m_DampedDisplacement = Vector3.zero;
		}
		else
		{
			if (previousDisplacement.sqrMagnitude > 0.01f && Vector2.Angle(previousDisplacement, vector4) > 10f)
			{
				extraState.m_DampedDisplacement += vector4 - previousDisplacement;
			}
			extraState.m_DampedDisplacement -= Damper.Damp(extraState.m_DampedDisplacement, m_Damping, deltaTime);
			vector4 -= extraState.m_DampedDisplacement;
		}
		state.PositionCorrection += vector4;
	}

	private float CalculateHalfFrustumHeight(in CameraState state, in float cameraPosLocalZ)
	{
		float f = ((!state.Lens.Orthographic) ? (cameraPosLocalZ * Mathf.Tan(state.Lens.FieldOfView * 0.5f * (MathF.PI / 180f))) : state.Lens.OrthographicSize);
		return Mathf.Abs(f);
	}

	private void OnValidate()
	{
		m_Damping = Mathf.Max(0f, m_Damping);
		m_shapeCache.m_maxComputationTimePerFrameInSeconds = m_MaxComputationTimePerFrameInSeconds;
	}

	private void Reset()
	{
		m_Damping = 0.5f;
		m_MaxWindowSize = -1f;
	}
}
