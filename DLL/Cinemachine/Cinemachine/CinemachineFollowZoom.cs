using System;
using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[AddComponentMenu("")]
[SaveDuringPlay]
[ExecuteAlways]
[DisallowMultipleComponent]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineFollowZoom.html")]
public class CinemachineFollowZoom : CinemachineExtension
{
	private class VcamExtraState
	{
		public float m_previousFrameZoom;
	}

	[Tooltip("The shot width to maintain, in world units, at target distance.")]
	public float m_Width = 2f;

	[Range(0f, 20f)]
	[Tooltip("Increase this value to soften the aggressiveness of the follow-zoom.  Small numbers are more responsive, larger numbers give a more heavy slowly responding camera.")]
	public float m_Damping = 1f;

	[Range(1f, 179f)]
	[Tooltip("Lower limit for the FOV that this behaviour will generate.")]
	public float m_MinFOV = 3f;

	[Range(1f, 179f)]
	[Tooltip("Upper limit for the FOV that this behaviour will generate.")]
	public float m_MaxFOV = 60f;

	private void OnValidate()
	{
		m_Width = Mathf.Max(0f, m_Width);
		m_MaxFOV = Mathf.Clamp(m_MaxFOV, 1f, 179f);
		m_MinFOV = Mathf.Clamp(m_MinFOV, 1f, m_MaxFOV);
	}

	public override float GetMaxDampTime()
	{
		return m_Damping;
	}

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		VcamExtraState extraState = GetExtraState<VcamExtraState>(vcam);
		if (deltaTime < 0f || !base.VirtualCamera.PreviousStateIsValid)
		{
			extraState.m_previousFrameZoom = state.Lens.FieldOfView;
		}
		if (stage != CinemachineCore.Stage.Body)
		{
			return;
		}
		float value = Mathf.Max(m_Width, 0f);
		float value2 = 179f;
		float num = Vector3.Distance(state.CorrectedPosition, state.ReferenceLookAt);
		if (num > 0.0001f)
		{
			float min = num * 2f * Mathf.Tan(m_MinFOV * (MathF.PI / 180f) / 2f);
			float max = num * 2f * Mathf.Tan(m_MaxFOV * (MathF.PI / 180f) / 2f);
			value = Mathf.Clamp(value, min, max);
			if (deltaTime >= 0f && m_Damping > 0f && base.VirtualCamera.PreviousStateIsValid)
			{
				float num2 = num * 2f * Mathf.Tan(extraState.m_previousFrameZoom * (MathF.PI / 180f) / 2f);
				float initial = value - num2;
				initial = base.VirtualCamera.DetachedLookAtTargetDamp(initial, m_Damping, deltaTime);
				value = num2 + initial;
			}
			value2 = 2f * Mathf.Atan(value / (2f * num)) * 57.29578f;
		}
		LensSettings lens = state.Lens;
		lens.FieldOfView = (extraState.m_previousFrameZoom = Mathf.Clamp(value2, m_MinFOV, m_MaxFOV));
		state.Lens = lens;
	}
}
