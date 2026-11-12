using Cinemachine;
using UnityEngine;

public class AdventurePlayerIndependentImpulseListener : MonoBehaviour
{
	[Tooltip("Impulse events on channels not included in the mask will be ignored.")]
	[CinemachineImpulseChannelProperty]
	public int m_ChannelMask;

	[Tooltip("Gain to apply to the Impulse signal.  1 is normal strength.  Setting this to 0 completely mutes the signal.")]
	public float m_Gain;

	[Tooltip("Enable this to perform distance calculation in 2D (ignore Z)")]
	public bool m_Use2DDistance;

	[Tooltip("This controls the secondary reaction of the listener to the incoming impulse.  The impulse might be for example a sharp shock, and the secondary reaction could be a vibration whose amplitude and duration is controlled by the size of the original impulse.  This allows different listeners to respond in different ways to the same impulse signal.")]
	public CinemachineImpulseListener.ImpulseReaction m_ReactionSettings;

	public Vector3 impulsePosLastFrame { get; private set; }

	public Quaternion impulseRotLastFrame { get; private set; }

	private void Reset()
	{
		m_ChannelMask = 1;
		m_Gain = 1f;
		m_Use2DDistance = false;
		m_ReactionSettings = new CinemachineImpulseListener.ImpulseReaction
		{
			m_AmplitudeGain = 1f,
			m_FrequencyGain = 1f,
			m_Duration = 1f
		};
	}

	private void OnEnable()
	{
		impulsePosLastFrame = Vector3.zero;
		impulseRotLastFrame = Quaternion.identity;
	}

	public bool DoUpdate(float deltaTime, Transform transform = null)
	{
		bool impulseAt = CinemachineImpulseManager.Instance.GetImpulseAt(transform.position, m_Use2DDistance, m_ChannelMask, out var pos, out var rot);
		impulsePosLastFrame = pos;
		impulseRotLastFrame = rot;
		bool reaction = m_ReactionSettings.GetReaction(deltaTime, impulsePosLastFrame, out var pos2, out var rot2);
		if (impulseAt)
		{
			impulseRotLastFrame = Quaternion.SlerpUnclamped(Quaternion.identity, impulseRotLastFrame, m_Gain);
			impulsePosLastFrame *= m_Gain;
		}
		if (reaction)
		{
			impulsePosLastFrame += pos2;
			impulseRotLastFrame *= rot2;
		}
		if (impulseAt | reaction)
		{
			if (transform != null)
			{
				transform.position += impulsePosLastFrame;
				transform.rotation *= impulseRotLastFrame;
			}
			return true;
		}
		return false;
	}
}
