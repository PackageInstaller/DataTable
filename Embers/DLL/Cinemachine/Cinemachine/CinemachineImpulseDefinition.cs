using System;
using UnityEngine;

namespace Cinemachine;

[Serializable]
[DocumentationSorting(DocumentationSortingAttribute.Level.API)]
public class CinemachineImpulseDefinition
{
	public enum ImpulseShapes
	{
		Custom,
		Recoil,
		Bump,
		Explosion,
		Rumble
	}

	public enum ImpulseTypes
	{
		Uniform,
		Dissipating,
		Propagating,
		Legacy
	}

	public enum RepeatMode
	{
		Stretch,
		Loop
	}

	private class SignalSource : ISignalSource6D
	{
		private CinemachineImpulseDefinition m_Def;

		private Vector3 m_Velocity;

		public float SignalDuration => m_Def.m_ImpulseDuration;

		public SignalSource(CinemachineImpulseDefinition def, Vector3 velocity)
		{
			m_Def = def;
			m_Velocity = velocity;
		}

		public void GetSignal(float timeSinceSignalStart, out Vector3 pos, out Quaternion rot)
		{
			pos = m_Velocity * m_Def.ImpulseCurve.Evaluate(timeSinceSignalStart / SignalDuration);
			rot = Quaternion.identity;
		}
	}

	private class LegacySignalSource : ISignalSource6D
	{
		private CinemachineImpulseDefinition m_Def;

		private Vector3 m_Velocity;

		private float m_StartTimeOffset;

		public float SignalDuration => m_Def.m_RawSignal.SignalDuration;

		public LegacySignalSource(CinemachineImpulseDefinition def, Vector3 velocity)
		{
			m_Def = def;
			m_Velocity = velocity;
			if (m_Def.m_Randomize && m_Def.m_RawSignal.SignalDuration <= 0f)
			{
				m_StartTimeOffset = UnityEngine.Random.Range(-1000f, 1000f);
			}
		}

		public void GetSignal(float timeSinceSignalStart, out Vector3 pos, out Quaternion rot)
		{
			float num = m_StartTimeOffset + timeSinceSignalStart * m_Def.m_FrequencyGain;
			float signalDuration = SignalDuration;
			if (signalDuration > 0f)
			{
				if (m_Def.m_RepeatMode == RepeatMode.Loop)
				{
					num %= signalDuration;
				}
				else if (m_Def.m_TimeEnvelope.Duration > 0.0001f)
				{
					num *= m_Def.m_TimeEnvelope.Duration / signalDuration;
				}
			}
			m_Def.m_RawSignal.GetSignal(num, out pos, out rot);
			float magnitude = m_Velocity.magnitude;
			_ = m_Velocity.normalized;
			magnitude *= m_Def.m_AmplitudeGain;
			pos *= magnitude;
			pos = Quaternion.FromToRotation(Vector3.down, m_Velocity) * pos;
			rot = Quaternion.SlerpUnclamped(Quaternion.identity, rot, magnitude);
		}
	}

	[Tooltip("Impulse events generated here will appear on the channels included in the mask.")]
	[CinemachineImpulseChannelProperty]
	public int m_ImpulseChannel = 1;

	[Tooltip("Shape of the impact signal")]
	public ImpulseShapes m_ImpulseShape;

	[Tooltip("Defines the custom shape of the impact signal that will be generated.")]
	public AnimationCurve m_CustomImpulseShape = new AnimationCurve();

	[Tooltip("The time during which the impact signal will occur.  The signal shape will be stretched to fill that time.")]
	public float m_ImpulseDuration = 0.2f;

	[Tooltip("How the impulse travels through space and time.")]
	public ImpulseTypes m_ImpulseType = ImpulseTypes.Legacy;

	[Range(0f, 1f)]
	[Tooltip("This defines how the widely signal will spread within the effect radius before dissipating with distance from the impact point")]
	public float m_DissipationRate;

	[CinemachineEmbeddedAssetProperty(true)]
	[Tooltip("Legacy mode only: Defines the signal that will be generated.")]
	[Header("Signal Shape")]
	public SignalSourceAsset m_RawSignal;

	[Tooltip("Legacy mode only: Gain to apply to the amplitudes defined in the signal source.  1 is normal.  Setting this to 0 completely mutes the signal.")]
	public float m_AmplitudeGain = 1f;

