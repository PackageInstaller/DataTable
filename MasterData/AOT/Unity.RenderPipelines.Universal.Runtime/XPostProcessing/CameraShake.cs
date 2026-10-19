using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/图像处理 (Image Processing)/相机抖动 CameraShake")]
public class CameraShake : VolumeSetting
{
	public Vector2Parameter ShakeOffset = new Vector2Parameter(Vector2.zero);

	public override bool IsActive()
	{
		return ShakeOffset.value.sqrMagnitude > 0f;
	}
}
