using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[DisplayName("测试功能/音乐参考(不支持游戏内播放)")]
[TrackColor(0.3317462f, 0.6611561f, 105f / 106f)]
[TrackClipType(typeof(CriAtomClip))]
[TrackBindingType(typeof(CriAtomSource))]
public class CriAtomTrack : TrackAsset
{
	public string m_AisacControls;

	public bool m_StopOnWrapping = true;

	public bool m_StopAtGraphEnd = true;

	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject owner, int inputCount)
	{
		ScriptPlayable<CriAtomMixerBehaviour> scriptPlayable = ScriptPlayable<CriAtomMixerBehaviour>.Create(graph, inputCount);
		CriAtomMixerBehaviour behaviour = scriptPlayable.GetBehaviour();
		if (behaviour != null)
		{
			behaviour.m_Director = owner.GetComponent<PlayableDirector>();
			behaviour.m_Clips = GetClips();
			behaviour.m_Bind = behaviour.m_Director.GetGenericBinding(this) as CriAtomSource;
			if (behaviour.m_Bind != null)
			{
				foreach (TimelineClip clip in behaviour.m_Clips)
				{
					CriAtomClip criAtomClip = clip.asset as CriAtomClip;
					if (string.IsNullOrEmpty(criAtomClip.cueSheet))
					{
						criAtomClip.cueSheet = behaviour.m_Bind.cueSheet;
					}
					if (string.IsNullOrEmpty(criAtomClip.cueName))
					{
						criAtomClip.cueName = behaviour.m_Bind.cueName;
					}
					clip.displayName = criAtomClip.cueName;
				}
			}
			behaviour.m_AisacControls = m_AisacControls;
			behaviour.m_StopOnWrapping = m_StopOnWrapping;
			behaviour.m_StopAtGraphEnd = m_StopAtGraphEnd;
		}
		return scriptPlayable;
	}
}
