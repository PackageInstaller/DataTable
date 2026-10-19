using ACT.Sound;
using Bamboo.ECS;
using FMODUnity;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行角色语音", "Action", new string[] { "role", "voice", "sound", "audio", "music" })]
public class ActionRoleVoice : ConfigAction
{
	public EventReference soundEvent;

	public AudioEventReference audioSoundEvent;

	public bool stopByMotion;

	[HideInInspector]
	public string debugStr;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		uint num = 0u;
		num = Singleton<AudioVoiceManager>.instance.Play(audioSoundEvent.GetEventPath(), new AudioPlayOptions
		{
			attachTarget = memory.target.entity.GetRootTransform()
		});
		if (stopByMotion)
		{
			memory.owner.GetCompSound().SetCurSound(num);
		}
	}
}
