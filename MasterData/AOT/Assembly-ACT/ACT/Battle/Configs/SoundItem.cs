using ACT.Sound;
using FMODUnity;

namespace ACT.Battle.Configs;

public class SoundItem : PerformanceItem
{
	public EventReference soundEvent;

	public AudioEventReference audioSoundEvent;

	public bool stopByMotion = true;

	public bool needFootMaterial;

	public ActionSound actionSound = new ActionSound();

	public override void Fire(FindTargetResult target, FSMRuntimeState runtimeState)
	{
		if (actionSound == null)
		{
			actionSound = new ActionSound();
		}
		actionSound.useFootMat = needFootMaterial;
		actionSound.soundEvent = soundEvent;
		actionSound.stopByMotion = stopByMotion;
		actionSound.CheckDo(new ActionMemory(target.entity, target.entity, target));
	}

	public override bool CanDoPeriod()
	{
		return false;
	}
}
