using System;
using System.Collections.Generic;
using Ase;
using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.API)]
public class CinemachineCustomImpulseManager
{
	[Serializable]
	public struct EnvelopeDefinition
	{
		[Tooltip("Normalized curve defining the shape of the start of the envelope.  If blank a default curve will be used")]
		public AnimationCurve m_AttackShape;

		[Tooltip("Normalized curve defining the shape of the end of the envelope.  If blank a default curve will be used")]
		public AnimationCurve m_DecayShape;

		[Tooltip("Duration in seconds of the attack.  Attack curve will be scaled to fit.  Must be >= 0.")]
		public float m_AttackTime;

		[Tooltip("Duration in seconds of the central fully-scaled part of the envelope.  Must be >= 0.")]
		public float m_SustainTime;

		[Tooltip("Duration in seconds of the decay.  Decay curve will be scaled to fit.  Must be >= 0.")]
		public float m_DecayTime;

		[Tooltip("If checked, signal amplitude scaling will also be applied to the time envelope of the signal.  Stronger signals will last longer.")]
		public bool m_ScaleWithImpact;

		[Tooltip("If true, then duration is infinite.")]
		public bool m_HoldForever;

		public float Duration
		{
			get
			{
				if (m_HoldForever)
				{
					return -1f;
				}
				return m_AttackTime + m_SustainTime + m_DecayTime;
			}
		}

		public static EnvelopeDefinition Default()
		{
			return new EnvelopeDefinition
			{
				m_DecayTime = 0.7f,
				m_SustainTime = 0.2f,
				m_ScaleWithImpact = true
			};
		}

		public float GetValueAt(float offset)
		{
			if (offset >= 0f)
			{
				if (offset < m_AttackTime && m_AttackTime > 0.0001f)
				{
					if (m_AttackShape == null || m_AttackShape.length < 2)
					{
						return Damper.Damp(1f, m_AttackTime, offset);
					}
					return m_AttackShape.Evaluate(offset / m_AttackTime);
				}
				offset -= m_AttackTime;
				if (m_HoldForever || offset < m_SustainTime)
				{
					return 1f;
				}
				offset -= m_SustainTime;
				if (offset < m_DecayTime && m_DecayTime > 0.0001f)
				{
					if (m_DecayShape == null || m_DecayShape.length < 2)
					{
						return 1f - Damper.Damp(1f, m_DecayTime, offset);
					}
					return m_DecayShape.Evaluate(offset / m_DecayTime);
				}
			}
			return 0f;
		}

		public void ChangeStopTime(float offset, bool forceNoDecay)
		{
			if (offset < 0f)
			{
				offset = 0f;
			}
			if (offset < m_AttackTime)
			{
				m_AttackTime = 0f;
			}
			m_SustainTime = offset - m_AttackTime;
			if (forceNoDecay)
			{
				m_DecayTime = 0f;
			}
		}

		public void Clear()
		{
			m_AttackShape = (m_DecayShape = null);
			m_AttackTime = (m_SustainTime = (m_DecayTime = 0f));
		}

		public void Validate()
		{
			m_AttackTime = Mathf.Max(0f, m_AttackTime);
			m_DecayTime = Mathf.Max(0f, m_DecayTime);
			m_SustainTime = Mathf.Max(0f, m_SustainTime);
		}
	}

	public class ImpulseEvent
	{
		public enum DirectionMode
		{
			Fixed,
			RotateTowardSource
		}

		public enum DissipationMode
		{
			LinearDecay,
			SoftDecay,
			ExponentialDecay
		}

		public float m_StartTime;

		public EnvelopeDefinition m_Envelope;

		public ISignalSource6D m_SignalSource;

		public Vector3 m_Position;

		public float m_Radius;

		public DirectionMode m_DirectionMode;

		public int m_Channel;

		public DissipationMode m_DissipationMode;

		public float m_DissipationDistance;

		public float m_CustomDissipation;

		public float m_PropagationSpeed;

		public CinemachineCustomImpulseListener BingListener;

		public bool Expired
		{
			get
			{
				float duration = m_Envelope.Duration;
				float num = m_Radius + m_DissipationDistance;
				float num2 = Instance.CurrentTime - num / Mathf.Max(1f, m_PropagationSpeed);
				if (duration > 0f)
				{
					return m_StartTime + duration <= num2;
				}
				return false;
			}
		}

		public void Cancel(float time, bool forceNoDecay)
		{
			m_Envelope.m_HoldForever = false;
			m_Envelope.ChangeStopTime(time - m_StartTime, forceNoDecay);
		}

