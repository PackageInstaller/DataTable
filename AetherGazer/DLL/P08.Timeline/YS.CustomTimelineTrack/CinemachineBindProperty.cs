using System;
using System.ComponentModel;
using Cinemachine;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("CinemachineExtend/CinemachineExtendBind")]
[TrackBindingType(typeof(CinemachineVirtualCameraBase))]
[TrackClipType(typeof(CinemachineBindPropertyNode))]
public class CinemachineBindProperty : TrackAsset
{
}
