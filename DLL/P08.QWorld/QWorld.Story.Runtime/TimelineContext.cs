using System;
using UnityEngine;
using UnityEngine.Playables;

namespace QWorld.Story.Runtime;

[Serializable]
public struct TimelineContext
{
	public string tag;

	[SerializeField]
	public PlayableDirector director;
}
