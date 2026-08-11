using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Serializable]
public class CampaignTriggerData
{
	public bool isTrigger;

	public CampaignTriggerType triggerType;

	public Vector3 triggerPos;

	public Vector3 triggerRot;

	public Vector3 triggerScale = Vector3.one;

	public float delayTime;

	public int triggerCount = 1;

	public float winEnterTime;

	public int monsterGroupId;

	public List<int> buffNodeIds = new List<int>();

	public int popupId;

	public PopupTipType popupTipType;

	public CampaignTriggerData Clone()
	{
		return new CampaignTriggerData
		{
			isTrigger = isTrigger,
			triggerType = triggerType,
			triggerPos = triggerPos,
			triggerRot = triggerRot,
			triggerScale = triggerScale,
			delayTime = delayTime,
			triggerCount = triggerCount,
			winEnterTime = winEnterTime,
			monsterGroupId = monsterGroupId,
			buffNodeIds = ((buffNodeIds != null) ? new List<int>(buffNodeIds) : null),
			popupId = popupId,
			popupTipType = popupTipType
		};
	}
}
