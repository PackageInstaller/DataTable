using System;
using System.Collections.Generic;
using UnityEngine.Localization.Metadata;

namespace UnityEngine.Localization.Platform.Android;

[Serializable]
[DisplayName("Android Adaptive Icon Info", null)]
[Metadata(AllowedTypes = MetadataType.LocalizationSettings, AllowMultiple = false, MenuItem = "Android/Adaptive Icon")]
public class AdaptiveIconsInfo : IMetadata
{
	[SerializeField]
	private AdaptiveIcon m_Adaptive_idpi;

	[SerializeField]
	private AdaptiveIcon m_Adaptive_mdpi;

	[SerializeField]
	private AdaptiveIcon m_Adaptive_hdpi;

	[SerializeField]
	private AdaptiveIcon m_Adaptive_xhdpi;

	[SerializeField]
	private AdaptiveIcon m_Adaptive_xxhdpi;

	[SerializeField]
	private AdaptiveIcon m_Adaptive_xxxhdpi;

	internal List<AdaptiveIcon> AdaptiveIcons = new List<AdaptiveIcon>();

	public AdaptiveIcon AdaptiveHdpi
	{
		get
		{
			return m_Adaptive_hdpi;
		}
		set
		{
			m_Adaptive_hdpi = value;
		}
	}

	public AdaptiveIcon AdaptiveIdpi
	{
		get
		{
			return m_Adaptive_idpi;
		}
		set
		{
			m_Adaptive_idpi = value;
		}
	}

	public AdaptiveIcon AdaptiveMdpi
	{
		get
		{
			return m_Adaptive_mdpi;
		}
		set
		{
			m_Adaptive_mdpi = value;
		}
	}

	public AdaptiveIcon AdaptiveXhdpi
	{
		get
		{
			return m_Adaptive_xhdpi;
		}
		set
		{
			m_Adaptive_xhdpi = value;
		}
	}

	public AdaptiveIcon AdaptiveXXHdpi
	{
		get
		{
			return m_Adaptive_xxhdpi;
		}
		set
		{
			m_Adaptive_xxhdpi = value;
		}
	}

	public AdaptiveIcon AdaptiveXXXHdpi
	{
		get
		{
			return m_Adaptive_xxxhdpi;
		}
		set
		{
			m_Adaptive_xxxhdpi = value;
		}
	}

	internal void RefreshAdaptiveIcons()
	{
		AdaptiveIcons.Clear();
		AdaptiveIcons.Add(m_Adaptive_idpi);
		AdaptiveIcons.Add(m_Adaptive_mdpi);
		AdaptiveIcons.Add(m_Adaptive_hdpi);
		AdaptiveIcons.Add(m_Adaptive_xhdpi);
		AdaptiveIcons.Add(m_Adaptive_xxhdpi);
		AdaptiveIcons.Add(m_Adaptive_xxxhdpi);
	}
}
