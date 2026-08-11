using System;
using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

[AddComponentMenu("")]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineImpulseListener.html")]
[SaveDuringPlay]
[ExecuteAlways]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
public class CinemachineImpulseListener : CinemachineExtension
{
	[Serializable]
	public struct ImpulseReaction
	{
		[NoiseSettingsProperty]
		[Tooltip("Secondary shake that will be triggered by the primary impulse.")]
		public NoiseSettings m_SecondaryNoise;

		[Tooltip("Gain to apply to the amplitudes defined in the signal source.  1 is normal.  Setting this to 0 completely mutes the signal.")]
		public float m_AmplitudeGain;

		[Tooltip("Scale factor to apply to the time axis.  1 is normal.  Larger magnitudes will make the signal progress more rapidly.")]
		public float m_FrequencyGain;

		[Tooltip("How long the secondary reaction lasts.")]
		public float m_Duration;

		private float m_CurrentAmount;

		private float m_CurrentTime;

		private float m_CurrentDamping;

		private bool m_Initialized;

		[HideInInspector]
		[SerializeField]
		private Vector3 m_NoiseOffsets;

		public void ReSeed()
		{
			m_NoiseOffsets = new Vector3(UnityEngine.Random.Range(-1000f, 1000f), UnityEngine.Random.Range(-1000f, 1000f), UnityEngine.Random.Range(-1000f, 1000f));
		}

		public bool GetReaction(float deltaTime, Vector3 impulsePos, out Vector3 pos, out Quaternion rot)
		{
			if (!m_Initialized)
			{
				m_Initialized = true;
				m_CurrentAmount = 0f;
				m_CurrentDamping = 0f;
				m_CurrentTime = CinemachineCore.CurrentTime * m_FrequencyGain;
				if (m_NoiseOffsets == Vector3.zero)
				{
					ReSeed();
				}
			}
			pos = Vector3.zero;
			rot = Quaternion.identity;
			float sqrMagnitude = impulsePos.sqrMagnitude;
			if (m_SecondaryNoise == null || (sqrMagnitude < 0.001f && m_CurrentAmount < 0.0001f))
			{
				return false;
			}
			if (TargetPositionCache.CacheMode == TargetPositionCache.Mode.Playback && TargetPositionCache.HasCurrentTime)
			{
				m_CurrentTime = TargetPositionCache.CurrentTime * m_FrequencyGain;
			}
			else
			{
				m_CurrentTime += deltaTime * m_FrequencyGain;
			}
			m_CurrentAmount = Mathf.Max(m_CurrentAmount, Mathf.Sqrt(sqrMagnitude));
			m_CurrentDamping = Mathf.Max(m_CurrentDamping, Mathf.Max(1f, Mathf.Sqrt(m_CurrentAmount)) * m_Duration);
			float num = m_CurrentAmount * m_AmplitudeGain;
			pos = NoiseSettings.GetCombinedFilterResults(m_SecondaryNoise.PositionNoise, m_CurrentTime, m_NoiseOffsets) * num;
			rot = Quaternion.Euler(NoiseSettings.GetCombinedFilterResults(m_SecondaryNoise.OrientationNoise, m_CurrentTime, m_NoiseOffsets) * num);
			m_CurrentAmount -= Damper.Damp(m_CurrentAmount, m_CurrentDamping, deltaTime);
			m_CurrentDamping -= Damper.Damp(m_CurrentDamping, m_CurrentDamping, deltaTime);
			return true;
		}
	}

	[Tooltip("When to apply the impulse reaction.  Default is after the Noise stage.  Modify this if necessary to influence the ordering of extension effects")]
	public CinemachineCore.Stage m_ApplyAfter = CinemachineCore.Stage.Aim;

	[Tooltip("Impulse events on channels not included in the mask will be ignored.")]
	[CinemachineImpulseChannelProperty]
	public int m_ChannelMask;

	[Tooltip("Gain to apply to the Impulse signal.  1 is normal strength.  Setting this to 0 completely mutes the signal.")]
	public float m_Gain;

	[Tooltip("Enable this to perform distance calculation in 2D (ignore Z)")]
	public bool m_Use2DDistance;

	[Tooltip("Enable this to process all impulse signals in camera space")]
	public bool m_UseCameraSpace;

	[Tooltip("This controls the secondary reaction of the listener to the incoming impulse.  The impulse might be for example a sharp shock, and the secondary reaction could be a vibration whose amplitude and duration is controlled by the size of the original impulse.  This allows different listeners to respond in different ways to the same impulse signal.")]
	public ImpulseReaction m_ReactionSettings;

	private void Reset()
	{
		m_ApplyAfter = CinemachineCore.Stage.Noise;
		m_ChannelMask = 1;
		m_Gain = 1f;
		m_Use2DDistance = false;
		m_UseCameraSpace = true;
		m_ReactionSettings = new ImpulseReaction
		{
			m_AmplitudeGain = 1f,
			m_FrequencyGain = 1f,
			m_Duration = 1f
		};
	}

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		if (stage != m_ApplyAfter || !(deltaTime >= 0f))
		{
			return;
		}
		bool impulseAt = CinemachineImpulseManager.Instance.GetImpulseAt(state.FinalPosition, m_Use2DDistance, m_ChannelMask, out var pos, out var rot);
		bool reaction = m_ReactionSettings.GetReaction(deltaTime, pos, out var pos2, out var rot2);
		if (impulseAt)
		{
			rot = Quaternion.SlerpUnclamped(Quaternion.identity, rot, m_Gain);
			pos *= m_Gain;
		}
		if (reaction)
		{
			pos += pos2;
			rot *= rot2;
		}
		if (impulseAt | reaction)
		{
			if (m_UseCameraSpace)
			{
				pos = state.RawOrientation * pos;
			}
			state.PositionCorrection += pos;
			state.OrientationCorrection *= rot;
		}
	}
}
