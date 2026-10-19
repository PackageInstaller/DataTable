using System;

namespace UnityEngine.Localization.PropertyVariants.TrackedProperties;

[Serializable]
public class LocalizedStringProperty : ITrackedProperty
{
	[SerializeField]
	private LocalizedString m_Localized = new LocalizedString();

	[SerializeField]
	private string m_PropertyPath;

	public LocalizedString LocalizedString
	{
		get
		{
			return m_Localized;
		}
		set
		{
			m_Localized = value;
		}
	}

	public string PropertyPath
	{
		get
		{
			return m_PropertyPath;
		}
		set
		{
			m_PropertyPath = value;
		}
	}

	public bool HasVariant(LocaleIdentifier localeIdentifier)
	{
		_ = LocalizedString.IsEmpty;
		return false;
	}
}
