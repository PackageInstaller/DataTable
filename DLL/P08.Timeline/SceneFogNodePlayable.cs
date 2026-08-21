using P08.EnvironmentHelper;
using UnityEngine;
using UnityEngine.Playables;

public class SceneFogNodePlayable : PlayableBehaviour
{
	public AnimationCurve DynamicFogIntensityCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	public Color color;

	private SceneSetting sceneSetting;

	private TimelineDynamicFogEffectHelper _helper;

	private bool running;

	public void SetRun()
	{
		if (!running && sceneSetting != null)
		{
			running = true;
		}
	}

	private void SetValue(float value)
	{
		if (running && sceneSetting != null)
		{
			sceneSetting.dynamicFogColor = color;
			sceneSetting.dynamicFogIntensity = value;
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

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		float time = (float)(playable.GetTime() / playable.GetDuration());
		if (sceneSetting == null)
		{
			sceneSetting = (SceneSetting)playerData;
			if (sceneSetting == null)
			{
				sceneSetting = Object.FindObjectOfType<SceneSetting>();
				_helper = sceneSetting.GetComponent<TimelineDynamicFogEffectHelper>();
			}
		}
		float value = Mathf.Clamp01(DynamicFogIntensityCurve.Evaluate(time));
		SetRun();
		SetValue(value);
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (sceneSetting != null)
		{
			sceneSetting.dynamicFogIntensity = 0f;
		}
	}

	public override void OnGraphStop(Playable playable)
	{
		if (sceneSetting != null)
		{
			sceneSetting.dynamicFogIntensity = 0f;
		}
		SetStop();
	}
}
