namespace Spine;

public interface IUpdatable
{
	bool Active { get; }

	void Update(Skeleton.Physics physics);
}
