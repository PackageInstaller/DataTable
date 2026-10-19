using System;

namespace ACT.Battle.Configs;

[Obsolete]
public class CameraItem : PerformanceItem
{
	public ActionCamera camera;

	public override void Fire(FindTargetResult target, FSMRuntimeState runtimeState)
	{
		camera.CheckDo(new ActionMemory(target.entity, target.entity, target));
	}

	public override bool CanDoPeriod()
	{
		return false;
	}
}
