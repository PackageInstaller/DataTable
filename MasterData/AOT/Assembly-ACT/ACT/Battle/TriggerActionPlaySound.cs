using System.Threading;
using ACT.Sound;
using Cysharp.Threading.Tasks;
using FMODUnity;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class TriggerActionPlaySound : TriggerActionBase
{
	public EventReference soundEvent;

	public AudioEventReference audioSoundEvent;

	public GameObject pos;

	public override UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		if (pos != null)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound(audioSoundEvent, new AudioPlayOptions
			{
				attachTarget = pos.transform
			});
		}
		return UniTask.CompletedTask;
	}
}
