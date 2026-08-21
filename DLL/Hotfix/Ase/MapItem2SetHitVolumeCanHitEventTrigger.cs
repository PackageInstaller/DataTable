using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("交互物2修改击打平台受击盒参数")]
public class MapItem2SetHitVolumeCanHitEventTrigger : MapItemEventTrigger
{
	public List<int> MovingPlatIds;

	public int Index;

	public bool CanHit;

	public override string TriggerName => "交互物-交互物2修改击打平台受击盒参数";

	protected override async void DoExecute()
	{
		base.DoExecute();
		LevelMapData levelMapData = sceneSystem.GetLevelMapData();
		if (!((Object)(object)levelMapData != null) || MovingPlatIds == null)
		{
			return;
		}
		foreach (int movingPlatId in MovingPlatIds)
		{
			levelMapData.SetHitVolumeParamCanHit(movingPlatId, Index, CanHit);
		}
	}
}
