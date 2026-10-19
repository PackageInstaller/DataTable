using System;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace XPostProcessing;

[Serializable]
public abstract class VolumeSetting : VolumeComponent, IPostProcessComponent
{
	public abstract bool IsActive();

	public virtual string GetShaderName()
	{
		return string.Empty;
	}

	public virtual void SetCenter(float x, float y)
	{
	}
}
