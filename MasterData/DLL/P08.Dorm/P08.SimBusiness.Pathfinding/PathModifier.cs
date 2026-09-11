using System;
using Pathfinding;

namespace P08.SimBusiness.Pathfinding;

[Serializable]
public abstract class PathModifier : IPathModifier
{
	[NonSerialized]
	public PathfindingSeeker seeker;

	public abstract int Order { get; }

	public void Awake(PathfindingSeeker seeker)
	{
		this.seeker = seeker;
		if (seeker != null)
		{
			seeker.RegisterModifier(this);
		}
	}

	public void OnDestroy(PathfindingSeeker seeker)
	{
		if (seeker != null)
		{
			seeker.DeregisterModifier(this);
		}
	}

	public virtual void PreProcess(Path path)
	{
	}

	public abstract void Apply(Path path);
}
