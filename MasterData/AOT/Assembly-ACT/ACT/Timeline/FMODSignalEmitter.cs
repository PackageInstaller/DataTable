using System;
using ACT.Sound;
using FMODUnity;
using Fundamental;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[Serializable]
[ExcludeFromPreset]
public class FMODSignalEmitter : SignalEmitter, IActionSignalEmitter, INotification, INotificationOptionProvider
{
	[Range(0f, 1f)]
	public float volume = 1f;

	public EventReference EventReference;

	public AudioEventReference audioEventReference;

	private uint eventInstance;

	public PropertyName id => new PropertyName(audioEventReference.GetEventPath());

	public NotificationFlags flags => NotificationFlags.Retroactive;

	public void Invoke(INotificationReceiver receiver)
	{
		PlayEvent(receiver);
	}

	protected void PlayEvent(INotificationReceiver receiver)
	{
		if (!EventReference.IsNull)
		{
			GameObject gameObject = (receiver as ActionSignalReceiver).gameObject;
			eventInstance = Singleton<GameManager>.instance.audioManager.PlaySound(audioEventReference, new AudioPlayOptions
			{
				attachTarget = gameObject.transform
			});
			Singleton<GameManager>.instance.audioManager.SetPlaybackTime(eventInstance, (float)(time * 1000.0));
		}
	}
}
