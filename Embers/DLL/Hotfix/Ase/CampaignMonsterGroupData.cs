using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Serializable]
public class CampaignMonsterGroupData
{
	public int groupId;

	public Vector3 monsterGroupPos;

	public bool enableRange;

	public float alertAreaRange;

	public float activityAreaRange;

	public Vector2 activityAreaRangeOffset;

	public bool controlAirWall;

	public List<int> airWallIds;

	public CampaignMonsterGroupActiveType activeType;

	public bool startActive = true;

	public float delayTime;

	public float delayBornTime;

	public int otherGroupId;

	public List<int> bornBuffNodeIds;

	public List<int> deadBuffNodeIds;

	public bool openPopupOnActive;

	public int activePopupId;

	public PopupTipType activePopupTipType;

	public bool addEventOnComplete;

	public CampaignTriggerType addEvent;

	public float nextGroupDelayBornTime;

	public int nextGroupId;

	public List<int> completeBuffNodeIds;

	public int completePopupId;

	public PopupTipType completePopupTipType;

	public bool fixedMonsterCount;

	public int fixedMonsterCountValue;

	public List<int> fixedMonsterLoadOrder;

	public List<CampaignMonsterNodeData> monsterNodes;

	public CampaignMonsterGroupData Clone()
	{
		List<CampaignMonsterNodeData> list = null;
		if (monsterNodes != null)
		{
			list = new List<CampaignMonsterNodeData>(monsterNodes.Count);
			foreach (CampaignMonsterNodeData monsterNode in monsterNodes)
			{
				list.Add(monsterNode?.Clone());
			}
		}
		List<int> list2 = ((fixedMonsterLoadOrder != null) ? new List<int>(fixedMonsterLoadOrder) : null);
		return new CampaignMonsterGroupData
		{
			groupId = groupId,
			monsterGroupPos = monsterGroupPos,
			enableRange = enableRange,
			alertAreaRange = alertAreaRange,
			activityAreaRange = activityAreaRange,
			activityAreaRangeOffset = activityAreaRangeOffset,
			controlAirWall = controlAirWall,
			airWallIds = ((airWallIds != null) ? new List<int>(airWallIds) : null),
			activeType = activeType,
			startActive = startActive,
			delayTime = delayTime,
			delayBornTime = delayBornTime,
			otherGroupId = otherGroupId,
			bornBuffNodeIds = ((bornBuffNodeIds != null) ? new List<int>(bornBuffNodeIds) : null),
			deadBuffNodeIds = ((deadBuffNodeIds != null) ? new List<int>(deadBuffNodeIds) : null),
			openPopupOnActive = openPopupOnActive,
			activePopupId = activePopupId,
			activePopupTipType = activePopupTipType,
			addEventOnComplete = addEventOnComplete,
			addEvent = addEvent,
			nextGroupDelayBornTime = nextGroupDelayBornTime,
			nextGroupId = nextGroupId,
			completeBuffNodeIds = ((completeBuffNodeIds != null) ? new List<int>(completeBuffNodeIds) : null),
			completePopupId = completePopupId,
			completePopupTipType = completePopupTipType,
			fixedMonsterCount = fixedMonsterCount,
			fixedMonsterCountValue = fixedMonsterCountValue,
			fixedMonsterLoadOrder = list2,
			monsterNodes = list
		};
	}
}
