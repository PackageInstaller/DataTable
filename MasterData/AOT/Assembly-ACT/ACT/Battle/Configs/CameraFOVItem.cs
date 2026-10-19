using System.Collections.Generic;

namespace ACT.Battle.Configs;

public class CameraFOVItem : PerformanceItem
{
	public ActionCameraFOV cameraFOV;

	public float endTime;

	public int endTimeFrame;

	public override void Fire(FindTargetResult target, FSMRuntimeState runtimeState)
	{
		if (endTime >= 0f)
		{
			float num = ((runtimeState.runtimeClip != null) ? runtimeState.runtimeClip.length : 0f);
			cameraFOV.duration = num * ((endTime > time) ? (endTime - time) : (1f - time));
		}
		cameraFOV.CheckDo(new ActionMemory(target.entity, target.entity, target));
	}

	public override void Precache(List<YooAssetReference> list)
	{
		cameraFOV.Precache(list);
	}

	public override bool CanDoPeriod()
	{
		return false;
	}
}
