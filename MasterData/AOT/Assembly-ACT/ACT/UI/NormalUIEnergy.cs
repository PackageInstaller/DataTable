using ACT.Battle;
using Bamboo.ECS;

namespace ACT.UI;

public class NormalUIEnergy : EnergyBase
{
	public TouchUIMaskEnergy battleEnergy;

	public override void Init(Ability ab)
	{
		battleEnergy.value = ab.owner.GetCompAbility().EnergyValue;
	}

	public override void SwitchRefresh()
	{
		battleEnergy.SetValue();
	}
}
