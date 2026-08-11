using GameFramework.Sound;
using UnityEngine;
using UnityEngine.Audio;

namespace GameFramework.Runtime;

public abstract class SoundAgentHelperBase : MonoBehaviour, ISoundAgentHelper
{
	public abstract bool IsPlaying { get; }

	public abstract float Length { get; }

	public abstract float Time { get; set; }

	public abstract bool Mute { get; set; }

	public abstract bool Loop { get; set; }

	public abstract int Priority { get; set; }

	public abstract float Volume { get; set; }

	public abstract float Pitch { get; set; }

	public abstract float PanStereo { get; set; }

	public abstract float SpatialBlend { get; set; }

	public abstract float MaxDistance { get; set; }

	public abstract float DopplerLevel { get; set; }

	public abstract AudioMixerGroup AudioMixerGroup { get; set; }

	public abstract void Play(float fadeInSeconds);

	public abstract void Stop(float fadeOutSeconds);

	public abstract void Pause(float fadeOutSeconds);

	public abstract void Resume(float fadeInSeconds);

	public abstract void Reset();

	public abstract bool SetSoundAsset(object soundAsset);

	public abstract void SetWorldPosition(Vector3 worldPosition);
}
