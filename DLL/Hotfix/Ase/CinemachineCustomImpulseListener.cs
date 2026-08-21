using System;
using Cinemachine;
using Cinemachine.Utility;
using UnityEngine;

namespace Ase;

[SaveDuringPlay]
[AddComponentMenu("")]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[ExecuteAlways]
public class CinemachineCustomImpulseListener : CinemachineExtension
{
	[Serializable]
	public struct ImpulseReaction
	{
		[Tooltip("Secondary shake that will be triggered by the primary impulse.")]
		[NoiseSettingsProperty]
		public NoiseSettings m_SecondaryNoise;

		[Tooltip("Gain to apply to the amplitudes defined in the signal source.  1 is normal.  Setting this to 0 completely mutes the signal.")]
		public float m_AmplitudeGain;

		[Tooltip("Scale factor to apply to the time axis.  1 is normal.  Larger magnitudes will make the signal progress more rapidly.")]
		public float m_FrequencyGain;

		[Tooltip("How long the secondary reaction lasts.")]
		public float m_Duration;

		public bool UseRandomNoise;

		private AnimationCurve amplitudeGainCurve;

		private AnimationCurve distanceAmplitudeCurve;

		private AnimationCurve frequencyGainCurve;

		private float m_CurrentAmount;

		private float m_CurrentTime;

		private float m_CurrentDamping;

		private bool m_Initialized;

		[SerializeField]
		[HideInInspector]
		private Vector3 m_NoiseOffsets;

		public float CurrentAmplitudeGain;

		public AnimationCurve DistanceAmplitudeCurve => distanceAmplitudeCurve;

		public void ReSeed()
		{
			if (UseRandomNoise)
			{
				m_NoiseOffsets = new Vector3(UnityEngine.Random.Range(-1000f, 1000f), UnityEngine.Random.Range(-1000f, 1000f), UnityEngine.Random.Range(-1000f, 1000f));
			}
			else
			{
				m_NoiseOffsets = Vector3.one;
			}
		}

		public void SetAnimationCurve(AnimationCurve amplitudeGainCurve, AnimationCurve distanceAmplitudeCurve, AnimationCurve frequencyGainCurve)
		{
			this.amplitudeGainCurve = amplitudeGainCurve;
			this.distanceAmplitudeCurve = distanceAmplitudeCurve;
			this.frequencyGainCurve = frequencyGainCurve;
		}

		public bool GetReaction(float deltaTime, Vector3 impulsePos, out Vector3 pos, out Quaternion rot, float impulseTimeRate, float distanceRate, float? blendAmplitudeValue)
		{
			if (!m_Initialized)
			{
				m_Initialized = true;
				m_CurrentAmount = 0f;
				m_CurrentDamping = 0f;
				if (UseRandomNoise)
				{
					m_CurrentTime = CinemachineCore.CurrentTime * m_FrequencyGain;
				}
				else
				{
					m_CurrentTime = 0f;
				}
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
			float num = m_FrequencyGain;
			if (frequencyGainCurve != null)
			{
				num = m_FrequencyGain * frequencyGainCurve.Evaluate(impulseTimeRate);
			}
			if (blendAmplitudeValue.HasValue)
			{
				CurrentAmplitudeGain = blendAmplitudeValue.Value;
			}
			else
			{
				CurrentAmplitudeGain = m_AmplitudeGain;
				if (amplitudeGainCurve != null)
				{
					CurrentAmplitudeGain = m_AmplitudeGain * amplitudeGainCurve.Evaluate(impulseTimeRate);
				}
				if (distanceAmplitudeCurve != null)
				{
					CurrentAmplitudeGain *= distanceAmplitudeCurve.Evaluate(distanceRate);
				}
			}
			m_CurrentTime += deltaTime * num;
			m_CurrentAmount = Mathf.Max(m_CurrentAmount, Mathf.Sqrt(sqrMagnitude));
			m_CurrentDamping = Mathf.Max(m_CurrentDamping, Mathf.Max(1f, Mathf.Sqrt(m_CurrentAmount)) * m_Duration);
			float num2 = m_CurrentAmount * CurrentAmplitudeGain;
			pos = NoiseSettings.GetCombinedFilterResults(m_SecondaryNoise.PositionNoise, m_CurrentTime, m_NoiseOffsets) * num2;
			rot = Quaternion.Euler(NoiseSettings.GetCombinedFilterResults(m_SecondaryNoise.OrientationNoise, m_CurrentTime, m_NoiseOffsets) * num2);
			m_CurrentAmount -= Damper.Damp(m_CurrentAmount, m_CurrentDamping, deltaTime);
			m_CurrentDamping -= Damper.Damp(m_CurrentDamping, m_CurrentDamping, deltaTime);
			return true;
		}
	}

