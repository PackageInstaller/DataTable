using ACT.Sound;
using ACT.Sound.Core;
using Bamboo.ECS;
using FMODUnity;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行命中音效", "Action", new string[] { "hit", "sounds", "sound", "audio", "voice", "music" })]
public class ActionHitSounds : ConfigAction
{
	public EventReference akEvent;

	public AudioEventReference audioAkEvent;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		EMaterial eMaterial = memory.target.entity.GetConfig().eMaterial;
		if (eMaterial != EMaterial.NIL)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(audioAkEvent, new AudioPlayOptions
			{
				attachTarget = memory.target.entity.GetRootTransform(),
				onParametersSetup = (IAudioInstance instance) =>
				{
					instance.SetParameter("material", (int)eMaterial);
				}
			});
		}
	}
}
