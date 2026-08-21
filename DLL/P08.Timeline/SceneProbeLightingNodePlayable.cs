using UnityEngine;
using UnityEngine.Playables;

public class SceneProbeLightingNodePlayable : PlayableBehaviour
{
	public Gradient ProbeLightingBase;

	public AnimationCurve ProbeLightingScale;

	private SceneSetting sceneSetting;

	private bool running;

	private Color oriProbeLightingBase;

	private float oriProbeLightingScale;

	public bool ResetValueAfterEnd = true;

	public void SetRun()
	{
		if (!running && sceneSetting != null)
		{
			running = true;
			oriProbeLightingBase = sceneSetting.probeLightingBase;
			oriProbeLightingScale = sceneSetting.probeLightingScale;
		}
	}

	private void SetValue(float ratio)
	{
		if (running && sceneSetting != null)
		{
			sceneSetting.probeLightingBase = ProbeLightingBase.Evaluate(ratio);
			sceneSetting.probeLightingScale = ProbeLightingScale.Evaluate(ratio);
		}
	}

	private void SetStop()
	{
		if (running && sceneSetting != null)
		{
			running = false;
			if (ResetValueAfterEnd)
			{
				sceneSetting.probeLightingBase = oriProbeLightingBase;
				sceneSetting.probeLightingScale = oriProbeLightingScale;
			}
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (sceneSetting == null)
		{
			sceneSetting = playerData as SceneSetting;
		}
		if (sceneSetting == null)
		{
			sceneSetting = Object.FindObjectOfType<SceneSetting>();
		}
		SetRun();
		if ((bool)sceneSetting)
		{
			double num = playable.GetTime() / playable.GetDuration();
			SetValue((float)num);
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		SetRun();
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		SetStop();
	}
}
