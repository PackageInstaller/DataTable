using UnityEngine;

namespace Ase;

public class WeaponItemData : KnapsackItemViewModel
{
	private WeaponData data;

	private Color _weaponBgColor;

	private Color _weaponFrameColor;

	private string refine;

	public WeaponData Data
	{
		get
		{
			return data;
		}
		private set
		{
			Set(ref data, value, "Data");
		}
	}

	public string Refine
	{
		get
		{
			return refine;
		}
		private set
		{
			Set(ref refine, value, "Refine");
		}
	}

	public Color WeaponBgColor => _weaponBgColor;

	public Color WeaponFrameColor => _weaponFrameColor;

	public WeaponItemData(OptionBase parent, WeaponData data, int heroId = 0, bool isActive = false)
		: base(parent, data)
	{
		this.data = data;
		base.New = data.New;
		SetOwnerId(heroId);
		ShowOwner = true;
		_weaponBgColor = WeaponItem.WeaponBgColor(data.Rarity);
		_weaponFrameColor = WeaponItem.WeaponFrameColor(data.Rarity);
		base.IsActive = isActive;
		Refine = ((data.WeaponRefine == 5) ? $"<color=#ff961d>{data.WeaponRefine}</color>" : $"{data.WeaponRefine}");
	}

	public void ChangeHeldHeroId(int heroId)
	{
		SetOwnerId(heroId);
	}

	public void ChangeHeldHeroId(HeroModel hero)
	{
		SetOwnerId(hero);
	}
}
