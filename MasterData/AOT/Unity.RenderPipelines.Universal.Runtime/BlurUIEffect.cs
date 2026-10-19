using System;
using UnityEngine;

[Serializable]
public class BlurUIEffect : UIEffectSetting
{
	[Range(0f, 100f)]
	[SerializeField]
	private float m_BlurRadius;

	public float BlurRadius
	{
		get
		{
			return m_BlurRadius;
		}
		set
		{
			m_BlurRadius = value;
		}
	}

	public override bool IsActive()
	{
		return BlurRadius > 0f;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/Blur/GaussianBlur";
	}
}
