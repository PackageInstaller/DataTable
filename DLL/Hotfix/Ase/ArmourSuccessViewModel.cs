using System.Collections.Generic;

namespace Ase;

public class ArmourSuccessViewModel : OptionBase
{
	private ArmourData armourData;

	private int oldLevel;

	private string rate;

	private List<AttributeUpgradeItemData> mainAttributeItemList;

	private List<AttributeUpgradeItemData> subAttributeItemList;

	public ArmourData ArmourData => armourData;

	public int OldLevel => oldLevel;

	public List<AttributeUpgradeItemData> MainAttributeItemList => mainAttributeItemList;

	public List<AttributeUpgradeItemData> SubAttributeItemList => subAttributeItemList;

	public ArmourSuccessViewModel(ArmourData armourData, Dictionary<int, float> oldAttributeData, int oldLevel)
	{
		this.armourData = armourData;
		this.oldLevel = oldLevel;
		mainAttributeItemList = new List<AttributeUpgradeItemData>();
		subAttributeItemList = new List<AttributeUpgradeItemData>();
		DREquipment dataRow = GameEntry.DataTable.GetDataRow((DREquipment p) => p.TypeId == armourData.TypeId && p.RankMin == armourData.Rank);
		for (int num = 0; num < dataRow.DefenseAttribute.Count; num++)
		{
			if (ArmourData.GetMainAttribute().Id == dataRow.DefenseAttribute[num])
			{
				float value = ((float)dataRow.DefenseBase[num] + (float)(oldLevel * dataRow.DefenseGrow[num])) / 10000f;
				mainAttributeItemList.Add(new AttributeUpgradeItemData(ArmourData.EquipAttributeList[0], value, ArmourData.EquipAttributeList[0].BaseValue));
				break;
			}
		}
		foreach (EquipAttribute item in ArmourData.GetSubAttribute())
		{
			if (oldAttributeData.ContainsKey(item.Id))
			{
				if (oldAttributeData[item.Id] != item.BaseValue)
				{
					subAttributeItemList.Add(new AttributeUpgradeItemData(item, oldAttributeData[item.Id], item.BaseValue));
				}
			}
			else
			{
				subAttributeItemList.Add(new AttributeUpgradeItemData(item));
			}
		}
	}
}
