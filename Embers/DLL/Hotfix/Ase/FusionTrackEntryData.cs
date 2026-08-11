using System;
using UnityEngine;

namespace Ase;

[Serializable]
public struct FusionTrackEntryData
{
	public string aniName;

	public float startFrame;

	[HideInInspector]
	public float frameRate;

	public bool isLoop;

	public float startTime;

	public float endTime;

	public float timeScale;

	public float transitionDuration;
}
