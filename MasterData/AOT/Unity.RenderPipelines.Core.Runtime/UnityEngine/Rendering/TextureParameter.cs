using System;
using System.Diagnostics;

namespace UnityEngine.Rendering;

[Serializable]
[DebuggerDisplay("{m_Value} ({m_OverrideState})")]
public class TextureParameter : VolumeParameter<Texture>
{
	public TextureDimension dimension;

	public TextureParameter(Texture value, bool overrideState = false)
		: this(value, TextureDimension.Any, overrideState)
	{
	}

	public TextureParameter(Texture value, TextureDimension dimension, bool overrideState = false)
		: base(value, overrideState)
	{
		this.dimension = dimension;
	}

	public override int GetHashCode()
	{
		int result = base.GetHashCode();
		if (value != null)
		{
			result = 23 * CoreUtils.GetTextureHash(value);
		}
		return result;
	}
}
