using Ase.ECS;

namespace Ase;

public class StateTenacityFormulaZone : TenacityFormulaZoneBase<StateTenacityFormulaData>
{
	protected override void OnCalcFormulaZone()
	{
		CalcStateAddition();
	}

	protected void CalcStateAddition()
	{
		StateComponent stateComponent = defender?.GetComponent<StateComponent>();
		if (stateComponent != null)
		{
			dataBase.stateAddition = stateComponent.GetEntityStateTenacityRatio();
		}
	}
}
