using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.EditorScript;

[DisplayName("UI.Timeline/场景色调(SceneSettingTint)")]
[TrackClipType(typeof(UISceneSettingTintNode))]
[TrackBindingType(typeof(SceneSetting))]
public class UISceneSettingTintTrack : PlayableTrack
{
}
