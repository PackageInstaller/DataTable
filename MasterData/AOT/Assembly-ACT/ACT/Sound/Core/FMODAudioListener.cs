using FMODUnity;
using UnityEngine;

namespace ACT.Sound.Core;

internal class FMODAudioListener : IAudioListener
{
	private StudioListener _listener;

	public FMODAudioListener(StudioListener listener)
	{
		_listener = listener;
	}

	public void SetAttenuationObject(GameObject obj)
	{
		if (_listener != null && obj != null)
		{
			_listener.SetAttenuationObject(obj);
		}
	}

	public void Cleanup()
	{
		if (_listener != null)
		{
			Object.Destroy(_listener);
			_listener = null;
		}
	}
}