	[Tooltip("Legacy mode only: Scale factor to apply to the time axis.  1 is normal.  Larger magnitudes will make the signal progress more rapidly.")]
	public float m_FrequencyGain = 1f;

	[Tooltip("Legacy mode only: How to fit the signal into the envelope time")]
	public RepeatMode m_RepeatMode;

	[Tooltip("Legacy mode only: Randomize the signal start time")]
	public bool m_Randomize = true;

	[Tooltip("Legacy mode only: This defines the time-envelope of the signal.  The raw signal will be time-scaled to fit in the envelope.")]
	public CinemachineImpulseManager.EnvelopeDefinition m_TimeEnvelope = CinemachineImpulseManager.EnvelopeDefinition.Default();

	[Header("Spatial Range")]
	[Tooltip("Legacy mode only: The signal will have full amplitude in this radius surrounding the impact point.  Beyond that it will dissipate with distance.")]
	public float m_ImpactRadius = 100f;

	[Tooltip("Legacy mode only: How the signal direction behaves as the listener moves away from the origin.")]
	public CinemachineImpulseManager.ImpulseEvent.DirectionMode m_DirectionMode;

	[Tooltip("Legacy mode only: This defines how the signal will dissipate with distance beyond the impact radius.")]
	public CinemachineImpulseManager.ImpulseEvent.DissipationMode m_DissipationMode = CinemachineImpulseManager.ImpulseEvent.DissipationMode.ExponentialDecay;

	[Tooltip("The signal will have no effect outside this radius surrounding the impact point.")]
	public float m_DissipationDistance = 100f;

	[Tooltip("The speed (m/s) at which the impulse propagates through space.  High speeds allow listeners to react instantaneously, while slower speeds allow listeners in the scene to react as if to a wave spreading from the source.")]
	public float m_PropagationSpeed = 343f;

	private static AnimationCurve[] sStandardShapes;

