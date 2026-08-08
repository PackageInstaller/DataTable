using System;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

[Serializable]
public class TimeDilationBehaviour : PlayableBehaviour
{
	public float timeScale = 1f;
}
