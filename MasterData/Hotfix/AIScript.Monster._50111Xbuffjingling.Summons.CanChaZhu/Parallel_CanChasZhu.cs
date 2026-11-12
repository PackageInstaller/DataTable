using AIScript.Monster.Template;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50111Xbuffjingling.Summons.CanChaZhu;

public class Parallel_CanChasZhu : Parallel
{
	private string evtMonsterPlayLinkFx = "MonsterPlayLinkFx";

	private string evtMonsterStopLinkFx = "MonsterStopLinkFx";

	private string linkFx = "fx_50111buffjingling_Warning_line";

	private PlayFX playFX = new PlayFX();

	public override void OnStart()
	{
		base.OnStart();
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		playFX.Stop();
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent)
		{
			if (adventureActorCustomEvent.eventName.Equals(evtMonsterPlayLinkFx))
			{
				PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
				TSVector sourcePosition = new TSVector(_actor.tsTransform.Position.x, 0, _actor.tsTransform.Position.y);
				TSVector targetPosition = new TSVector(activedPlayerActor.tsTransform.Position.x, 0, activedPlayerActor.tsTransform.Position.y);
				playFX.PlayLinFx(_actor, linkFx, 1f, useCustSource: false, _actor.gameObject, sourcePosition, _actor.tsTransform.PositionY, activedPlayerActor.gameObject, targetPosition, activedPlayerActor.tsTransform.PositionY);
			}
			else if (adventureActorCustomEvent.eventName.Equals(evtMonsterStopLinkFx))
			{
				playFX.Stop();
			}
		}
	}
}
