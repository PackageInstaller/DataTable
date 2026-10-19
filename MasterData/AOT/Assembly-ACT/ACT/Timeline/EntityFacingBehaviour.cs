using System;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class EntityFacingBehaviour : PlayableBehaviour
{
	public enum FacingDirection
	{
		Left,
		Right
	}

	public FacingDirection direction = FacingDirection.Right;

	[NonSerialized]
	private bool _applied;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (Application.isPlaying && !_applied)
		{
			Entity entity = EntityControlPlayableUtility.ResolveEntity(playerData);
			if (!(entity == null))
			{
				entity.SetFaceLeft(direction == FacingDirection.Left);
				entity.GetCompPhysics()?.SetDirImmediately();
				_applied = true;
			}
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		_applied = false;
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		_applied = false;
	}
}
