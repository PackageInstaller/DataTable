using AIScript.Monster.Template;

namespace AIScript.Monster._14700011DevilSpeaker;

public class Action : AIScript.Monster.Template.Action
{
	public PlayerAdventureActor mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	public override LogicEntity SearchTarget()
	{
		if (mainCtrActor == null)
		{
			return _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false);
		}
		if (mainCtrActor.attackTarget == null)
		{
			return _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false);
		}
		return mainCtrActor.attackTarget;
	}
}
