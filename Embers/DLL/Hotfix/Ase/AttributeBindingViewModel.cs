using System.Collections.Generic;

namespace Ase;

public class AttributeBindingViewModel : OptionBase
{
	private string attributeBindText;

	private string attributeBindIcon;

	private List<AttributeBindItemData> attributeBindItemList;

	private List<HeroAttributeEnum> attributeEnumList;

	private bool showTip;

	public bool ShowTip
	{
		get
		{
			return showTip;
		}
		private set
		{
			Set(ref showTip, value, "ShowTip");
		}
	}

	public string AttributeBindIcon => attributeBindIcon;

	public string AttributeBindText => attributeBindText;

	public List<AttributeBindItemData> AttributeBindItemList => attributeBindItemList;

	public AttributeBindingViewModel(OptionBase parent, List<HeroModel> heroModelList)
	{
		base.parent = parent;
		attributeEnumList = new List<HeroAttributeEnum>();
		attributeBindItemList = new List<AttributeBindItemData>();
		List<int> list = new List<int>();
		foreach (HeroModel heroModel in heroModelList)
		{
			if (heroModel != null)
			{
				if (list.Find((int p) => p.Equals(heroModel.Id)) == 0)
				{
					list.Add(heroModel.Id);
					attributeEnumList.Add(heroModel.Attribute);
				}
				attributeBindItemList.Add(new AttributeBindItemData(heroModel.Id, heroModel.Attribute));
			}
			else
			{
				attributeBindItemList.Add(new AttributeBindItemData(0));
			}
		}
		CheckAttributeBind();
	}

	private void CheckAttributeBind()
	{
		attributeBindText = "<color=#656464>未激活</color>";
		attributeBindIcon = "empty";
		if (attributeEnumList.Count <= 1)
		{
			return;
		}
		if (attributeEnumList.Count == 2)
		{
			if (attributeEnumList[0] == attributeEnumList[1])
			{
				SetAttributeBindText(attributeEnumList[0]);
			}
		}
		else if (attributeEnumList[0] == attributeEnumList[1] || attributeEnumList[0] == attributeEnumList[2])
		{
			SetAttributeBindText(attributeEnumList[0]);
		}
		else if (attributeEnumList[1] == attributeEnumList[2])
		{
			SetAttributeBindText(attributeEnumList[1]);
		}
	}

	private void SetAttributeBindText(HeroAttributeEnum heroAttributeEnum)
	{
		DRAttributeMatching dataRow = GameEntry.DataTable.GetDataRow((DRAttributeMatching p) => p.HeroAttributeEnum == heroAttributeEnum);
		if (dataRow != null)
		{
			attributeBindIcon = $"hero_attr_{(int)heroAttributeEnum}";
			if (dataRow.EffectValue.Count == 1)
			{
				string arg = ((dataRow.EffectType[0] == 1) ? $"{dataRow.EffectValue[0][1]}" : $"{dataRow.EffectValue[0][1]}%");
				attributeBindText = string.Format(dataRow.AttributeEffectDesc, arg);
			}
			else if (dataRow.EffectValue.Count == 2)
			{
				string arg2 = ((dataRow.EffectType[0] == 1) ? $"{dataRow.EffectValue[0][1]}" : $"{dataRow.EffectValue[0][1]}%");
				string arg3 = ((dataRow.EffectType[0] == 1) ? $"{dataRow.EffectValue[1][1]}" : $"{dataRow.EffectValue[1][1]}%");
				attributeBindText = string.Format(dataRow.AttributeEffectDesc, arg2, arg3);
			}
		}
	}

	public void TipBtnOnClick()
	{
		ShowTip = !ShowTip;
	}
}
