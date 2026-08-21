public interface IEquipOwnerContext : ICombatSourceContext
{
	bool CanSpendEquipEnergy(float amount);

	void SpendEquipEnergy(float amount);

	bool CanActivateEquip();
}
