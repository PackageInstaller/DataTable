using TrueSync;

namespace AIScript.Monster.Soldier._50801;

public class Parallel : AIBase
{
	private const int giftBoxItemId_1 = 40;

	private const int giftBoxItemId_3 = 40;

	private const int giftBoxCountMin_1 = 1;

	private const int giftBoxCountMax_1 = 2;

	private const int giftBoxCountMin_3 = 5;

	private const int giftBoxCountMax_3 = 10;

	private int _potentialLv = 1;

	private bool _supportRewardGranted;

	private SoldierActor soldierActor => _actor as SoldierActor;

	public void OnEnable()
	{
		_potentialLv = ((!(soldierActor != null)) ? 1 : soldierActor.GetPotentialLv());
		_supportRewardGranted = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	private void OnActorDied(IEvent evt)
	{
		if (!(evt is AdventureActorDiedEvent adventureActorDiedEvent) || _supportRewardGranted || this.soldierActor == null || !this.soldierActor.isSupport || !(adventureActorDiedEvent.actor is SoldierActor soldierActor) || soldierActor == this.soldierActor || soldierActor.isSupport || soldierActor.isEnemyCamp)
		{
			return;
		}
		_supportRewardGranted = true;
		this.soldierActor.PromoteToBattle();
		SoldierLevelController soldierLevelController = ModuleController<AdventureModuleController>.Instance?.levelInstance as SoldierLevelController;
		if (!(soldierLevelController == null))
		{
			if (_potentialLv <= 2)
			{
				soldierLevelController.AddItem(40, TSRandom.Range(1, 3));
			}
			if (_potentialLv >= 3)
			{
				this.soldierActor.SetEnergy(this.soldierActor.maxEnergy);
				soldierLevelController.AddItem(40, TSRandom.Range(5, 11));
			}
		}
	}
}