		public float DistanceDecay(float distance)
		{
			float num = Mathf.Max(m_Radius, 0f);
			if (distance < num)
			{
				return 1f;
			}
			distance -= num;
			if (distance >= m_DissipationDistance)
			{
				return 0f;
			}
			if (m_CustomDissipation >= 0f)
			{
				return EvaluateDissipationScale(m_CustomDissipation, distance / m_DissipationDistance);
			}
			return m_DissipationMode switch
			{
				DissipationMode.SoftDecay => 0.5f * (1f + Mathf.Cos(MathF.PI * (distance / m_DissipationDistance))), 
				DissipationMode.ExponentialDecay => 1f - Damper.Damp(1f, m_DissipationDistance, distance), 
				_ => Mathf.Lerp(1f, 0f, distance / m_DissipationDistance), 
			};
		}

		public bool GetDecayedSignal(Vector3 listenerPosition, bool use2D, out Vector3 pos, out Quaternion rot)
		{
			if (m_SignalSource != null)
			{
				float num = (use2D ? Vector2.Distance(listenerPosition, m_Position) : Vector3.Distance(listenerPosition, m_Position));
				float num2 = Instance.CurrentTime - m_StartTime - num / Mathf.Max(1f, m_PropagationSpeed);
				float num3 = m_Envelope.GetValueAt(num2) * DistanceDecay(num);
				if (num3 != 0f)
				{
					m_SignalSource.GetSignal(num2, out pos, out rot);
					pos *= num3;
					rot = Quaternion.SlerpUnclamped(Quaternion.identity, rot, num3);
					if (m_DirectionMode == DirectionMode.RotateTowardSource && num > 0.0001f)
					{
						Quaternion quaternion = Quaternion.FromToRotation(Vector3.up, listenerPosition - m_Position);
						if (m_Radius > 0.0001f)
						{
							float num4 = Mathf.Clamp01(num / m_Radius);
							quaternion = Quaternion.Slerp(quaternion, Quaternion.identity, Mathf.Cos(MathF.PI * num4 / 2f));
						}
						pos = quaternion * pos;
					}
					return true;
				}
			}
			pos = Vector3.zero;
			rot = Quaternion.identity;
			return false;
		}

		public void Clear()
		{
			m_Envelope.Clear();
			m_StartTime = 0f;
			m_SignalSource = null;
			m_Position = Vector3.zero;
			m_Channel = 0;
			m_Radius = 0f;
			m_DissipationDistance = 100f;
			m_DissipationMode = DissipationMode.ExponentialDecay;
			m_CustomDissipation = -1f;
			BingListener = null;
		}

		internal ImpulseEvent()
		{
		}
	}

	private CinemachineCustomImpulseListener lastPriorityMaxListener;

	public bool NeedBlendAmplitude;

	private float lastBlendAmplitudeValue;

	private List<CinemachineCustomImpulseListener> allListeners = new List<CinemachineCustomImpulseListener>(5);

	private static CinemachineCustomImpulseManager sInstance;

	private const float Epsilon = 0.0001f;

	private List<ImpulseEvent> m_ExpiredEvents;

	private List<ImpulseEvent> m_ActiveEvents;

	public bool IgnoreTimeScale;

	public float LastBlendAmplitudeValue => lastBlendAmplitudeValue;

	public static CinemachineCustomImpulseManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new CinemachineCustomImpulseManager();
			}
			return sInstance;
		}
	}

	public float CurrentTime
	{
		get
		{
			if (!IgnoreTimeScale)
			{
				return CinemachineCore.CurrentTime;
			}
			return Time.realtimeSinceStartup;
		}
	}

	private CinemachineCustomImpulseManager()
	{
	}

	[RuntimeInitializeOnLoadMethod]
	private static void InitializeModule()
	{
		if (sInstance != null)
		{
			sInstance.Clear();
		}
	}

	internal static float EvaluateDissipationScale(float spread, float normalizedDistance)
	{
		float num = -0.8f + 1.6f * (1f - spread);
		num = (1f - num) * 0.5f;
		float t = Mathf.Clamp01(normalizedDistance) / ((1f / Mathf.Clamp01(num) - 2f) * (1f - normalizedDistance) + 1f);
		return 1f - SplineHelpers.Bezier1(t, 0f, 0f, 1f, 1f);
	}

	public bool GetImpulseAt(Vector3 listenerLocation, bool distance2D, int channelMask, out Vector3 pos, out Quaternion rot, CinemachineCustomImpulseListener listener)
	{
		bool result = false;
		pos = Vector3.zero;
		rot = Quaternion.identity;
		if (m_ActiveEvents != null)
		{
			for (int num = m_ActiveEvents.Count - 1; num >= 0; num--)
			{
				ImpulseEvent impulseEvent = m_ActiveEvents[num];
				if (!(impulseEvent.BingListener != listener))
				{
					if (impulseEvent == null || impulseEvent.Expired)
					{
						m_ActiveEvents.RemoveAt(num);
						if (impulseEvent != null)
						{
							if (m_ExpiredEvents == null)
							{
								m_ExpiredEvents = new List<ImpulseEvent>();
							}
							impulseEvent.Clear();
							m_ExpiredEvents.Add(impulseEvent);
						}
					}
					else if ((impulseEvent.m_Channel & channelMask) != 0)
					{
						Vector3 pos2 = Vector3.zero;
						Quaternion rot2 = Quaternion.identity;
						if (impulseEvent.GetDecayedSignal(listenerLocation, distance2D, out pos2, out rot2))
						{
							result = true;
							pos += pos2;
							rot *= rot2;
						}
					}
				}
			}
		}
		return result;
	}

	public bool ExistSource(CinemachineCustomImpulseListener listener)
	{
		if (m_ActiveEvents == null)
		{
			return false;
		}
		for (int num = m_ActiveEvents.Count - 1; num >= 0; num--)
		{
			if (m_ActiveEvents[num].BingListener == listener)
			{
				return true;
			}
		}
		return false;
	}

	public bool IsMaxPriorityListener(CinemachineCustomImpulseListener listener)
	{
		CinemachineCustomImpulseListener cinemachineCustomImpulseListener = null;
		if (allListeners.Count == 1)
		{
			if (allListeners[0] == listener)
			{
				cinemachineCustomImpulseListener = listener;
			}
		}
		else
		{
			float? num = null;
			for (int i = 0; i < allListeners.Count; i++)
			{
				CinemachineCustomImpulseListener cinemachineCustomImpulseListener2 = allListeners[i];
				if (cinemachineCustomImpulseListener2.ImpulseEffect)
				{
					float num2 = cinemachineCustomImpulseListener2.PriorityInit * cinemachineCustomImpulseListener2.PriorityTimeValue() * cinemachineCustomImpulseListener2.PriorityDisValue();
					if (!num.HasValue || num2 >= num.Value)
					{
						cinemachineCustomImpulseListener = cinemachineCustomImpulseListener2;
						num = num2;
					}
				}
			}
		}
		if (cinemachineCustomImpulseListener != null)
		{
			if (lastPriorityMaxListener == null)
			{
				lastPriorityMaxListener = cinemachineCustomImpulseListener;
				lastBlendAmplitudeValue = cinemachineCustomImpulseListener.m_ReactionSettings.CurrentAmplitudeGain;
				NeedBlendAmplitude = false;
			}
			else if (lastPriorityMaxListener != cinemachineCustomImpulseListener)
			{
				NeedBlendAmplitude = true;
				lastBlendAmplitudeValue = lastPriorityMaxListener.m_ReactionSettings.CurrentAmplitudeGain;
				lastPriorityMaxListener = cinemachineCustomImpulseListener;
			}
		}
		return cinemachineCustomImpulseListener == listener;
	}

	public ImpulseEvent NewImpulseEvent()
	{
		if (m_ExpiredEvents == null || m_ExpiredEvents.Count == 0)
		{
			return new ImpulseEvent
			{
				m_CustomDissipation = -1f
			};
		}
		ImpulseEvent result = m_ExpiredEvents[m_ExpiredEvents.Count - 1];
		m_ExpiredEvents.RemoveAt(m_ExpiredEvents.Count - 1);
		return result;
	}

	public void AddImpulseEvent(ImpulseEvent e)
	{
		if (m_ActiveEvents == null)
		{
			m_ActiveEvents = new List<ImpulseEvent>();
		}
		if (e != null)
		{
			e.m_StartTime = CurrentTime;
			m_ActiveEvents.Add(e);
		}
	}

	public void Clear()
	{
		if (m_ActiveEvents != null)
		{
			for (int i = 0; i < m_ActiveEvents.Count; i++)
			{
				m_ActiveEvents[i].Clear();
			}
			m_ActiveEvents.Clear();
		}
	}

	public void AddListener(CinemachineCustomImpulseListener listener)
	{
		if (listener != null)
		{
			allListeners.Add(listener);
		}
	}

	public void RemoveListener(CinemachineCustomImpulseListener listener)
	{
		if (allListeners.Contains(listener))
		{
			allListeners.Remove(listener);
		}
	}
}
