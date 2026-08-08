public interface IWeaponOwnerContext : ICombatSourceContext
{
	bool CanSpendWeaponEnergy(float amount);

	void SpendWeaponEnergy(float amount);

	void RefundWeaponEnergy(float amount);

	float ResolveWeaponOverloadUntil(int slotIndex);

	void OnWeaponRuntimeFire(int slotIndex, SummerRaceWeaponSpec spec);
}
