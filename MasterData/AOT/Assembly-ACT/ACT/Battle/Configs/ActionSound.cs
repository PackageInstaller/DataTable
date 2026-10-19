using ACT.Sound;
using ACT.Sound.Core;
using Bamboo.ECS;
using FMODUnity;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行音效", "Action", new string[] { "sound", "audio", "voice", "music" })]
public class ActionSound : ConfigAction
{
	public EventReference soundEvent;

	public AudioEventReference audioSoundEvent;

	public bool stopByMotion = true;

	public bool ignoreTimeStop;

	public bool ignoreOwnerLife;

	[HideInInspector]
	public bool useFootMat;

	[HideInInspector]
	public string debugStr;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		uint num = 0u;
		num = ((!useFootMat) ? Singleton<GameManager>.instance.audioManager.PlaySound(audioSoundEvent, new AudioPlayOptions
		{
			attachTarget = memory.target.entity.GetRootTransform()
		}) : Singleton<GameManager>.instance.audioManager.PlaySound(audioSoundEvent, new AudioPlayOptions
		{
			attachTarget = memory.target.entity.GetRootTransform(),
			onParametersSetup = (IAudioInstance instance) =>
			{
				instance.SetParameter("Ground_Material", (int)Singleton<RoadMaterialManager>.instance.GetRoadMaterial(memory.owner));
			}
		}));
		if (!ignoreTimeStop && !ignoreOwnerLife)
		{
			memory.owner.GetCompSound().SetSoundInstance(num);
		}
		if (stopByMotion)
		{
			memory.owner.GetCompSound().SetCurSound(num);
		}
	}
}
