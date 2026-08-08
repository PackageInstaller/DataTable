using UnityEngine;

public interface IWeaponContinuousMeleeContextProvider
{
	bool TryResolveContinuousMeleeContext(int slotIndex, SummerRaceWeaponSpec spec, out Vector2 attackOrigin, out Vector2 attackDirection);

	float ResolveContinuousMeleeTickInterval(int slotIndex, SummerRaceWeaponSpec spec);
}
