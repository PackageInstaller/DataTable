#define LOG_DEBUG
using AIScript.Monster.Template;
using AdventureBehaviour;

namespace AIScript.Monster._50271FengMeiGuai;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private string fbx = "fx_m50271_loop_pointer_fixed";

	private string evt_play = "PlayHintFx";

	private string evt_stop = "StopHintFx";

	private PlayFX playFx = new PlayFX();

	public override void OnStart()
	{
		base.OnStart();
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		playFx.Stop();
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent)
		{
			if (adventureActorCustomEvent.eventName.Equals(evt_play))
			{
				playFx.Play(_actor, fbx, 1f, _actor.transform.position, _actor.transform.rotation);
				NovaLogger.Debug("风媒怪.并行脚本.播放特效");
			}
			else if (adventureActorCustomEvent.eventName.Equals(evt_stop))
			{
				playFx.Stop();
				NovaLogger.Debug("风媒怪.并行脚本.关闭特效");
			}
		}
	}
}
