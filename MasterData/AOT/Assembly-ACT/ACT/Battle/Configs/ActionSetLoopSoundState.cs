using ACT.Sound;
using FMODUnity;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置循环音效状态", "Action", new string[] { "set", "loop", "sound", "state", "audio", "voice", "music" })]
public class ActionSetLoopSoundState : ConfigAction
{
	public EventReference soundEvent;

	public AudioEventReference audioSoundEvent;

	[Tooltip("参数名称，用于控制音效状态")]
	public string parameterName = "state";

	[Tooltip("是否结束（true=1, false=0）")]
	public bool isEnd;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		float value = (isEnd ? 1f : 0f);
		Singleton<LoopAudioManager>.instance.SetSoundState(memory.owner, audioSoundEvent, parameterName, value);
	}
}
