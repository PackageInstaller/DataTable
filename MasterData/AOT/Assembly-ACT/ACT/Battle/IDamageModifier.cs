namespace ACT.Battle;

public interface IDamageModifier
{
	int Priority { get; }

	DamageModifierSide Side { get; }

	bool IsValid { get; }

	void Modify(AttackData attackData, Ability sourceAbility);
}
