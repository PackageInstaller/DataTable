using ACT.Battle.Configs;
using ACT.Sound;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using FMODUnity;
using Fundamental;
using UnityEngine;

namespace ACT.World.Actions;

public class StopLoopSound : InteractAction
{
	[Tooltip("音效标识")]
	public int id;

	[Tooltip("音效名字")]
	public EventReference soundEvent;

	public AudioEventReference audioSoundEvent;

	[Tooltip("是否允许淡出")]
	public bool needFaceOut;

	protected override AbilityAuth auth => AbilityAuth.Both;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		Singleton<LoopAudioManager>.instance.Stop(behave, audioSoundEvent, needFaceOut);
		return UniTask.CompletedTask;
	}
}
