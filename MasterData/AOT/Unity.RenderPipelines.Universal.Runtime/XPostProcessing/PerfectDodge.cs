using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/技能 (Skill)/完美闪避(PerfectDodge)")]
public class PerfectDodge : VolumeSetting
{
	internal const string GrabPassShaderName = "Hidden/Universal Render Pipeline/GrabPassBlit";

	public ClampedFloatParameter progress = new ClampedFloatParameter(0f, 0f, 1f);

	public NoInterpColorParameter flowLightColor = new NoInterpColorParameter(Color.white, hdr: true, showAlpha: true, showEyeDropper: true, overrideState: true);

	public NoInterpColorParameter lineColor = new NoInterpColorParameter(Color.white, hdr: true, showAlpha: true, showEyeDropper: true, overrideState: true);

	public NoInterpAnimationCurveParameter DeSaturateCurve = new NoInterpAnimationCurveParameter(new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(1f, 1f)));

	public NoInterpAnimationCurveParameter LineCurve = new NoInterpAnimationCurveParameter(new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(1f, 1f)));

	public NoInterpAnimationCurveParameter OffsetCurve = new NoInterpAnimationCurveParameter(new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(1f, 1f)));

	public NoInterpFloatParameter offsetIntensity = new NoInterpFloatParameter(0f);

	public override bool IsActive()
	{
		return progress.value != 0f;
	}

	public override string GetShaderName()
	{
		return "Hidden/Universal Render Pipeline/GrabPassBlit";
	}
}
