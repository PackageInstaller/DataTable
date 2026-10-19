using UnityEngine;

namespace ACT.Battle.Configs;

public class SetLoopSoundStateItem : PerformanceItem
{
	public bool isEnd;

	[HideInInspector]
	public ActionSetLoopSoundState actionLoopSound = new ActionSetLoopSoundState();

	public override void Fire(FindTargetResult target, FSMRuntimeState runtimeState)
	{
		if (actionLoopSound == null)
		{
			actionLoopSound = new ActionSetLoopSoundState();
		}
		actionLoopSound.isEnd = isEnd;
		actionLoopSound.CheckDo(new ActionMemory(target.entity, target.entity, target));
	}

	public override bool CanDoPeriod()
	{
		return false;
	}
}
