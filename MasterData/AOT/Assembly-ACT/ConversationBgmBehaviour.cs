using System;
using ACT.Sound;
using FMODUnity;
using Fundamental;
using UnityEngine.Playables;

[Serializable]
public class ConversationBgmBehaviour : PlayableBehaviour
{
	public EventReference eventReference;

	public AudioEventReference audioEventReference;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (audioEventReference.IsNull())
		{
			Singleton<BGMManager>.instance.ClearBGM(BGMType.AVG);
		}
		else
		{
			Singleton<BGMManager>.instance.SetBGM(BGMType.AVG, audioEventReference);
		}
	}
}
