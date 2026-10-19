using System;
using ACT.Game;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT;

public class GetMainRoleTrackObject : GetTrackObjectBase
{
	private int m_Gender;

	public GetMainRoleTrackObject(int gender)
	{
		m_Gender = gender;
	}

	public override void GetTrackObject(PlayableDirector pd, PlayableBinding pb, Type type, string trackData, int outputIndex, out UnityEngine.Object trackObject)
	{
		trackObject = pd.GetGenericBinding(pb.sourceObject);
		bool flag = G.detailUserInfo.Brief.Gender != m_Gender;
		MuteTrackByIndex(pd, pb.streamName, flag);
		UnityEngine.Object obj = trackObject;
		if (!(obj is GameObject gameObject))
		{
			if (!(obj is Transform transform))
			{
				if (obj is Animator animator)
				{
					animator.gameObject.SetActive(!flag);
				}
			}
			else
			{
				transform.gameObject.SetActive(!flag);
			}
		}
		else
		{
			gameObject.SetActive(!flag);
		}
	}

	private void MuteTrackByIndex(PlayableDirector director, string trackName, bool mute)
	{
		foreach (TrackAsset outputTrack in (director.playableAsset as TimelineAsset).GetOutputTracks())
		{
			if (trackName == outputTrack.name)
			{
				outputTrack.muted = mute;
				director.RebuildGraph();
				break;
			}
		}
	}
}
