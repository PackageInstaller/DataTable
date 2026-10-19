using ACT.Sound;
using FMODUnity;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("移除循环音效状态", "Action", new string[] { "remove", "loop", "sound", "state", "audio", "voice", "music" })]
public class ActionRemoveLoopSoundState : ConfigAction
{
	[Tooltip("是否允许淡出")]
	public bool needFadeOut;

	public EventReference soundEvent;

	public AudioEventReference audioSoundEvent;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		Singleton<LoopAudioManager>.instance.Stop(memory.owner, audioSoundEvent, needFadeOut);
	}
}
