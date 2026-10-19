using System;
using System.Collections.Generic;
using UnityEngine.Localization.Metadata;

namespace UnityEngine.Localization.Platform.Android;

[Serializable]
[Metadata(AllowedTypes = MetadataType.LocalizationSettings, AllowMultiple = false, MenuItem = "Android/Round Icon")]
[DisplayName("Android Round Icon Info", null)]
public class RoundIconsInfo : IMetadata
{
	[SerializeField]
	private LocalizedTexture m_Round_idpi;

	[SerializeField]
	private LocalizedTexture m_Round_mdpi;

	[SerializeField]
	private LocalizedTexture m_Round_hdpi;

	[SerializeField]
	private LocalizedTexture m_Round_xhdpi;

	[SerializeField]
	private LocalizedTexture m_Round_xxhdpi;

	[SerializeField]
	private LocalizedTexture m_Round_xxxhdpi;

	internal List<LocalizedTexture> RoundIcons = new List<LocalizedTexture>();

	public LocalizedTexture RoundHdpi
	{
		get
		{
			return m_Round_hdpi;
		}
		set
		{
			m_Round_hdpi = value;
		}
	}

	public LocalizedTexture RoundIdpi
	{
		get
		{
			return m_Round_idpi;
		}
		set
		{
			m_Round_idpi = value;
		}
	}

	public LocalizedTexture RoundMdpi
	{
		get
		{
			return m_Round_mdpi;
		}
		set
		{
			m_Round_mdpi = value;
		}
	}

	public LocalizedTexture RoundXhdpi
	{
		get
		{
			return m_Round_xhdpi;
		}
		set
		{
			m_Round_xhdpi = value;
		}
	}

	public LocalizedTexture RoundXXHdpi
	{
		get
		{
			return m_Round_xxhdpi;
		}
		set
		{
			m_Round_xxhdpi = value;
		}
	}

	public LocalizedTexture RoundXXXHdpi
	{
		get
		{
			return m_Round_xxxhdpi;
		}
		set
		{
			m_Round_xxxhdpi = value;
		}
	}

	internal void RefreshRoundIcons()
	{
		RoundIcons.Clear();
		RoundIcons.Add(m_Round_idpi);
		RoundIcons.Add(m_Round_mdpi);
		RoundIcons.Add(m_Round_hdpi);
		RoundIcons.Add(m_Round_xhdpi);
		RoundIcons.Add(m_Round_xxhdpi);
		RoundIcons.Add(m_Round_xxxhdpi);
	}
}
