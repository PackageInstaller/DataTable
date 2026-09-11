using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline.Character;
using UnityEngine.Playables;

public class StoryFlashActionOverriderNodeBehaviour : PlayableBehaviour
{
	public bool IsCustomFillColor;

	public Color FillOuter = Color.white;

	public Color FillInner = Color.white;

	public AnimationCurve Curve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	public float FillSoft = 2f;

	public bool AssignMaterial;

	public List<int> MaterialIndexes;

	private bool orgIsCustomFillColor;

	private Color orgFillOuter;

	private Color orgFillInner;

	private float orgRatio;

	private float orgFillSoft;

	private bool orgAssignMaterial;

	private List<int> orgMaterialIndexes;

	private bool running;

	private CharacterEffectOverrider characterEffectOverrider;

	private void SetRun()
	{
		if (!running && characterEffectOverrider != null)
		{
			running = true;
			characterEffectOverrider.overrideFill = true;
			orgIsCustomFillColor = characterEffectOverrider.fillFlat;
			orgFillOuter = characterEffectOverrider.fillOuter;
			orgFillInner = characterEffectOverrider.fillInner;
			orgRatio = characterEffectOverrider.fillRatio;
			orgFillSoft = characterEffectOverrider.fillSoft;
			orgMaterialIndexes = new List<int>(characterEffectOverrider.materialIndexes);
			orgAssignMaterial = characterEffectOverrider.assignMaterial;
		}
	}

	private void SetStop()
	{
		if (running && characterEffectOverrider != null)
		{
			running = false;
			characterEffectOverrider.fillFlat = orgIsCustomFillColor;
			characterEffectOverrider.fillOuter = orgFillOuter;
			characterEffectOverrider.fillInner = orgFillInner;
			characterEffectOverrider.fillRatio = orgRatio;
			characterEffectOverrider.fillSoft = orgFillSoft;
			characterEffectOverrider.assignMaterial = orgAssignMaterial;
			characterEffectOverrider.materialIndexes = orgMaterialIndexes;
			orgMaterialIndexes = null;
		}
	}

	private void SetValue(float ratio)
	{
		if (running && characterEffectOverrider != null)
		{
			characterEffectOverrider.fillFlat = IsCustomFillColor;
			characterEffectOverrider.fillOuter = FillOuter;
			characterEffectOverrider.fillInner = FillInner;
			characterEffectOverrider.fillRatio = Mathf.Clamp01(Curve.Evaluate(ratio));
			characterEffectOverrider.fillSoft = FillSoft;
			characterEffectOverrider.assignMaterial = AssignMaterial;
			characterEffectOverrider.materialIndexes = MaterialIndexes;
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
		if (characterEffectOverrider == null)
		{
			characterEffectOverrider = (CharacterEffectOverrider)playerData;
		}
		SetRun();
		if (characterEffectOverrider != null)
		{
			double time = playable.GetTime();
			double duration = playable.GetDuration();
			float value = (float)(time / duration);
			SetValue(value);
		}
	}
}
