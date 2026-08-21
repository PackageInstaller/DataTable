using GameFramework.Runtime;

namespace Ase;

public class AttributeUpgradeItemData : ViewModelBase
{
	private EquipAttribute _attributeData;

	private string _showValue1;

	private string _showValue2;

	private bool _isAttribute;

	private string _descText;

	private string _descValue;

	public EquipAttribute AttributeData => _attributeData;

	public string ShowValue1 => _showValue1;

	public string ShowValue2 => _showValue2;

	public bool IsAttribute => _isAttribute;

	public string DescText => _descText;

	public string DescValue => _descValue;

	public AttributeUpgradeItemData(EquipAttribute attributeData, float value)
	{
		_attributeData = attributeData;
		_showValue1 = GetShowValue(attributeData.BaseValue, attributeData.AffixType);
		_showValue2 = GetShowValue(value, attributeData.AffixType);
		_isAttribute = true;
	}

	public AttributeUpgradeItemData(float value1, float value2)
	{
		_showValue1 = GetShowValue(value1, 1);
		_showValue2 = GetShowValue(value2, 1);
		_isAttribute = true;
	}

	public AttributeUpgradeItemData(EquipAttribute attributeData1, float value1, float value2)
	{
		_attributeData = attributeData1;
		_showValue1 = GetShowValue(value1, attributeData1.AffixType);
		_showValue2 = GetShowValue(value2, attributeData1.AffixType);
		_isAttribute = true;
	}

	public AttributeUpgradeItemData(string descText, string descValue)
	{
		_descText = descText;
		_descValue = descValue;
		_isAttribute = false;
	}

	public AttributeUpgradeItemData(EquipAttribute attributeData)
	{
		_descText = attributeData.AttributeName;
		_descValue = GetShowValue(attributeData.BaseValue, attributeData.AffixType);
		_isAttribute = false;
	}

	private string GetShowValue(float value, int affixType)
	{
		string text = "";
		return affixType switch
		{
			1 => NumericalExtension.GetOuterDisplayValue(value), 
			2 => NumericalExtension.GetOuterDisplayPercentValue(value), 
			_ => text, 
		};
	}
}
