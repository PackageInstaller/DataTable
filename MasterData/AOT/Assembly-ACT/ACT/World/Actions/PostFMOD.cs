using ACT.Battle.Configs;
using ACT.Sound;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using FMODUnity;
using Fundamental;
using UnityEngine;

namespace ACT.World.Actions;

public class PostFMOD : InteractAction
{
	[Tooltip("音效名字")]
	public EventReference soundEvent;

	public AudioEventReference audioSoundEvent;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound(audioSoundEvent, new AudioPlayOptions
		{
			attachTarget = behave.GetRootTransform()
		});
		return UniTask.CompletedTask;
	}
}
