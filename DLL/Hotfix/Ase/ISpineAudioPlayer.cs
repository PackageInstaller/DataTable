using System;
using System.Collections.Generic;
using FMOD.Studio;

namespace Ase;

public interface ISpineAudioPlayer
{
	void PlayAudio(FusionData fusionData);

	void PlayAudio(List<AudioClipData> audios, List<AudioParameterSerializable> audioParameters);

	void StopAllAudio();

	void AddAudioPlayAction(Action<int, EventInstance> action);
}
