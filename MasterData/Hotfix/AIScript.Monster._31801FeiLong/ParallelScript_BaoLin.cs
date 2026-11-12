using System.Collections;
using AIScript.Monster.Template;
using TrueSync;

namespace AIScript.Monster._31801FeiLong;

public class ParallelScript_BaoLin : Parallel
{
	private CoroutineNode _explosionLogicCor;

	public override void OnStart()
	{
		base.OnStart();
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && adventureActorCustomEvent.eventHashCode == Config.eventHashCode_BaoLin_Explosion && (adventureActorCustomEvent.boolParam || (_actor.state != ActorState.Null && _actor.state != ActorState.Spawn)) && _explosionLogicCor == null)
		{
			_explosionLogicCor = _actor.StartLogicCoroutine(ExplosionLogic(), runImmediately: true);
		}
	}

	private IEnumerator ExplosionLogic()
	{
		while (_actor.state == ActorState.Null || _actor.state == ActorState.Spawn)
		{
			yield return null;
		}
		_actor.DestroySelf();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}
}
