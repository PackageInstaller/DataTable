using System;
using System.Collections.Generic;
using UnityEngine.Localization.Metadata;

namespace UnityEngine.Localization.Platform.Android;

[Serializable]
[DisplayName("Android Legacy Icon Info", null)]
[Metadata(AllowedTypes = MetadataType.LocalizationSettings, AllowMultiple = false, MenuItem = "Android/Legacy Icon")]
public class LegacyIconsInfo : IMetadata
{
	[SerializeField]
	private LocalizedTexture m_Legacy_idpi;

	[SerializeField]
	private LocalizedTexture m_Legacy_mdpi;

	[SerializeField]
	private LocalizedTexture m_Legacy_hdpi;

	[SerializeField]
	private LocalizedTexture m_Legacy_xhdpi;

	[SerializeField]
	private LocalizedTexture m_Legacy_xxhdpi;

	[SerializeField]
	private LocalizedTexture m_Legacy_xxxhdpi;

	internal List<LocalizedTexture> LegacyIcons = new List<LocalizedTexture>();

	public LocalizedTexture LegacyHdpi
	{
		get
		{
			return m_Legacy_hdpi;
		}
		set
		{
			m_Legacy_hdpi = value;
		}
	}

	public LocalizedTexture LegacyIdpi
	{
		get
		{
			return m_Legacy_idpi;
		}
		set
		{
			m_Legacy_idpi = value;
		}
	}

	public LocalizedTexture LegacyMdpi
	{
		get
		{
			return m_Legacy_mdpi;
		}
		set
		{
			m_Legacy_mdpi = value;
		}
	}

	public LocalizedTexture LegacyXhdpi
	{
		get
		{
			return m_Legacy_xhdpi;
		}
		set
		{
			m_Legacy_xhdpi = value;
		}
	}

	public LocalizedTexture LegacyXXHdpi
	{
		get
		{
			return m_Legacy_xxhdpi;
		}
		set
		{
			m_Legacy_xxhdpi = value;
		}
	}

	public LocalizedTexture LegacyXXXHdpi
	{
		get
		{
			return m_Legacy_xxxhdpi;
		}
		set
		{
			m_Legacy_xxxhdpi = value;
		}
	}

	internal void RefreshLegacyIcons()
	{
		LegacyIcons.Clear();
		LegacyIcons.Add(m_Legacy_idpi);
		LegacyIcons.Add(m_Legacy_mdpi);
		LegacyIcons.Add(m_Legacy_hdpi);
		LegacyIcons.Add(m_Legacy_xhdpi);
		LegacyIcons.Add(m_Legacy_xxhdpi);
		LegacyIcons.Add(m_Legacy_xxxhdpi);
	}
}
