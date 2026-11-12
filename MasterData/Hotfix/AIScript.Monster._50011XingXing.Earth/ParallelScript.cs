using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Earth;

public class ParallelScript : Parallel
{
	private const string eventName_PlayFx = "PlayEnhanceFx";

	private const string eventName_StopFx = "StopEnhanceFx";

	private const string fxKey_1 = "fx_m50011_loop_enhance_earth_handl";

	private const string fxKey_2 = "fx_m50011_loop_enhance_earth_handr";

	private static readonly FP fxScale = 1.3f;

	private PlayFX _playFX_1;

	private PlayFX _playFX_2;

	public override void OnStart()
	{
		base.OnStart();
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent)
		{
			if (string.Equals(adventureActorCustomEvent.eventName, "PlayEnhanceFx"))
			{
				PlayFx();
			}
			else if (string.Equals(adventureActorCustomEvent.eventName, "StopEnhanceFx"))
			{
				StopFx();
			}
		}
	}

	private void PlayFx()
	{
		if (_playFX_1 == null)
		{
			_playFX_1 = new PlayFX();
		}
		_playFX_1.Play(_actor, null, "fx_m50011_loop_enhance_earth_handl", default, _actor.tsTransform.Position, default, null, 1f, fxScale.AsFloat());
		if (_playFX_2 == null)
		{
			_playFX_2 = new PlayFX();
		}
		_playFX_2.Play(_actor, null, "fx_m50011_loop_enhance_earth_handr", default, _actor.tsTransform.Position, default, null, 1f, fxScale.AsFloat());
	}

	private void StopFx()
	{
		_playFX_1?.Stop();
		_playFX_1?.Clear();
		_playFX_2?.Stop();
		_playFX_2?.Clear();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		StopFx();
	}
}