	public float ImpulseTimer;

	[HideInInspector]
	public Transform FollowTrans;

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

	public float PriorityInit;

	public AnimationCurve PriorityCurve;

	public AnimationCurve PriorityDisCurve;

	public float DissipationDistance;

	public Vector3 SourcePos;

	public float BlendAmplitudeDuration;

	private float blendAmplitudeStartTime;

	private bool impulseEffect;

	public bool IgnoreImpuseEffect;

	public bool ImpulseEffect => impulseEffect;

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
		ImpulseTimer = 0f;
		PriorityInit = 0f;
		PriorityCurve = null;
		PriorityDisCurve = null;
		impulseEffect = false;
		DissipationDistance = 0f;
		blendAmplitudeStartTime = 0f;
		BlendAmplitudeDuration = 0f;
	}

	private float ImpulseTimeRate()
	{
		return 1f - ImpulseTimer / m_ReactionSettings.m_Duration;
	}

	public float PriorityTimeValue()
	{
		if (PriorityCurve == null)
		{
			return 1f;
		}
		float time = ImpulseTimeRate();
		return PriorityCurve.Evaluate(time);
	}

	private float DistanceRate()
	{
		if (FollowTrans == null)
		{
			return 1f;
		}
		return Vector3.Distance(FollowTrans.position, SourcePos) / DissipationDistance;
	}

	public float PriorityDisValue()
	{
		if (PriorityDisCurve == null)
		{
			return 1f;
		}
		float time = DistanceRate();
		return PriorityDisCurve.Evaluate(time);
	}

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		if (stage != m_ApplyAfter || !(deltaTime >= 0f))
		{
			return;
		}
		float impulseTimeRate = ImpulseTimeRate();
		float distanceRate = 0f;
		if (m_ReactionSettings.DistanceAmplitudeCurve != null)
		{
			distanceRate = DistanceRate();
		}
		float? blendAmplitudeValue = null;
		bool flag = CinemachineCustomImpulseManager.Instance.IsMaxPriorityListener(this);
		if (flag && CinemachineCustomImpulseManager.Instance.NeedBlendAmplitude)
		{
			float lastBlendAmplitudeValue = CinemachineCustomImpulseManager.Instance.LastBlendAmplitudeValue;
			if (BlendAmplitudeDuration > 0f && blendAmplitudeStartTime - ImpulseTimer < BlendAmplitudeDuration)
			{
				blendAmplitudeValue = lastBlendAmplitudeValue + (m_ReactionSettings.m_AmplitudeGain - lastBlendAmplitudeValue) * (blendAmplitudeStartTime - ImpulseTimer) / BlendAmplitudeDuration;
			}
		}
		bool impulseAt = CinemachineCustomImpulseManager.Instance.GetImpulseAt(FollowTrans?.position ?? Vector3.zero, m_Use2DDistance, m_ChannelMask, out var pos, out var rot, this);
		bool reaction = m_ReactionSettings.GetReaction(deltaTime, pos, out var pos2, out var rot2, impulseTimeRate, distanceRate, blendAmplitudeValue);
		if (impulseAt)
		{
			rot = Quaternion.SlerpUnclamped(Quaternion.identity, rot, m_Gain);
			pos *= m_Gain;
			ImpulseTimer = m_ReactionSettings.m_Duration;
			impulseEffect = true;
		}
		if (reaction)
		{
			pos += pos2;
			rot *= rot2;
		}
		if ((impulseAt | reaction) && flag && !IgnoreImpuseEffect)
		{
			if (m_UseCameraSpace)
			{
				pos = state.RawOrientation * pos;
			}
			state.PositionCorrection += pos;
			state.OrientationCorrection *= rot;
		}
		if (!flag)
		{
			blendAmplitudeStartTime = ImpulseTimer;
		}
		if (impulseEffect && ImpulseTimer <= 0f)
		{
			impulseEffect = false;
		}
		if (!CinemachineCustomImpulseManager.Instance.ExistSource(this) && !reaction)
		{
			vcam.RemoveExtension(this);
			CinemachineCustomImpulseManager.Instance.RemoveListener(this);
			UnityEngine.Object.DestroyImmediate(this);
		}
	}
}
