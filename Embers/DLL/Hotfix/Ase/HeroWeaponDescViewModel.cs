using GameFramework.Runtime;

namespace Ase;

public class HeroWeaponDescViewModel : OptionBase
{
	public InteractionRequest<WeaponEnum> showWeaponRequest = new InteractionRequest<WeaponEnum>();

	private WeaponEnum curHeroWeaponEnum;

	public IInteractionRequest ShowWeaponRequest => showWeaponRequest;

	public WeaponEnum CurHeroWeaponEnum => curHeroWeaponEnum;

	public HeroWeaponDescViewModel()
	{
	}

	public HeroWeaponDescViewModel(OptionBase parent, WeaponEnum weaponEnum)
	{
		base.parent = parent;
		curHeroWeaponEnum = weaponEnum;
	}

	public void SetWeaponEnum(WeaponEnum weaponEnum)
	{
		curHeroWeaponEnum = weaponEnum;
	}

	public void OnButtonClick(WeaponEnum weaponEnum)
	{
		showWeaponRequest.Raise(weaponEnum);
	}
}
