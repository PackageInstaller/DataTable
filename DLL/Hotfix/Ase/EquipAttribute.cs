using GameFramework.Runtime;

namespace Ase;

public class EquipAttribute : ViewModelBase
{
	private int id;

	private string icon;

	private float baseValue;

	private string attributeName;

	private string affixKey;

	private int affixType;

	public int Id
	{
		get
		{
			return id;
		}
		private set
		{
			Set(ref id, value, "Id");
		}
	}

	public string Icon
	{
		get
		{
			return icon;
		}
		private set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public float BaseValue
	{
		get
		{
			return baseValue;
		}
		set
		{
			Set(ref baseValue, value, "BaseValue");
		}
	}

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

	public string AffixKey
	{
		get
		{
			return affixKey;
		}
		private set
		{
			Set(ref affixKey, value, "AffixKey");
		}
	}

	public int AffixType
	{
		get
		{
			return affixType;
		}
		private set
		{
			Set(ref affixType, value, "AffixType");
		}
	}

	public EquipAttribute(DRAffix drAffix, float value)
	{
		if (drAffix != null)
		{
			Id = drAffix.Id;
			Icon = drAffix.Icon.ToString();
			AffixKey = drAffix.AffixKey;
			AffixType = drAffix.Type;
			AttributeName = drAffix.Desc;
			BaseValue = value;
		}
	}

	public EquipAttribute(EquipAttribute attribute)
	{
		Id = attribute.Id;
		Icon = attribute.Icon;
		AffixKey = attribute.AffixKey;
		AffixType = attribute.affixType;
		AttributeName = attribute.attributeName;
		BaseValue = attribute.baseValue;
	}
}
