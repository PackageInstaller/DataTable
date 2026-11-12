namespace AIScript.Monster.Soldier._13021;

public class Parallel : AIBase
{
	private const int buffId_battle_2 = 250102703;

	private const int buffId_support_2 = 250102701;

	private const int buffId_battle_3 = 250102704;

	private const int buffId_support_3 = 250102702;

	public void OnEnable()
	{
		SoldierActor soldierActor = _actor as SoldierActor;
		int potentialLv = soldierActor.GetPotentialLv();
		if (potentialLv >= 2)
		{
			int buffID;
			if (soldierActor.isSupport)
			{
				buffID = ((potentialLv >= 3) ? 250102702 : 250102701);
			}
			else
			{
				buffID = ((potentialLv >= 3) ? 250102704 : 250102703);
			}
			_actor.buffComponent.AddBuff(buffID, _actor);
		}
	}

	public void OnDisable()
	{
	}
}
