using Pathfinding;

namespace P08.SimBusiness.Pathfinding;

public interface IPathModifier
{
	int Order { get; }

	void Apply(Path path);

	void PreProcess(Path path);
}
