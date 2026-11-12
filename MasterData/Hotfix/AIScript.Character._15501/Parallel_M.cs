namespace AIScript.Character._15501;

public class Parallel_M : AIBase
{
	private int dieEvt = CommonHelper.StringToHash("dieEvt");

	private PlayerAdventureActor summoner;

	public void OnEnable()
	{
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		summoner = logicComponent.SummonActor as PlayerAdventureActor;
		_actor.ignoreDeterministicCollision = true;
		_actor.EnableCloseBlock();
		_actor.EnableImmuneControl();
	}

	public void OnDisable()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.eventHashCode = dieEvt;
		summoner?.DispatchEvent(adventureActorCustomEvent);
	}
}
