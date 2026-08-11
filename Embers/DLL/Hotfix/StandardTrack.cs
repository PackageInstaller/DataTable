using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class StandardTrack
{
	[SerializeReference]
	public List<TaskClip> taskClips;

	public StandardTrack()
	{
		taskClips = new List<TaskClip>();
	}
}
