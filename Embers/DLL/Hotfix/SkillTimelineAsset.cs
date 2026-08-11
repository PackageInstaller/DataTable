using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class SkillTimelineAsset : ScriptableObject
{
	[SerializeReference]
	public List<StandardTrack> Tracks;

	[SerializeReference]
	public BlackBoardVariable blackBoardVariable;

	public int Duration;

	public int FPS;

	public SkillTimelineAsset()
	{
		Tracks = new List<StandardTrack>();
		blackBoardVariable = new BlackBoardVariable();
	}

	public static SkillTimelineAsset Clone(SkillTimelineAsset skillTimelineAsset)
	{
		if (skillTimelineAsset == null)
		{
			return null;
		}
		SkillTimelineAsset skillTimelineAsset2 = UnityEngine.Object.Instantiate(skillTimelineAsset);
		skillTimelineAsset2.name = skillTimelineAsset.name;
		skillTimelineAsset2.Tracks = new List<StandardTrack>();
		for (int i = 0; i < skillTimelineAsset.Tracks.Count; i++)
		{
			StandardTrack standardTrack = skillTimelineAsset.Tracks[i];
			StandardTrack item = (StandardTrack)Activator.CreateInstance(standardTrack.GetType());
			skillTimelineAsset2.Tracks.Add(item);
			for (int j = 0; j < standardTrack.taskClips.Count; j++)
			{
				TaskClip item2 = UnityEngine.Object.Instantiate(standardTrack.taskClips[j]);
				skillTimelineAsset2.Tracks[i].taskClips.Add(item2);
			}
		}
		return skillTimelineAsset2;
	}
}
