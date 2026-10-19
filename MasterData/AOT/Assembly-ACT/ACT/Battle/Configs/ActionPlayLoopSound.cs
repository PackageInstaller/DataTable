using ACT.Sound;
using Bamboo.ECS;
using FMODUnity;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("播放循环音效", "Action", new string[] { "play", "loop", "sound", "audio", "voice", "music" })]
public class ActionPlayLoopSound : ConfigAction
{
	public EventReference soundEvent;

	public AudioEventReference audioSoundEvent;

	public bool stopByMotionChange;

	[HideInInspector]
	public string debugStr;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		uint num = Singleton<LoopAudioManager>.instance.PlayLoop(memory.owner, audioSoundEvent, new AudioPlayOptions
		{
			IsLoop = true,
			attachTarget = memory.target.entity.GetRootTransform()
		});
		memory.owner.GetCompSound().SetSoundInstance(num);
		if (stopByMotionChange)
		{
			memory.owner.GetCompSound().SetCurSound(num);
		}
	}
}
