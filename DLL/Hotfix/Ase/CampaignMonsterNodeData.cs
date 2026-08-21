using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Serializable]
public class CampaignMonsterNodeData
{
	public int monsterIndex;

	public int monsterNodeKey;

	public int monsterId;

	public Vector3 monsterPos;

	public Vector3 monsterRot;

	public CampaignMonsterGroupActiveType activeType = CampaignMonsterGroupActiveType.FollowGroup;

	public float monsterDelay;

	public int monsterStartConditionKey;

	public float monsterKillDelay;

	public List<int> bornBuffNodeIds;

	public List<int> deadBuffNodeIds;

	public CampaignMonsterNodeData Clone()
	{
		return new CampaignMonsterNodeData
		{
			monsterId = monsterId,
			monsterStartConditionKey = monsterStartConditionKey,
			monsterKillDelay = monsterKillDelay,
			monsterNodeKey = monsterNodeKey,
			monsterPos = monsterPos,
			monsterRot = monsterRot,
			activeType = activeType,
			monsterDelay = monsterDelay,
			monsterIndex = monsterIndex,
			bornBuffNodeIds = ((bornBuffNodeIds != null) ? new List<int>(bornBuffNodeIds) : null),
			deadBuffNodeIds = ((deadBuffNodeIds != null) ? new List<int>(deadBuffNodeIds) : null)
		};
	}
}
