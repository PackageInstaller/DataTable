using ACT.Sound;
using FMODUnity;
using UnityEngine;

namespace ACT.Battle.Configs;

public class PlayLoopSoundItem : PerformanceItem
{
	public EventReference soundEvent;

	public AudioEventReference audioSoundEvent;

	[HideInInspector]
	public ActionPlayLoopSound actionLoopSound = new ActionPlayLoopSound();

	public bool stopByMotionChange;

	public override void Fire(FindTargetResult target, FSMRuntimeState runtimeState)
	{
		if (actionLoopSound == null)
		{
			actionLoopSound = new ActionPlayLoopSound();
		}
		actionLoopSound.soundEvent = soundEvent;
		actionLoopSound.stopByMotionChange = stopByMotionChange;
		actionLoopSound.CheckDo(new ActionMemory(target.entity, target.entity, target));
	}

	public override bool CanDoPeriod()
	{
		return false;
	}
}
