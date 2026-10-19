using System;

namespace UnityEngine.Localization.Metadata;

[Serializable]
[Metadata(AllowedTypes = MetadataType.Locale)]
public class FallbackLocale : IMetadata
{
	[SerializeField]
	private Locale m_Locale;

	public Locale Locale
	{
		get
		{
			return m_Locale;
		}
		set
		{
			m_Locale = value;
			if (IsCyclic(value))
			{
				m_Locale = null;
			}
		}
	}

	public FallbackLocale()
	{
	}

	public FallbackLocale(Locale fallback)
	{
		Locale = fallback;
	}

	private bool IsCyclic(Locale locale)
	{
		FallbackLocale fallbackLocale = locale.Metadata?.GetMetadata<FallbackLocale>();
		while (fallbackLocale != null && fallbackLocale.Locale != null)
		{
			if (fallbackLocale.Locale == locale)
			{
				Debug.LogWarning($"Cyclic fallback linking detected. Can not set fallback locale '{locale}' as it would create an infinite loop.");
				return true;
			}
			fallbackLocale = fallbackLocale.Locale.Metadata?.GetMetadata<FallbackLocale>();
		}
		return false;
	}
}
