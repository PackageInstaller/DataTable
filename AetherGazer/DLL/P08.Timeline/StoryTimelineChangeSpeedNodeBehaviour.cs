using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineChangeSpeedNodeBehaviour : PlayableBehaviour
{
	private bool isRunning;

	public AnimationCurve speedCurve;

	public bool inverseWhenFinished;

	public PlayableDirector pd;

	public void SetWeight(float weight)
	{
		if (isRunning && weight == 0f)
		{
			isRunning = false;
			Exit(pd.playableGraph.GetRootPlayable(0));
		}
		if (!isRunning && weight == 1f)
		{
			isRunning = true;
			Enter();
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.ProcessFrame(playable, info, playerData);
		if (playerData is PlayableDirector)
		{
			pd = playerData as PlayableDirector;
			ProcessSpeed(playable);
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (isRunning)
		{
			isRunning = false;
			Exit(playable);
		}
		playable.SetSpeed(1.0);
	}

	private void Enter()
	{
	}

	private void Exit(Playable playable)
	{
		if (inverseWhenFinished && pd != null && pd.playableGraph.IsValid())
		{
			pd.playableGraph.GetRootPlayable(0).SetSpeed(1.0);
		}
	}

	private void ProcessSpeed(Playable playable)
	{
		float num = (float)playable.GetTime();
		float num2 = (float)playable.GetDuration();
		float time = Mathf.Clamp(num / num2, 0f, 1f);
		float num3 = speedCurve.Evaluate(time);
		if (pd.playableGraph.IsValid())
		{
			pd.playableGraph.GetRootPlayable(0).SetSpeed(num3);
		}
	}
}
