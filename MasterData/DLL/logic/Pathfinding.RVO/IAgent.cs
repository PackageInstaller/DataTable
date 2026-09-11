using System;
using System.Collections.Generic;

namespace Pathfinding.RVO;

public interface IAgent
{
	Int2 Position { get; set; }

	Int ElevationCoordinate { get; set; }

	Int2 CalculatedTargetPoint { get; }

	Int CalculatedSpeed { get; }

	bool Locked { get; set; }

	Int Radius { get; set; }

	Int Height { get; set; }

	VFactor AgentTimeHorizon { get; set; }

	VFactor ObstacleTimeHorizon { get; set; }

	int MaxNeighbours { get; set; }

	int NeighbourCount { get; }

	RVOLayer Layer { get; set; }

	RVOLayer CollidesWith { get; set; }

	bool DebugDraw { get; set; }

	[Obsolete]
	List<ObstacleVertex> NeighbourObstacles { get; }

	VFactor Priority { get; set; }

	Action PreCalculationCallback { set; }

	void SetTarget(int ownerID, Int2 targetPoint, Int desiredSpeed, Int maxSpeed);

	void SetCollisionNormal(Int2 normal);

	void ForceSetVelocity(Int2 velocity);
}
