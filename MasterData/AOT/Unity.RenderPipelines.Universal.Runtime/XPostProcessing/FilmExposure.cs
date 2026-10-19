using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/图像处理 (Image Processing)/胶片曝光")]
public class FilmExposure : VolumeSetting
{
	public ColorParameter FilmColor = new ColorParameter(Color.black, hdr: true, showAlpha: true, showEyeDropper: true);

	public ClampedFloatParameter Intensity = new ClampedFloatParameter(0f, 0f, 1f);

	public ClampedFloatParameter Exposure = new ClampedFloatParameter(1f, 0f, 5f);

	public override bool IsActive()
	{
		return Intensity.value > 0f;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/ImageProcessing/FilmExposure";
	}
}
