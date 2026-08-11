using System.Collections.Generic;

namespace Ase;

public class HCTalentData
{
	private int skillId;

	private int bigLevel;

	private int smallOrder;

	private List<int> smallOrderList;

	public int SkillId => skillId;

	public int BigLevel => bigLevel;

	public int SmallOrder => smallOrder;

	public List<int> SmallOrderList => smallOrderList;

	public static HCTalentData Create(int skillId, int bigLevel, int smallOrder)
	{
		HCTalentData hCTalentData = new HCTalentData();
		hCTalentData.skillId = skillId;
		hCTalentData.bigLevel = bigLevel;
		hCTalentData.smallOrder = smallOrder;
		hCTalentData.smallOrderList = new List<int>();
		DRHeroTalentSmall[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroTalentSmall p) => p.SkillId == skillId && p.Order <= smallOrder);
		if (dataRows != null)
		{
			for (int num = 0; num < dataRows.Length; num++)
			{
				hCTalentData.smallOrderList.Add(dataRows[num].Order);
			}
		}
		return hCTalentData;
	}

	public static HCTalentData Create(int skillId)
	{
		HCTalentData hCTalentData = new HCTalentData();
		hCTalentData.skillId = skillId;
		hCTalentData.bigLevel = 0;
		hCTalentData.smallOrder = 503;
		hCTalentData.smallOrderList = new List<int>();
		DRHeroTalentSmall[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroTalentSmall p) => p.SkillId == skillId && p.Order <= 999);
		if (dataRows != null)
		{
			for (int num = 0; num < dataRows.Length; num++)
			{
				hCTalentData.smallOrderList.Add(dataRows[num].Order);
			}
		}
		return hCTalentData;
	}

	public void UpdateData(int order, HCSPointType pointType)
	{
		if (pointType == HCSPointType.Big)
		{
			bigLevel = order;
			return;
		}
		smallOrder = order;
		smallOrderList.Clear();
		DRHeroTalentSmall[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroTalentSmall p) => p.SkillId == skillId && p.Order <= smallOrder);
		if (dataRows != null)
		{
			for (int num = 0; num < dataRows.Length; num++)
			{
				smallOrderList.Add(dataRows[num].Order);
			}
		}
	}

	public void Replace(HCTalentData newTalentData)
	{
		bigLevel = newTalentData.bigLevel;
		smallOrder = newTalentData.smallOrder;
		smallOrderList.Clear();
		for (int i = 0; i < newTalentData.smallOrderList.Count; i++)
		{
			smallOrderList.Add(newTalentData.smallOrderList[i]);
		}
	}
}
