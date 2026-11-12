using AIScript.Monster.Template;

namespace AIScript.Monster._13700011Drone;

public class Action : AIScript.Monster.Template.Action
{
	public override LogicEntity SearchTarget()
	{
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		if (activedPlayerActor != null && activedPlayerActor.attackTarget is AdventureActor adventureActor && adventureActor.actorHealthInfo.isAlive && !adventureActor.searchedImmunity)
		{
			return activedPlayerActor.attackTarget;
		}
		return _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false);
	}
}
