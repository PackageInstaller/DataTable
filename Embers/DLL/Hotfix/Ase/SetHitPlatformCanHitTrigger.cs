using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class SetHitPlatformCanHitTrigger : MonoBehaviour
{
	[SerializeField]
	private List<PlatformTriggerData> triggers = new List<PlatformTriggerData>();

	public List<int> TargetMovingPlatIds;

	public List<int> MovingPlatIds;

	public int Index;

	public bool CanHit;

	public LevelMapData levelMapData;

	public void DoExecute(int enterId)
	{
		foreach (PlatformTriggerData trigger in triggers)
		{
			if (!trigger.TargetMovingPlatIds.Contains(enterId))
			{
				break;
			}
			if (!((Object)(object)levelMapData != null) || trigger.MovingPlatIds == null)
			{
				continue;
			}
			foreach (int movingPlatId in trigger.MovingPlatIds)
			{
				levelMapData.SetHitVolumeParamCanHit(movingPlatId, trigger.Index, trigger.CanHit);
			}
		}
	}

	public void Convert(List<SetHitPlatformCanHitTrigger> inputs)
	{
		triggers.Clear();
		foreach (SetHitPlatformCanHitTrigger input in inputs)
		{
			triggers.Add(new PlatformTriggerData
			{
				TargetMovingPlatIds = input.TargetMovingPlatIds,
				MovingPlatIds = input.MovingPlatIds,
				Index = input.Index,
				CanHit = input.CanHit
			});
		}
	}
}
