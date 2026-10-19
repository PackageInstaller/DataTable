using System;
using ACT.Battle.Configs;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class EntityStatePlayBehaviour : PlayableBehaviour
{
	public enum StateSource
	{
		Move,
		Attack
	}

	public StateSource stateSource = StateSource.Attack;

	public string stateName;

	public float blendOffset;

	public bool lockNormalFsmTransition = true;

	public bool allowRootMotionInTimeline;

	public ConfigAnimParameter exitParameter;
}
