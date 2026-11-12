using Pathfinding.RVO;
using TrueSync;

public interface IDeterministicMovementBlocker
{
	bool canBlock { get; set; }

	RVOLayer blockLayer { get; set; }

	RVOLayer blockWith { get; set; }

	FP blockPriority { get; set; }

	FP blockDamp { get; set; }

	FP blockerRadius { get; set; }

	TSVector blockerPosition { get; }
}
