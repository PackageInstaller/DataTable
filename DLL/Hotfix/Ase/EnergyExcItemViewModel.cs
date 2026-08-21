namespace Ase;

public class EnergyExcItemViewModel : KnapsackItemViewModel
{
	private string _itemName;

	private string _itemDesc;

	private int _type;

	private PropDataBase _propDataBase;

	public string ItemName => _itemName;

	public string ItemDesc
	{
		get
		{
			return _itemDesc;
		}
		set
		{
			Set(ref _itemDesc, value, "ItemDesc");
		}
	}

	public int Type => _type;

	public EnergyExcItemViewModel(OptionBase parent, PropDataBase propData, string desc, int type)
		: base(parent, propData)
	{
		base.parent = parent;
		_propDataBase = propData;
		_itemName = propData.Name;
		_itemDesc = desc;
		_type = type;
	}

	public void RefreshAmount(int amount)
	{
		_propDataBase.Amount = amount;
	}
}
