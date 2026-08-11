namespace Ase;

public class PropertyData : ViewOptionBase
{
	private string icon = "";

	private string name;

	private double value1;

	private double value2;

	private string prefix1;

	private string prefix2;

	private string customValueText1;

	private string customValueText2;

	private bool customValue;

	private int affixType = 1;

	private string value1Text;

	private string value2Text;

	public bool CustomValue => customValue;

	public int AffixType
	{
		get
		{
			return affixType;
		}
		set
		{
			Set(ref affixType, value, "AffixType");
		}
	}

	public string CustomValueText1
	{
		get
		{
			return customValueText1;
		}
		private set
		{
			Set(ref customValueText1, value, "CustomValueText1");
		}
	}

	public string CustomValueText2
	{
		get
		{
			return customValueText2;
		}
		private set
		{
			Set(ref customValueText2, value, "CustomValueText2");
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

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public double Value1
	{
		get
		{
			return value1;
		}
		set
		{
			Set(ref value1, value, "Value1");
			Value1Text = ((affixType == 2) ? NumericalExtension.GetOuterDisplayPercentValue((float)value) : NumericalExtension.GetOuterDisplayValue(value));
		}
	}

	public string Value1Text
	{
		get
		{
			return value1Text;
		}
		set
		{
			Set(ref value1Text, value, "Value1Text");
		}
	}

	public double Value2
	{
		get
		{
			return value2;
		}
		set
		{
			Set(ref value2, value, "Value2");
			Value2Text = ((affixType == 2) ? NumericalExtension.GetOuterDisplayPercentValue(value) : NumericalExtension.GetOuterDisplayValue(value));
		}
	}

	public string Value2Text
	{
		get
		{
			return value2Text;
		}
		set
		{
			Set(ref value2Text, value, "Value2Text");
		}
	}

	public string Prefix1
	{
		get
		{
			return prefix1;
		}
		set
		{
			Set(ref prefix1, value, "Prefix1");
		}
	}

	public string Prefix2
	{
		get
		{
			return prefix2;
		}
		set
		{
			Set(ref prefix2, value, "Prefix2");
		}
	}

	public PropertyData()
	{
	}

	public PropertyData(string affixKey)
	{
		DRAffix dataRow = GameEntry.DataTable.GetDataRow((DRAffix p) => p.AffixKey.Equals(affixKey));
		if (dataRow != null)
		{
			AffixType = dataRow.Type;
			Name = dataRow.Desc;
			Icon = dataRow.Icon.ToString();
		}
	}

	public PropertyData(string affixKey, string customValueText1 = "", string customValueText2 = "")
	{
		DRAffix dataRow = GameEntry.DataTable.GetDataRow((DRAffix p) => p.AffixKey.Equals(affixKey));
		if (dataRow != null)
		{
			AffixType = dataRow.Type;
			Name = dataRow.Desc;
			Icon = dataRow.Icon.ToString();
		}
		CustomValueText1 = customValueText1;
		CustomValueText2 = customValueText2;
		customValue = true;
	}

	public PropertyData(string affixKey, string name, string customValueText1 = "", string customValueText2 = "")
	{
		DRAffix dataRow = GameEntry.DataTable.GetDataRow((DRAffix p) => p.AffixKey.Equals(affixKey));
		if (dataRow != null)
		{
			AffixType = dataRow.Type;
			Icon = dataRow.Icon.ToString();
		}
		Name = name;
		CustomValueText1 = customValueText1;
		CustomValueText2 = customValueText2;
		customValue = true;
	}

	public PropertyData(string affixKey, double value1 = 0.0, double value2 = 0.0, string prefix1 = "", string prefix2 = "")
	{
		DRAffix dataRow = GameEntry.DataTable.GetDataRow((DRAffix p) => p.AffixKey.Equals(affixKey));
		if (dataRow != null)
		{
			AffixType = dataRow.Type;
			Name = dataRow.Desc;
			Icon = dataRow.Icon.ToString();
		}
		Value1 = value1;
		Value2 = value2;
		Prefix1 = prefix1;
		Prefix2 = prefix2;
	}

	public PropertyData(string affixKey, string name, double value1 = 0.0, double value2 = 0.0, string prefix1 = "", string prefix2 = "")
	{
		DRAffix dataRow = GameEntry.DataTable.GetDataRow((DRAffix p) => p.AffixKey.Equals(affixKey));
		if (dataRow != null)
		{
			AffixType = dataRow.Type;
			Icon = dataRow.Icon.ToString();
		}
		Name = name;
		Value1 = value1;
		Value2 = value2;
		Prefix1 = prefix1;
		Prefix2 = prefix2;
	}
}
