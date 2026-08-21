using P08.EnvironmentHelper;
using UnityEngine;
using UnityEngine.Playables;

public class StoryScenePostEffectNodeBehaviour : PlayableBehaviour
{
	public bool Tonemapping = true;

	public AnimationCurve Exposure;

	public AnimationCurve Contrast;

	public AnimationCurve Grayness;

	public AnimationCurve Darkness;

	public bool Invert = true;

	private bool running;

	public SceneSetting sceneSetting;

	private TimelinePostEffectHelper _helper;

	public void InitOriginData()
	{
	}

	private void SetRun()
	{
		if (!running && sceneSetting != null)
		{
			running = true;
			sceneSetting.tonemapping = Tonemapping;
			sceneSetting.invert = Invert;
		}
	}

	private void SetValue(float normalizedTime)
	{
		if (running && sceneSetting != null)
		{
			sceneSetting.exposure = Exposure.Evaluate(normalizedTime);
			sceneSetting.contrast = Contrast.Evaluate(normalizedTime);
			sceneSetting.grayness = Mathf.Clamp01(Grayness.Evaluate(normalizedTime));
			sceneSetting.darkness = Mathf.Clamp01(Darkness.Evaluate(normalizedTime));
		}
	}

	private void SetStop()
	{
		if (running && sceneSetting != null)
		{
			running = false;
			if (_helper != null)
			{
				_helper.ResetData();
			}
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

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (sceneSetting == null)
		{
			sceneSetting = (SceneSetting)playerData;
		}
		if (sceneSetting == null)
		{
			sceneSetting = (NScene.GetCurrentScene() as BattleScene).sceneSetting;
		}
		if (sceneSetting != null && _helper == null)
		{
			_helper = sceneSetting.GetComponent<TimelinePostEffectHelper>();
		}
		float value = (float)(playable.GetTime() / playable.GetDuration());
		SetRun();
		SetValue(value);
	}
}
