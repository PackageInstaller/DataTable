using System;

namespace UnityEngine.Rendering;

public struct DrawingSettings : IEquatable<DrawingSettings>
{
	public static readonly int maxShaderPasses = 16;

	private SortingSettings m_SortingSettings;

	internal unsafe fixed int shaderPassNames[16];

	private PerObjectData m_PerObjectData;

	private DrawRendererFlags m_Flags;

	private int m_OverrideMaterialInstanceId;

	private int m_OverrideMaterialPassIndex;

	private int m_fallbackMaterialInstanceId;

	private int m_MainLightIndex;

	private int m_UseSrpBatcher;

	public SortingSettings sortingSettings
	{
		get
		{
			return m_SortingSettings;
		}
		set
		{
			m_SortingSettings = value;
		}
	}

	public PerObjectData perObjectData
	{
		set
		{
			m_PerObjectData = value;
		}
	}

	public bool enableDynamicBatching
	{
		set
		{
			if (value)
			{
				m_Flags |= DrawRendererFlags.EnableDynamicBatching;
			}
			else
			{
				m_Flags &= ~DrawRendererFlags.EnableDynamicBatching;
			}
		}
	}

	public bool enableInstancing
	{
		set
		{
			if (value)
			{
				m_Flags |= DrawRendererFlags.EnableInstancing;
			}
			else
			{
				m_Flags &= ~DrawRendererFlags.EnableInstancing;
			}
		}
	}

	public Material overrideMaterial
	{
		set
		{
			m_OverrideMaterialInstanceId = value?.GetInstanceID() ?? 0;
		}
	}

	public int overrideMaterialPassIndex
	{
		set
		{
			m_OverrideMaterialPassIndex = value;
		}
	}

	public Material fallbackMaterial
	{
		set
		{
			m_fallbackMaterialInstanceId = value?.GetInstanceID() ?? 0;
		}
	}

	public int mainLightIndex
	{
		set
		{
			m_MainLightIndex = value;
		}
	}

	public unsafe DrawingSettings(ShaderTagId shaderPassName, SortingSettings sortingSettings)
	{
		m_SortingSettings = sortingSettings;
		m_PerObjectData = PerObjectData.None;
		m_Flags = DrawRendererFlags.EnableInstancing;
		m_OverrideMaterialInstanceId = 0;
		m_OverrideMaterialPassIndex = 0;
		m_fallbackMaterialInstanceId = 0;
		m_MainLightIndex = -1;
		fixed (int* ptr = shaderPassNames)
		{
			*ptr = shaderPassName.id;
			for (int i = 1; i < maxShaderPasses; i++)
			{
				ptr[i] = -1;
			}
		}
		m_PerObjectData = PerObjectData.None;
		m_Flags = DrawRendererFlags.EnableInstancing;
		m_UseSrpBatcher = 0;
	}

	public unsafe ShaderTagId GetShaderPassName(int index)
	{
		if (index >= maxShaderPasses || index < 0)
		{
			throw new ArgumentOutOfRangeException("index", $"Index should range from 0 to DrawSettings.maxShaderPasses ({maxShaderPasses}), was {index}");
		}
		fixed (int* ptr = shaderPassNames)
		{
			return new ShaderTagId
			{
				id = ptr[index]
			};
		}
	}

	public unsafe void SetShaderPassName(int index, ShaderTagId shaderPassName)
	{
		if (index >= maxShaderPasses || index < 0)
		{
			throw new ArgumentOutOfRangeException("index", $"Index should range from 0 to DrawSettings.maxShaderPasses ({maxShaderPasses}), was {index}");
		}
		fixed (int* ptr = shaderPassNames)
		{
			ptr[index] = shaderPassName.id;
		}
	}

	public bool Equals(DrawingSettings other)
	{
		for (int i = 0; i < maxShaderPasses; i++)
		{
			if (!GetShaderPassName(i).Equals(other.GetShaderPassName(i)))
			{
				return false;
			}
		}
		return m_SortingSettings.Equals(other.m_SortingSettings) && m_PerObjectData == other.m_PerObjectData && m_Flags == other.m_Flags && m_OverrideMaterialInstanceId == other.m_OverrideMaterialInstanceId && m_OverrideMaterialPassIndex == other.m_OverrideMaterialPassIndex && m_fallbackMaterialInstanceId == other.m_fallbackMaterialInstanceId && m_UseSrpBatcher == other.m_UseSrpBatcher;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is DrawingSettings && Equals((DrawingSettings)obj);
	}

	public override int GetHashCode()
	{
		int hashCode = m_SortingSettings.GetHashCode();
		hashCode = (hashCode * 397) ^ (int)m_PerObjectData;
		hashCode = (hashCode * 397) ^ (int)m_Flags;
		hashCode = (hashCode * 397) ^ m_OverrideMaterialInstanceId;
		hashCode = (hashCode * 397) ^ m_OverrideMaterialPassIndex;
		hashCode = (hashCode * 397) ^ m_fallbackMaterialInstanceId;
		return (hashCode * 397) ^ m_UseSrpBatcher;
	}
}
