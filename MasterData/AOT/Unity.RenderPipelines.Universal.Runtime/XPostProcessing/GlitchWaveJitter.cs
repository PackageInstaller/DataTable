using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/故障效果 (Glitch)/波动抖动故障 (Wave Jitter Glitch)")]
public class GlitchWaveJitter : VolumeSetting
{
	public DirectionParameter jitterDirection = new DirectionParameter(Direction.Horizontal);

	public IntervalTypeParameter intervalType = new IntervalTypeParameter(IntervalType.Random);

	public FloatParameter frequency = new ClampedFloatParameter(0f, 0f, 50f);

	public FloatParameter RGBSplit = new ClampedFloatParameter(20f, 0f, 50f);

	public FloatParameter speed = new ClampedFloatParameter(0.25f, 0f, 1f);

	public FloatParameter amount = new ClampedFloatParameter(1f, 0f, 2f);

	public BoolParameter customResolution = new BoolParameter(value: false);

	public Vector2Parameter resolution = new Vector2Parameter(new Vector2(640f, 480f));

	public override bool IsActive()
	{
		return frequency.value > 0f;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/Glitch/WaveJitter";
	}
}
