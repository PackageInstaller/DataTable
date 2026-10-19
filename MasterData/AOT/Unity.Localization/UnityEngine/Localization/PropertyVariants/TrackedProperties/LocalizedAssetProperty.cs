using System;

namespace UnityEngine.Localization.PropertyVariants.TrackedProperties;

[Serializable]
public class LocalizedAssetProperty : ITrackedProperty
{
	[SerializeReference]
	private LocalizedAssetBase m_Localized;

	[SerializeField]
	private string m_PropertyPath;

	public LocalizedAssetBase LocalizedObject
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
		_ = LocalizedObject.IsEmpty;
		return false;
	}
}
