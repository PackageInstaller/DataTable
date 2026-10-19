using UnityEngine.Localization.Events;

namespace UnityEngine.Localization.Components;

[AddComponentMenu("Localization/Asset/Localize Audio Clip Event")]
public class LocalizeAudioClipEvent : LocalizedAssetEvent<AudioClip, LocalizedAudioClip, UnityEventAudioClip>
{
}
