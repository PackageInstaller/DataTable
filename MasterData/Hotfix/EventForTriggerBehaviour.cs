using UnityEngine.Playables;

public sealed class EventForTriggerBehaviour : PlayableBehaviour
{
	public string event_name;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (!string.IsNullOrEmpty(event_name))
		{
			Singleton<InteractiveManager>.Instance.triggerOpListener(event_name);
		}
	}
}
