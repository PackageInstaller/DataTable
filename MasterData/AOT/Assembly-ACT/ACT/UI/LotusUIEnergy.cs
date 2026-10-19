using ACT.Battle;
using Bamboo.ECS;

namespace ACT.UI;

public class LotusUIEnergy : EnergyBase
{
	public LotusTouchUIMaskEnergy battleEnergy;

	public override void Init(Ability ab)
	{
		battleEnergy.value = ab.owner.GetCompAbility().EnergyValue;
	}

	public override void SwitchRefresh()
	{
		battleEnergy.SetValue();
	}
}
