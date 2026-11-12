using UnityEngine.Playables;

public sealed class L2DAnimBehaviour : PlayableBehaviour
{
	public L2DAnimPlayer player;

	public string name;

	public bool loop;

	public bool preHold;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (!(player == null) && !string.IsNullOrEmpty(name))
		{
			player.PlayAnimInTimeline(name, loop, bPreHold: false);
		}
	}

	public override void OnGraphStart(Playable playable)
	{
		if (preHold && !(player == null) && !string.IsNullOrEmpty(name))
		{
			player.PlayAnimInTimeline(name, loop, bPreHold: true);
		}
	}
}
