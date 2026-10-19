using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/图像处理 (Image Processing)/ArtLine")]
public class ArtLine : VolumeSetting
{
	public ColorParameter lineColor = new ColorParameter(Color.black, hdr: true, showAlpha: true, showEyeDropper: true);

	public MinFloatParameter NormalThreshold = new MinFloatParameter(0f, 0f);

	public MinFloatParameter NormalRange = new MinFloatParameter(0.05f, 0f);

	public MinFloatParameter DepthThreshold = new MinFloatParameter(0.3f, 0f);

	public MinFloatParameter DepthRange = new MinFloatParameter(0.05f, 0f);

	public MinFloatParameter FadeStart = new MinFloatParameter(0f, 0f);

	public MinFloatParameter FadeFactor = new MinFloatParameter(0f, 0f);

	public override bool IsActive()
	{
		return NormalThreshold.value > 0f;
	}
}
