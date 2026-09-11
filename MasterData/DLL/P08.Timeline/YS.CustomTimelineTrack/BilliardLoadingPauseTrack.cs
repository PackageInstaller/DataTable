using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("自定义Loading/弹珠玩法/暂停")]
[TrackClipType(typeof(BilliardLoadingPauseNode))]
[TrackClipType(typeof(BilliardLoadingCloseNode))]
public class BilliardLoadingPauseTrack : TrackAsset
{
}
