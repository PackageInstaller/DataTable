using GameFramework.Runtime;

namespace Ase;

public class AttributeItemData : ViewModelBase
{
	private string iconPath;

	private string attributeName;

	private string showValue;

	private int attributeId;

	public int AttributeId => attributeId;

	public string AttributeName
	{
		get
		{
			return attributeName;
		}
		private set
		{
			Set(ref attributeName, value, "AttributeName");
		}
	}

	public string IconPath
	{
		get
		{
			return iconPath;
		}
		private set
		{
			Set(ref iconPath, value, "IconPath");
		}
	}

	public string ShowValue
	{
		get
		{
			return showValue;
		}
		private set
		{
			Set(ref showValue, value, "ShowValue");
		}
	}

	public AttributeItemData()
	{
	}

	public AttributeItemData(EquipAttribute attributeData, float affixValue)
	{
		RefreshData(attributeData, affixValue);
	}

	public void RefreshData(EquipAttribute attributeData, float affixValue)
	{
		if (attributeData == null)
		{
			AttributeName = string.Empty;
			ShowValue = string.Empty;
			IconPath = string.Empty;
			attributeId = 0;
			return;
		}
		attributeId = attributeData.Id;
		IconPath = attributeData.Icon;
		AttributeName = attributeData.AttributeName;
		switch (attributeData.AffixType)
		{
		case 1:
			ShowValue = NumericalExtension.GetOuterDisplayValue(affixValue);
			break;
		case 2:
			ShowValue = NumericalExtension.GetOuterDisplayPercentValue(affixValue);
			break;
		case 3:
			ShowValue = "";
			break;
		}
	}

	public AttributeItemData(EquipAttribute attributeData, bool addCharacter = false)
	{
		if (attributeData == null)
		{
			AttributeName = string.Empty;
			ShowValue = string.Empty;
			IconPath = string.Empty;
			attributeId = 0;
			return;
		}
		attributeId = attributeData.Id;
		IconPath = attributeData.Icon;
		AttributeName = attributeData.AttributeName;
		switch (attributeData.AffixType)
		{
		case 1:
			ShowValue = NumericalExtension.GetOuterDisplayValue(attributeData.BaseValue) ?? "";
			if (addCharacter)
			{
				ShowValue = "+" + ShowValue;
			}
			break;
		case 2:
			ShowValue = NumericalExtension.GetOuterDisplayPercentValue(attributeData.BaseValue);
			if (addCharacter)
			{
				ShowValue = "+" + ShowValue;
			}
			break;
		case 3:
			ShowValue = "";
			break;
		}
	}
}
