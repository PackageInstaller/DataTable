using System;
using ACT.Sound;

namespace ACT;

public static class AudioEventReferenceExtenstion
{
	private static Func<AudioEventReference, string> _alternativeGetAudioEventPathCallback;

	public static void ResetAlternativeGetAudioEventPathCallback(Func<AudioEventReference, string> callback)
	{
		_alternativeGetAudioEventPathCallback = callback;
	}

	public static string GetFixedAudioEventPath(this AudioEventReference audioEvent)
	{
		if (_alternativeGetAudioEventPathCallback != null)
		{
			return _alternativeGetAudioEventPathCallback?.Invoke(audioEvent);
		}
		return audioEvent.IsNull() ? "Null" : audioEvent.GetEventPath();
	}
}
