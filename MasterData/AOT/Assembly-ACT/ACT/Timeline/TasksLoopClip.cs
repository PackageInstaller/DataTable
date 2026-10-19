using ACT.Drama;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

public class TasksLoopClip : PlayableAsset, ILoopClip, ITimelineClipAsset
{
	private TimelineClip clip;

	public string jumpMarkerName;

	public ClipCaps clipCaps => ClipCaps.None;

	public TimelineClip Clip
	{
		get
		{
			return clip;
		}
		set
		{
			clip = value;
		}
	}

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		TasksLoopBehaviour tasksLoopBehaviour = new TasksLoopBehaviour();
		tasksLoopBehaviour.startTime = clip.start;
		tasksLoopBehaviour.endTime = clip.end;
		JumpMarker jumpMarker = null;
		foreach (JumpMarker item in ConversationController.GetAllMarker(clip.GetParentTrack().timelineAsset))
		{
			if (item.name == jumpMarkerName)
			{
				jumpMarker = item;
			}
		}
		if (jumpMarker == null)
		{
			tasksLoopBehaviour.jumpTime = clip.end;
		}
		else
		{
			tasksLoopBehaviour.jumpTime = jumpMarker.time;
		}
		return ScriptPlayable<TasksLoopBehaviour>.Create(graph, tasksLoopBehaviour);
	}
}
