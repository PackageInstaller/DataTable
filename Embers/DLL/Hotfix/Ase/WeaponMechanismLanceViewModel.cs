using Ase.ECS;
using GameFramework.Runtime;

namespace Ase;

public class WeaponMechanismLanceViewModel : WeaponMechanismViewModel
{
	public float segmentNum;

	public int segmentCount;

	public bool InitFinish;

	public WeaponMechanismLanceViewModel(WeaponEnum weaponEnum, ObservableDictionary<string, Ase.ECS.PropertyData> propertyList)
		: base(weaponEnum, propertyList)
	{
	}
}
