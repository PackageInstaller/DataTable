using ACT.Sound;
using FMODUnity;

namespace ACT.Battle.Configs;

public class RoleVoiceItem : PerformanceItem
{
	public EventReference soundEvent;

	public AudioEventReference audioSoundEvent;

	public bool stopByMotion;

	public ActionRoleVoice actionSound = new ActionRoleVoice();

	public override void Fire(FindTargetResult target, FSMRuntimeState runtimeState)
	{
		if (actionSound == null)
		{
			actionSound = new ActionRoleVoice();
		}
		actionSound.audioSoundEvent = audioSoundEvent;
		actionSound.stopByMotion = stopByMotion;
		actionSound.CheckDo(new ActionMemory(target.entity, target.entity, target));
	}

	public override bool CanDoPeriod()
	{
		return false;
	}
}