	internal AnimationCurve ImpulseCurve
	{
		get
		{
			if (m_ImpulseShape == ImpulseShapes.Custom)
			{
				if (m_CustomImpulseShape == null)
				{
					m_CustomImpulseShape = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);
				}
				return m_CustomImpulseShape;
			}
			return GetStandardCurve(m_ImpulseShape);
		}
	}

	public void OnValidate()
	{
		RuntimeUtility.NormalizeCurve(m_CustomImpulseShape, normalizeX: true, normalizeY: false);
		m_ImpulseDuration = Mathf.Max(0.0001f, m_ImpulseDuration);
		m_DissipationDistance = Mathf.Max(0.0001f, m_DissipationDistance);
		m_DissipationRate = Mathf.Clamp01(m_DissipationRate);
		m_PropagationSpeed = Mathf.Max(1f, m_PropagationSpeed);
		m_ImpactRadius = Mathf.Max(0f, m_ImpactRadius);
		m_TimeEnvelope.Validate();
		m_PropagationSpeed = Mathf.Max(1f, m_PropagationSpeed);
	}

	private static void CreateStandardShapes()
	{
		int num = 0;
		foreach (object value in Enum.GetValues(typeof(ImpulseShapes)))
		{
			num = Mathf.Max(num, (int)value);
		}
		sStandardShapes = new AnimationCurve[num + 1];
		sStandardShapes[1] = new AnimationCurve(new Keyframe(0f, 1f, -3.2f, -3.2f), new Keyframe(1f, 0f, 0f, 0f));
		sStandardShapes[2] = new AnimationCurve(new Keyframe(0f, 0f, -4.9f, -4.9f), new Keyframe(0.2f, 0f, 8.25f, 8.25f), new Keyframe(1f, 0f, -0.25f, -0.25f));
		sStandardShapes[3] = new AnimationCurve(new Keyframe(0f, -1.4f, -7.9f, -7.9f), new Keyframe(0.27f, 0.78f, 23.4f, 23.4f), new Keyframe(0.54f, -0.12f, 22.6f, 22.6f), new Keyframe(0.75f, 0.042f, 9.23f, 9.23f), new Keyframe(0.9f, -0.02f, 5.8f, 5.8f), new Keyframe(0.95f, -0.006f, -3f, -3f), new Keyframe(1f, 0f, 0f, 0f));
		sStandardShapes[4] = new AnimationCurve(new Keyframe(0f, 0f, 0f, 0f), new Keyframe(0.1f, 0.25f, 0f, 0f), new Keyframe(0.2f, 0f, 0f, 0f), new Keyframe(0.3f, 0.75f, 0f, 0f), new Keyframe(0.4f, 0f, 0f, 0f), new Keyframe(0.5f, 1f, 0f, 0f), new Keyframe(0.6f, 0f, 0f, 0f), new Keyframe(0.7f, 0.75f, 0f, 0f), new Keyframe(0.8f, 0f, 0f, 0f), new Keyframe(0.9f, 0.25f, 0f, 0f), new Keyframe(1f, 0f, 0f, 0f));
	}

	internal static AnimationCurve GetStandardCurve(ImpulseShapes shape)
	{
		if (sStandardShapes == null)
		{
			CreateStandardShapes();
		}
		return sStandardShapes[(int)shape];
	}

	public void CreateEvent(Vector3 position, Vector3 velocity)
	{
		CreateAndReturnEvent(position, velocity);
	}

	public CinemachineImpulseManager.ImpulseEvent CreateAndReturnEvent(Vector3 position, Vector3 velocity)
	{
		if (m_ImpulseType == ImpulseTypes.Legacy)
		{
			return LegacyCreateAndReturnEvent(position, velocity);
		}
		if ((m_ImpulseShape == ImpulseShapes.Custom && m_CustomImpulseShape == null) || Mathf.Abs(m_DissipationDistance) < 0.0001f || Mathf.Abs(m_ImpulseDuration) < 0.0001f)
		{
			return null;
		}
		CinemachineImpulseManager.ImpulseEvent impulseEvent = CinemachineImpulseManager.Instance.NewImpulseEvent();
		impulseEvent.m_Envelope = new CinemachineImpulseManager.EnvelopeDefinition
		{
			m_SustainTime = m_ImpulseDuration
		};
		impulseEvent.m_SignalSource = new SignalSource(this, velocity);
		impulseEvent.m_Position = position;
		impulseEvent.m_Radius = ((m_ImpulseType == ImpulseTypes.Uniform) ? 9999999f : 0f);
		impulseEvent.m_Channel = m_ImpulseChannel;
		impulseEvent.m_DirectionMode = CinemachineImpulseManager.ImpulseEvent.DirectionMode.Fixed;
		impulseEvent.m_DissipationDistance = ((m_ImpulseType == ImpulseTypes.Uniform) ? 0f : m_DissipationDistance);
		impulseEvent.m_PropagationSpeed = ((m_ImpulseType == ImpulseTypes.Propagating) ? m_PropagationSpeed : 9999999f);
		impulseEvent.m_CustomDissipation = m_DissipationRate;
		CinemachineImpulseManager.Instance.AddImpulseEvent(impulseEvent);
		return impulseEvent;
	}

	private CinemachineImpulseManager.ImpulseEvent LegacyCreateAndReturnEvent(Vector3 position, Vector3 velocity)
	{
		if (m_RawSignal == null || Mathf.Abs(m_TimeEnvelope.Duration) < 0.0001f)
		{
			return null;
		}
		CinemachineImpulseManager.ImpulseEvent impulseEvent = CinemachineImpulseManager.Instance.NewImpulseEvent();
		impulseEvent.m_Envelope = m_TimeEnvelope;
		impulseEvent.m_Envelope = m_TimeEnvelope;
		if (m_TimeEnvelope.m_ScaleWithImpact)
		{
			impulseEvent.m_Envelope.m_DecayTime *= Mathf.Sqrt(velocity.magnitude);
		}
		impulseEvent.m_SignalSource = new LegacySignalSource(this, velocity);
		impulseEvent.m_Position = position;
		impulseEvent.m_Radius = m_ImpactRadius;
		impulseEvent.m_Channel = m_ImpulseChannel;
		impulseEvent.m_DirectionMode = m_DirectionMode;
		impulseEvent.m_DissipationMode = m_DissipationMode;
		impulseEvent.m_DissipationDistance = m_DissipationDistance;
		impulseEvent.m_PropagationSpeed = m_PropagationSpeed;
		CinemachineImpulseManager.Instance.AddImpulseEvent(impulseEvent);
		return impulseEvent;
	}
}
