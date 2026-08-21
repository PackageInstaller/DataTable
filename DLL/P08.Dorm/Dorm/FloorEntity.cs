using System.Collections.Generic;
using Pathfinding;

namespace Dorm;

public class FloorEntity : TileEntity
{
	public GridNode gridNode;

	public List<Int2> friendTileEntityS;

	public override bool isOccupy
	{
		get
		{
			return isOccupy_;
		}
		set
		{
			if (isOccupy_ != value)
			{
				isOccupy_ = value;
				if (gridNode != null)
				{
					DormCoordinate.Instance.RefreshAstarPathNodeWalkable(gridNode);
				}
			}
		}
	}
}
