using System.Collections.Generic;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[DisplayName("剧情Timeline/QTE/控制器 轨道")]
[TrackColor(0.7366781f, 0.3261246f, 0.8529412f)]
[TrackClipType(typeof(QTEControlNode))]
public class QTEControlTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		ScriptPlayable<QTEControlMixerBehaviour> scriptPlayable = ScriptPlayable<QTEControlMixerBehaviour>.Create(graph, inputCount);
		QTEControlMixerBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.markerClips = new Dictionary<string, double>();
		foreach (TimelineClip clip in GetClips())
		{
			QTEControlNode qTEControlNode = (QTEControlNode)clip.asset;
			if (qTEControlNode.nodeType == QTEControlNode.ENodeType.Marker)
			{
				clip.displayName = "● " + qTEControlNode.markerName;
				if (!behaviour.markerClips.ContainsKey(qTEControlNode.markerName))
				{
					behaviour.markerClips.Add(qTEControlNode.markerName, clip.start);
				}
			}
			else if (qTEControlNode.nodeType == QTEControlNode.ENodeType.Activator)
			{
				if (qTEControlNode.isActiveSubGameObject && !string.IsNullOrEmpty(qTEControlNode.activeSubGameObjectName))
				{
					clip.displayName = "★激活\"" + qTEControlNode.activeSubGameObjectName + "\" ";
				}
				else
				{
					clip.displayName = "";
				}
			}
			else
			{
				if (qTEControlNode.nodeType != QTEControlNode.ENodeType.Processor)
				{
					continue;
				}
				clip.displayName = "";
				if (qTEControlNode.canJump || qTEControlNode.isInactiveSubGameObject)
				{
					if (qTEControlNode.compareType == EQTECompare.Equal)
					{
						clip.displayName += $"当QTE={qTEControlNode.compareToStatus}时 ";
					}
					else if (qTEControlNode.compareType == EQTECompare.NotEqual)
					{
						clip.displayName += $"当QTE!={qTEControlNode.compareToStatus}时 ";
					}
				}
				if (qTEControlNode.canJump)
				{
					switch (qTEControlNode.jumpType)
					{
					case EJumpType.ByFrame:
						clip.displayName += $"↩ 跳到 第{qTEControlNode.frameToJumpto}帧";
						break;
					case EJumpType.ByTime:
						clip.displayName += $"↩ 跳到 第{qTEControlNode.timeToJumpto}秒";
						break;
					case EJumpType.ByMarker:
						clip.displayName = clip.displayName + "↩ 跳到 \"" + qTEControlNode.markerToJumpto + "\"处";
						break;
					}
				}
				if (qTEControlNode.isInactiveSubGameObject)
				{
					clip.displayName = clip.displayName + " ☆禁用\"" + qTEControlNode.inactiveSubGameObjectName + "\"";
				}
				if (qTEControlNode.isActiveSubGameObjectWhenPass)
				{
					clip.displayName = clip.displayName + " ★激活\"" + qTEControlNode.activeSubGameObjectNameWhenPass + "\"";
				}
			}
		}
		return scriptPlayable;
	}
}
