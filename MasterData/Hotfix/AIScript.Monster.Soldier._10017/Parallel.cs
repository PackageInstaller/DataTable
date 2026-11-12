namespace AIScript.Monster.Soldier._10017;

public class Parallel : AIBase
{
	private const float energyRecoverRateBonus = 2f;

	private int _potentialLv = 1;

	public void OnEnable()
	{
		SoldierActor soldierActor = _actor as SoldierActor;
		_potentialLv = soldierActor.GetPotentialLv();
		if (_potentialLv >= 2)
		{
			soldierActor.SetEnergyRecoverRateFP(soldierActor.EnergyRecoverRateFP + 2f);
		}
	}

	public void OnDisable()
	{
	}
}
