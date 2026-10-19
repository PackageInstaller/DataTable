using System;
using UnityEngine.Localization.Metadata;

namespace UnityEngine.Localization.Platform.Android;

[Serializable]
[DisplayName("Android App Info", "Packages/com.unity.localization/Editor/Icons/Android/Android.png")]
[Metadata(AllowedTypes = MetadataType.LocalizationSettings, AllowMultiple = false, MenuItem = "Android/App Info")]
public class AppInfo : IMetadata
{
	[Tooltip("The user-visible name for the bundle, used by Google Assistant and visible on the Android Home screen.\n")]
	[SerializeField]
	private LocalizedString m_DisplayName = new LocalizedString();

	public LocalizedString DisplayName
	{
		get
		{
			return m_DisplayName;
		}
		set
		{
			m_DisplayName = value;
		}
	}
}
