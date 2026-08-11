namespace Ase;

public class HeroWarehouseSortButtonViewModel : OptionBase
{
	private string _showText;

	private bool _isSelected;

	private HeroAttributeEnum _heroAttributeEnum;

	private WeaponEnum _weaponEnum;

	private HeroLocationEnum _heroLocationEnum;

	private int _type;

	public string ShowText => _showText;

	public HeroAttributeEnum HeroAttributeEnum => _heroAttributeEnum;

	public WeaponEnum WeaponEnumType => _weaponEnum;

	public HeroLocationEnum HeroLocationEnum => _heroLocationEnum;

	public int Type => _type;

	public bool IsSelected
	{
		get
		{
			return _isSelected;
		}
		set
		{
			Set(ref _isSelected, value, "IsSelected");
		}
	}

	public HeroWarehouseSortButtonViewModel(OptionBase parent, HeroAttributeEnum heroAttributeEnum)
	{
		base.parent = parent;
		_heroAttributeEnum = heroAttributeEnum;
		_isSelected = false;
		_showText = UiConvert.Hero.Attribute2Name[heroAttributeEnum];
		_type = 1;
	}

	public HeroWarehouseSortButtonViewModel(OptionBase parent, WeaponEnum weaponEnumType)
	{
		base.parent = parent;
		_weaponEnum = weaponEnumType;
		_isSelected = false;
		_showText = UiConvert.Equip.WeaponEnum2Name[weaponEnumType];
		_type = 2;
	}

	public void ButtonOnclick()
	{
		parent.ItemOnClick(this);
	}
}
