using NodeCanvas.Framework;
using UnityEngine;

namespace NodeCanvas.BehaviourTrees;

[AddComponentMenu("NodeCanvas/Behaviour Tree Owner")]
public class BehaviourTreeOwner : GraphOwner<BehaviourTree>
{
	public bool repeat
	{
		get
		{
			if (!(base.behaviour != null))
			{
				return true;
			}
			return base.behaviour.repeat;
		}
		set
		{
			if (base.behaviour != null)
			{
				base.behaviour.repeat = value;
			}
		}
	}

	public float updateInterval
	{
		get
		{
			if (!(base.behaviour != null))
			{
				return 0f;
			}
			return base.behaviour.updateInterval;
		}
		set
		{
			if (base.behaviour != null)
			{
				base.behaviour.updateInterval = value;
			}
		}
	}

	public Status rootStatus
	{
		get
		{
			if (!(base.behaviour != null))
			{
				return Status.Resting;
			}
			return base.behaviour.rootStatus;
		}
	}
}
