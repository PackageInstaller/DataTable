using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class CampaignBuffNode
{
	private readonly CampaignBattleContext context;

	public CampaignBuffData Data { get; }

	public int BuffNodeId => Data?.buffNodeId ?? 0;

	public CampaignBuffNode(CampaignBuffData data, CampaignBattleContext context)
	{
		Data = data;
		this.context = context;
	}

	public void Apply(CampaignMonsterGroup ownerGroup = null, CampaignMonsterNode ownerNode = null, CampaignTriggerData triggerData = null)
	{
		if (Data != null)
		{
			List<int> list = CollectionPool<List<int>, int>.Get();
			AddFixedBuffIds(list);
			int randomBuffFromGroup = GetRandomBuffFromGroup(Data.randomBuffGroupId);
			if (randomBuffFromGroup > 0)
			{
				list.Add(randomBuffFromGroup);
			}
			if (list.Count == 0)
			{
				CollectionPool<List<int>, int>.Release(list);
				return;
			}
			float duration = ((Data.durationType == CampaignBuffDurationType.TimeLimit) ? Data.duration : 0f);
			context.ApplyConfiguredBuff(Data, list, duration, ownerGroup, ownerNode, triggerData);
			CollectionPool<List<int>, int>.Release(list);
		}
	}

	private void AddFixedBuffIds(List<int> resolvedBuffIds)
	{
		if (Data?.buffIds == null)
		{
			return;
		}
		for (int i = 0; i < Data.buffIds.Count; i++)
		{
			if (Data.buffIds[i] > 0)
			{
				resolvedBuffIds.Add(Data.buffIds[i]);
			}
		}
	}

	private int GetRandomBuffFromGroup(int randomBuffGroupId)
	{
		if (randomBuffGroupId <= 0)
		{
			return 0;
		}
		DRRandomBuff dataRow = GameEntry.DataTable.GetDataRow<DRRandomBuff>(randomBuffGroupId);
		if (dataRow == null)
		{
			return 0;
		}
		int randomBuffGroupIndex = GetRandomBuffGroupIndex(dataRow);
		if (randomBuffGroupIndex < 0)
		{
			return 0;
		}
		int randomBuffId = GetRandomBuffId(dataRow, randomBuffGroupIndex);
		_ = 0;
		return randomBuffId;
	}

	private int GetRandomBuffGroupIndex(DRRandomBuff drRandomBuff)
	{
		if (drRandomBuff?.BuffGroup == null || drRandomBuff.WeightGroup == null)
		{
			return -1;
		}
		int num = Mathf.Min(drRandomBuff.BuffGroup.Count, drRandomBuff.WeightGroup.Count);
		int num2 = 0;
		for (int i = 0; i < num; i++)
		{
			num2 += GetValidWeightTotal(drRandomBuff.BuffGroup[i], drRandomBuff.WeightGroup[i]);
		}
		if (num2 <= 0)
		{
			return -1;
		}
		int num3 = context.RandomInt(0, num2);
		int num4 = 0;
		for (int j = 0; j < num; j++)
		{
			int validWeightTotal = GetValidWeightTotal(drRandomBuff.BuffGroup[j], drRandomBuff.WeightGroup[j]);
			if (validWeightTotal > 0)
			{
				num4 += validWeightTotal;
				if (num3 < num4)
				{
					return j;
				}
			}
		}
		return -1;
	}

	private int GetRandomBuffId(DRRandomBuff drRandomBuff, int buffGroupIndex)
	{
		if (drRandomBuff?.BuffGroup == null || drRandomBuff.WeightGroup == null || buffGroupIndex < 0 || buffGroupIndex >= drRandomBuff.BuffGroup.Count || buffGroupIndex >= drRandomBuff.WeightGroup.Count)
		{
			return 0;
		}
		List<int> list = drRandomBuff.BuffGroup[buffGroupIndex];
		List<int> list2 = drRandomBuff.WeightGroup[buffGroupIndex];
		int validWeightTotal = GetValidWeightTotal(list, list2);
		if (validWeightTotal <= 0)
		{
			return 0;
		}
		int num = context.RandomInt(0, validWeightTotal);
		int num2 = 0;
		int num3 = Mathf.Min(list.Count, list2.Count);
		for (int i = 0; i < num3; i++)
		{
			if (list[i] > 0 && list2[i] > 0)
			{
				num2 += list2[i];
				if (num < num2)
				{
					return list[i];
				}
			}
		}
		return 0;
	}

	private static int GetValidWeightTotal(List<int> buffGroup, List<int> weightGroup)
	{
		if (buffGroup == null || weightGroup == null)
		{
			return 0;
		}
		int num = 0;
		int num2 = Mathf.Min(buffGroup.Count, weightGroup.Count);
		for (int i = 0; i < num2; i++)
		{
			if (buffGroup[i] > 0 && weightGroup[i] > 0)
			{
				num += weightGroup[i];
			}
		}
		return num;
	}
}
