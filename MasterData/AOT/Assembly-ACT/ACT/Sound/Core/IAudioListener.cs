using UnityEngine;

namespace ACT.Sound.Core;

public interface IAudioListener
{
	void SetAttenuationObject(GameObject obj);

	void Cleanup();
}
