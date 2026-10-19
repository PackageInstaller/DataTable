using System;
using UnityEngine.Localization.Metadata;

namespace UnityEngine.Localization.Platform.iOS;

[Serializable]
[DisplayName("iOS App Info", null)]
[Metadata(AllowedTypes = MetadataType.LocalizationSettings, AllowMultiple = false, MenuItem = "iOS/App Info")]
public class AppInfo : IMetadata
{
	[Tooltip("The user-visible name for the bundle, used by Siri and visible on the iOS Home screen.\nThis name can contain up to 15 characters.\nCFBundleName field in xcode projects info.plist file.")]
	[SerializeField]
	private LocalizedString m_ShortName = new LocalizedString();

	[Tooltip("The user-visible name for the bundle, used by Siri and visible on the iOS Home screen.\nUse this key if you want a product name that's longer than Bundle Name.\nCFBundleDisplayName field in xcode projects info.plist file.")]
	[SerializeField]
	private LocalizedString m_DisplayName = new LocalizedString();

	[Tooltip("A message that tells the user why the app is requesting access to the device’s camera.\nNSCameraUsageDescription field in xcode projects info.plist file.")]
	[SerializeField]
	private LocalizedString m_CameraUsageDescription = new LocalizedString();

	[Tooltip("A message that tells the user why the app is requesting access to the device’s microphone.\nNSMicrophoneUsageDescription field in xcode projects info.plist file.")]
	[SerializeField]
	private LocalizedString m_MicrophoneUsageDescription = new LocalizedString();

	[Tooltip("A message that tells the user why the app is requesting access to the user’s location information while the app is running in the foreground.\nNSLocationWhenInUseUsageDescription field in xcode projects info.plist file.")]
	[SerializeField]
	private LocalizedString m_LocationUsageDescription = new LocalizedString();

	[Tooltip("A message that informs the user why an app is requesting permission to use data for tracking the user or the device.\nNSUserTrackingUsageDescription field in xcode projects info.plist file.")]
	[SerializeField]
	private LocalizedString m_UserTrackingUsageDescription = new LocalizedString();

	public LocalizedString ShortName
	{
		get
		{
			return m_ShortName;
		}
		set
		{
			m_ShortName = value;
		}
	}

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

	public LocalizedString CameraUsageDescription
	{
		get
		{
			return m_CameraUsageDescription;
		}
		set
		{
			m_CameraUsageDescription = value;
		}
	}

	public LocalizedString MicrophoneUsageDescription
	{
		get
		{
			return m_MicrophoneUsageDescription;
		}
		set
		{
			m_MicrophoneUsageDescription = value;
		}
	}

	public LocalizedString LocationUsageDescription
	{
		get
		{
			return m_LocationUsageDescription;
		}
		set
		{
			m_LocationUsageDescription = value;
		}
	}

	public LocalizedString UserTrackingUsageDescription
	{
		get
		{
			return m_UserTrackingUsageDescription;
		}
		set
		{
			m_UserTrackingUsageDescription = value;
		}
	}
}
