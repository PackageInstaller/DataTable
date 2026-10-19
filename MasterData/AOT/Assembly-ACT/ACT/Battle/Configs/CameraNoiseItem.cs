using System.Collections.Generic;

namespace ACT.Battle.Configs;

public class CameraNoiseItem : PerformanceItem
{
	public ActionCameraNoise cameraNoise = new ActionCameraNoise
	{
		cameraNoiseType = CameraNoiseType.AnimTrigger
	};

	public float endTime;

	public int endTimeFrame;

	public override void Fire(FindTargetResult target, FSMRuntimeState runtimeState)
	{
		if (endTime >= 0f)
		{
			float num = ((runtimeState.runtimeClip != null) ? runtimeState.runtimeClip.length : 0f);
			cameraNoise.duration = num * ((endTime > time) ? (endTime - time) : (1f - time));
		}
		cameraNoise.CheckDo(new ActionMemory(target.entity, target.entity, target));
	}

	public override void Precache(List<YooAssetReference> list)
	{
		cameraNoise.Precache(list);
	}

	public override bool CanDoPeriod()
	{
		return false;
	}
}
