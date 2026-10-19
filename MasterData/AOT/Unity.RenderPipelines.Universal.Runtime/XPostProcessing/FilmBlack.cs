using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/图像处理 (Image Processing)/电影黑边（Film Black）")]
public class FilmBlack : VolumeSetting
{
	public ClampedFloatParameter width = new ClampedFloatParameter(0.1f, 0f, 1f);

	public ClampedFloatParameter intensity = new ClampedFloatParameter(0f, 0f, 1f);

	public ClampedFloatParameter Smoothness = new ClampedFloatParameter(0f, 0f, 1f);

	public ClampedFloatParameter Fade = new ClampedFloatParameter(0f, 0f, 1f);

	public override bool IsActive()
	{
		return intensity.value > 0f;
	}
}
