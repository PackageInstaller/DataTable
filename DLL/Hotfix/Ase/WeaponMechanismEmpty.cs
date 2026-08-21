using Ase.ECS;

namespace Ase;

public class WeaponMechanismEmpty : WeaponMechanismBase
{
	public WeaponMechanismEmpty(BaseEntity entity, DRHero heroCfg, WeaponMechanismViewModel viewModel)
		: base(entity, heroCfg, viewModel)
	{
	}

	protected override void OnUpdate(float deltaTime, float timeScaleDeltaTime)
	{
	}
}
