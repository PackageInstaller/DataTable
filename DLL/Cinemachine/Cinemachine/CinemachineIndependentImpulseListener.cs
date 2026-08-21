using UnityEngine;

namespace Cinemachine;

[SaveDuringPlay]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/api/Cinemachine.CinemachineIndependentImpulseListener.html")]
public class CinemachineIndependentImpulseListener : MonoBehaviour
{
	private Vector3 impulsePosLastFrame;

	private Quaternion impulseRotLastFrame;

	[Tooltip("Impulse events on channels not included in the mask will be ignored.")]
	[CinemachineImpulseChannelProperty]
	public int m_ChannelMask;

	[Tooltip("Gain to apply to the Impulse signal.  1 is normal strength.  Setting this to 0 completely mutes the signal.")]
	public float m_Gain;

	[Tooltip("Enable this to perform distance calculation in 2D (ignore Z)")]
	public bool m_Use2DDistance;

	[Tooltip("Enable this to process all impulse signals in camera space")]
	public bool m_UseLocalSpace;

	[Tooltip("This controls the secondary reaction of the listener to the incoming impulse.  The impulse might be for example a sharp shock, and the secondary reaction could be a vibration whose amplitude and duration is controlled by the size of the original impulse.  This allows different listeners to respond in different ways to the same impulse signal.")]
	public CinemachineImpulseListener.ImpulseReaction m_ReactionSettings;

	private void Reset()
	{
		m_ChannelMask = 1;
		m_Gain = 1f;
		m_Use2DDistance = false;
		m_UseLocalSpace = true;
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

	private void Update()
	{
		base.transform.position -= impulsePosLastFrame;
		base.transform.rotation = base.transform.rotation * Quaternion.Inverse(impulseRotLastFrame);
	}

	private void LateUpdate()
	{
		bool impulseAt = CinemachineImpulseManager.Instance.GetImpulseAt(base.transform.position, m_Use2DDistance, m_ChannelMask, out impulsePosLastFrame, out impulseRotLastFrame);
		bool reaction = m_ReactionSettings.GetReaction(Time.deltaTime, impulsePosLastFrame, out var pos, out var rot);
		if (impulseAt)
		{
			impulseRotLastFrame = Quaternion.SlerpUnclamped(Quaternion.identity, impulseRotLastFrame, m_Gain);
			impulsePosLastFrame *= m_Gain;
		}
		if (reaction)
		{
			impulsePosLastFrame += pos;
			impulseRotLastFrame *= rot;
		}
		if (impulseAt | reaction)
		{
			if (m_UseLocalSpace)
			{
				impulsePosLastFrame = base.transform.rotation * impulsePosLastFrame;
			}
			base.transform.position += impulsePosLastFrame;
			base.transform.rotation = base.transform.rotation * impulseRotLastFrame;
		}
	}
}
