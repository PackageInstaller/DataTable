using ACT.Battle.Configs;
using ACT.Sound;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using FMODUnity;
using Fundamental;
using UnityEngine;

namespace ACT.World.Actions;

public class PlayLoopSound : InteractAction
{
	[Tooltip("音效标识")]
	public int id;

	[Tooltip("音效名字")]
	public EventReference soundEvent;

	public AudioEventReference audioSoundEvent;

	protected override AbilityAuth auth => AbilityAuth.Both;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		Singleton<LoopAudioManager>.instance.PlayLoop(behave, audioSoundEvent, stateObjectBase.transform);
		return UniTask.CompletedTask;
	}
}
