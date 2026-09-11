using UnityEngine;
using UnityEngine.Playables;

public class StoryFlashActionNodeBehaviour : PlayableBehaviour
{
	public bool IsCustomFillColor;

	public Color FillOuter = Color.white;

	public Color FillInner = Color.white;

	public AnimationCurve Curve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	public float FillSoft = 2f;

	private bool orgIsCustomFillColor;

	private Color orgFillOuter;

	private Color orgFillInner;

	private float orgRatio;

	private float orgFillSoft;

	private bool running;

	private CharacterEffect characterEffect;

	private void SetRun()
	{
		if (!running && characterEffect != null)
		{
			running = true;
			orgIsCustomFillColor = characterEffect.fillFlat;
			orgFillOuter = characterEffect.fillOuter;
			orgFillInner = characterEffect.fillInner;
			orgRatio = characterEffect.fillRatio;
			orgFillSoft = characterEffect.fillSoft;
		}
	}

	private void SetStop()
	{
		if (running && characterEffect != null)
		{
			running = false;
			characterEffect.fillFlat = orgIsCustomFillColor;
			characterEffect.fillOuter = orgFillOuter;
			characterEffect.fillInner = orgFillInner;
			characterEffect.fillRatio = orgRatio;
			characterEffect.fillSoft = orgFillSoft;
		}
	}

	private void SetValue(float ratio)
	{
		if (running && characterEffect != null)
		{
			characterEffect.fillFlat = IsCustomFillColor;
			characterEffect.fillOuter = FillOuter;
			characterEffect.fillInner = FillInner;
			characterEffect.fillRatio = Mathf.Clamp01(Curve.Evaluate(ratio));
			characterEffect.fillSoft = FillSoft;
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
		if (characterEffect == null)
		{
			characterEffect = (CharacterEffect)playerData;
		}
		SetRun();
		if (characterEffect != null)
		{
			double time = playable.GetTime();
			double duration = playable.GetDuration();
			float value = (float)(time / duration);
			SetValue(value);
		}
	}
}
