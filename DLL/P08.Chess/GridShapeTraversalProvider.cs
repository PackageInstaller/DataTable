using System;
using System.Collections.Generic;
using Chess;
using Pathfinding;

internal class GridShapeTraversalProvider : ITraversalProvider
{
	private List<Int2> reachableCoord;

	private Int2 center;

	private List<Int2> touchableCoord;

	public static GridShapeTraversalProvider SquareShape(int centerX, int centerZ, int range)
	{
		return new GridShapeTraversalProvider
		{
			reachableCoord = ChessHelper.GetRangeNodeS(centerX, centerZ, range - 1),
			center = new Int2(centerX, centerZ),
			touchableCoord = ChessHelper.GetRangeNodeS(centerX, centerZ, range)
		};
	}

	public bool CanTraverse(Path path, GraphNode node)
	{
		if (!(node is GridNodeBase { XCoordinateInGrid: var xCoordinateInGrid, ZCoordinateInGrid: var zCoordinateInGrid }))
		{
			return node.Walkable;
		}
		if (xCoordinateInGrid == center.x && zCoordinateInGrid == center.y)
		{
			return false;
		}
		for (int i = 0; i < reachableCoord.Count && (reachableCoord[i].x != xCoordinateInGrid || reachableCoord[i].y != zCoordinateInGrid); i++)
		{
		}
		throw new NotImplementedException();
	}

	public uint GetTraversalCost(Path path, GraphNode node)
	{
		throw new NotImplementedException();
	}
}
