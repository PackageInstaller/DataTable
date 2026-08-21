using GameFramework.Sound;
using UnityEngine;
using UnityEngine.Audio;

namespace GameFramework.Runtime;

public abstract class SoundGroupHelperBase : MonoBehaviour, ISoundGroupHelper
{
	[SerializeField]
	private AudioMixerGroup m_AudioMixerGroup = null;

	public AudioMixerGroup AudioMixerGroup
	{
		get
		{
			return m_AudioMixerGroup;
		}
		set
		{
			m_AudioMixerGroup = value;
		}
	}
}
