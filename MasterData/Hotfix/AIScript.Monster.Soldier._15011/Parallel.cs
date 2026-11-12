using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._15011;

public class Parallel : AIBase
{
	private const int buffId_3 = 250102601;

	private static readonly FP tickInterval = 1;

	private int PotentialLv = 1;

	private CoroutineNode corAura;

	private readonly List<SoldierActor> _buffer = new List<SoldierActor>();

	private bool _auraAdded;

	private SoldierActor soldierActor => _actor as SoldierActor;

	public void OnEnable()
	{
		PotentialLv = ((!(soldierActor != null)) ? 1 : soldierActor.GetPotentialLv());
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		if (PotentialLv >= 3)
		{
			StartCoroutine(ref corAura, AuraTick());
		}
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		StopCoroutine(ref corAura);
		_buffer.Clear();
	}

	private IEnumerator AuraTick()
	{
		while (!(soldierActor == null))
		{
			if (soldierActor.isSupport)
			{
				if (_auraAdded)
				{
					RemoveAuraFromAll();
					_auraAdded = false;
				}
			}
			else if (!_auraAdded)
			{
				AddAuraToAll();
				_auraAdded = true;
			}
			yield return _actor.WaitTime(tickInterval);
		}
	}

	private void AddAuraToAll()
	{
		List<SoldierActor> list = ((ModuleController<AdventureModuleController>.Instance?.levelInstance is SoldierLevelController soldierLevelController) ? soldierLevelController.GetAllActors(_actor, _buffer) : null);
		if (list == null)
		{
			return;
		}
		for (int i = 0; i < list.Count; i++)
		{
			SoldierActor soldierActor = list.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && !(soldierActor.buffComponent == null))
			{
				soldierActor.buffComponent.AddBuff(250102601, soldierActor);
			}
		}
	}

	private void RemoveAuraFromAll()
	{
		if (!(ModuleController<AdventureModuleController>.Instance?.levelInstance is SoldierLevelController soldierLevelController))
		{
			return;
		}
		List<SoldierActor> allActors = soldierLevelController.GetAllActors(_actor, _buffer);
		for (int i = 0; i < allActors.Count; i++)
		{
			SoldierActor soldierActor = allActors.get_Item(i);
			if (!(soldierActor == null) && !(soldierActor.buffComponent == null))
			{
				soldierActor.buffComponent.RemoveBuffByBuffId(250102601);
			}
		}
	}

	private void OnActorDied(IEvent evt)
	{
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent && !(adventureActorDiedEvent.actor != _actor) && PotentialLv >= 3)
		{
			StopCoroutine(ref corAura);
			RemoveAuraFromAll();
		}
	}
}
