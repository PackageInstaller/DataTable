using GameFramework.Runtime;

namespace Ase;

public class HeroMechanicData : ViewModelBase
{
	private WeaponActiveViewModel weaponActiveData;

	public WeaponActiveViewModel WeaponActiveData => weaponActiveData;

	public HeroMechanicData(WeaponEnum weaponType)
	{
		weaponActiveData = new WeaponActiveViewModel(weaponType);
	}
}
