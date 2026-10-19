using System;
using UnityEngine;
using UnityEngine.Rendering;

[Serializable]
public abstract class UIEffectRenderer<T> : AbstractUIEffectRenderer where T : UIEffectSetting
{
	public T setting;

	private Shader m_Shader;

	[NonSerialized]
	public Material m_BlitMaterial;

	[NonSerialized]
	public bool materialCreated;

	public bool Init()
	{
		string shaderName = setting.GetShaderName();
		if (!string.IsNullOrEmpty(shaderName))
		{
			m_Shader = Shader.Find(shaderName);
			if (m_Shader != null)
			{
				m_BlitMaterial = CoreUtils.CreateEngineMaterial(m_Shader);
				materialCreated = true;
				return true;
			}
		}
		return false;
	}

	public void setSetting(T inputSetting)
	{
		setting = inputSetting;
	}

	public override void Cleanup()
	{
		CoreUtils.Destroy(m_BlitMaterial);
		m_BlitMaterial = null;
		m_Shader = null;
		materialCreated = false;
	}
}
