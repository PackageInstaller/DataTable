using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace XPostProcessing;

public abstract class VolumeRenderer<T> : AbstractVolumeRenderer where T : VolumeSetting
{
	private VolumeComponentCache m_VolumeComponents;

	private int m_SettingsCacheVersion = -1;

	protected T m_Settings;

	public int level = 1;

	private Shader m_Shader;

	public Material m_BlitMaterial;

	public const int Defaultlevel = 1;

	public T settings
	{
		get
		{
			if (m_VolumeComponents == null)
			{
				return VolumeManager.instance.stack.GetComponent<T>();
			}
			int version = m_VolumeComponents.version;
			if (m_Settings == null || m_SettingsCacheVersion != version)
			{
				m_Settings = m_VolumeComponents.Get<T>();
				m_SettingsCacheVersion = m_VolumeComponents.version;
			}
			return m_Settings;
		}
	}

	internal override void SetVolumeComponentCache(VolumeComponentCache volumeComponents)
	{
		m_VolumeComponents = volumeComponents;
		m_SettingsCacheVersion = -1;
		m_Settings = null;
	}

	public override bool IsActive()
	{
		m_Settings = settings;
		return m_Settings.IsActive();
	}

	public override bool PlatformCompatible()
	{
		return level >= 1;
	}

	public override bool Init()
	{
		string shaderName = settings.GetShaderName();
		m_Shader = null;
		if (!string.IsNullOrEmpty(shaderName))
		{
			m_Shader = Shader.Find(shaderName);
			if (m_Shader != null)
			{
				m_BlitMaterial = CoreUtils.CreateEngineMaterial(m_Shader);
				return true;
			}
			return false;
		}
		return true;
	}

	public override void Cleanup()
	{
		if (m_BlitMaterial != null)
		{
			CoreUtils.Destroy(m_BlitMaterial);
			m_BlitMaterial = null;
		}
	}
}
