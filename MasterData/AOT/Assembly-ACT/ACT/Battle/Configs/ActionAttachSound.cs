using ACT.Sound;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ActionAttachSound : ConfigAction
{
	public AudioEventReference audioSoundEvent;

	public string attachPointStr;

	public bool stopByMotion = true;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		uint num = 0u;
		Transform attachPoint = memory.target.entity.GetMono().GetAttachPoint(attachPointStr);
		if (!(attachPoint == null))
		{
			num = Singleton<GameManager>.instance.audioManager.PlaySound(audioSoundEvent, new AudioPlayOptions
			{
				attachTarget = attachPoint
			});
			if (stopByMotion)
			{
				memory.owner.GetCompSound().SetCurSound(num);
			}
		}
	}
}
