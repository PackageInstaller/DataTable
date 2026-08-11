using System;
using System.Collections.Generic;

namespace Ase;

[Serializable]
public class CampaignBuffData
{
	public int buffNodeId;

	public int randomBuffGroupId;

	public List<int> buffIds = new List<int>();

	public CampaignBuffTargetType targetType;

	public List<int> targetMonsterGroupIds = new List<int>();

	public CampaignBuffDurationType durationType;

	public float duration;

	public int followMonsterGroupId;

	public CampaignBuffData Clone()
	{
		return new CampaignBuffData
		{
			buffNodeId = buffNodeId,
			randomBuffGroupId = randomBuffGroupId,
			buffIds = ((buffIds != null) ? new List<int>(buffIds) : null),
			targetType = targetType,
			targetMonsterGroupIds = ((targetMonsterGroupIds != null) ? new List<int>(targetMonsterGroupIds) : null),
			durationType = durationType,
			duration = duration,
			followMonsterGroupId = followMonsterGroupId
		};
	}
}
