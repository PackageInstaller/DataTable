using GameFramework;

namespace Ase;

public class BuffDataWeapon : BuffDataProperty
{
	public override BuffOperationType EffectType => BuffOperationType.Weapon;

	public static BuffDataWeapon Create(string propertyKey, float propertyValue, ChangeType changeType, PropertyType propertyType)
	{
		BuffDataWeapon buffDataWeapon = ReferencePool.Acquire<BuffDataWeapon>();
		buffDataWeapon.propertyKey = propertyKey;
		buffDataWeapon.propertyValue = propertyValue;
		buffDataWeapon.changeType = changeType;
		buffDataWeapon.propertyType = propertyType;
		return buffDataWeapon;
	}
}
