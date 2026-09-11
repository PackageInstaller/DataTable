using System;
using Pathfinding;

namespace P08.SimBusiness.Pathfinding;

[Serializable]
public abstract class MonoModifier : VersionedMonoBehaviour, IPathModifier
{
	[NonSerialized]
	public PathfindingSeeker seeker;

	public abstract int Order { get; }

	protected virtual void OnEnable()
	{
		seeker = GetComponent<PathfindingSeeker>();
		if (seeker != null)
		{
			seeker.RegisterModifier(this);
		}
	}

	protected virtual void OnDisable()
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
