using System;
using NewChess;
using Pathfinding;

public class NewChessITraversalProvider : ITraversalProvider
{
	public bool CanTraverse(Path path, GraphNode node)
	{
		if (!node.Walkable)
		{
			return false;
		}
		if (path.currentR != null)
		{
			GridNode gridNode = path.currentR.node as GridNode;
			GridNode gridNode2 = node as GridNode;
			NewHexEntity newHexEntity = NewHexManager.Instance.FindEntity(gridNode.XCoordinateInGrid, gridNode.ZCoordinateInGrid);
			NewHexEntity newHexEntity2 = NewHexManager.Instance.FindEntity(gridNode2.XCoordinateInGrid, gridNode2.ZCoordinateInGrid);
			if (!NewHexFogManager.Instance.GetIsOpenFog(newHexEntity2.gridData.x, newHexEntity2.gridData.z))
			{
				return false;
			}
			NewGridConfig gridConfig = NewChessMapCfgManager.Instance.GetGridConfig(newHexEntity.gridData.typeID, newHexEntity.gridData.status);
			NewGridConfig gridConfig2 = NewChessMapCfgManager.Instance.GetGridConfig(newHexEntity2.gridData.typeID, newHexEntity2.gridData.status);
			if (Math.Abs(gridConfig.mapLayer - gridConfig2.mapLayer) > 1)
			{
				return false;
			}
			int subx = newHexEntity2.gridData.x - newHexEntity.gridData.x;
			int subz = newHexEntity2.gridData.z - newHexEntity.gridData.z;
			int intDirBySubXZ = NewHexGridCoord.GetIntDirBySubXZ(subx, subz);
			if (gridConfig2.mapLayer == 2)
			{
				int dirByRotation = NewChessHelper.GetDirByRotation((int)newHexEntity2.gridData.rotationY);
				if (gridConfig.mapLayer == 1)
				{
					if (intDirBySubXZ != dirByRotation)
					{
						return false;
					}
				}
				else if (gridConfig.mapLayer == 3)
				{
					int num = (dirByRotation + 3) % 6;
					if (intDirBySubXZ != num)
					{
						return false;
					}
				}
			}
			if (gridConfig.mapLayer == 2)
			{
				int dirByRotation2 = NewChessHelper.GetDirByRotation((int)newHexEntity.gridData.rotationY);
				if (gridConfig2.mapLayer == 1)
				{
					int num2 = (dirByRotation2 + 3) % 6;
					if (intDirBySubXZ != num2)
					{
						return false;
					}
				}
				else if (gridConfig2.mapLayer == 3 && intDirBySubXZ != dirByRotation2)
				{
					return false;
				}
			}
			int realTypeID = NewChessMapCfgManager.Instance.GetRealTypeID(newHexEntity2.gridData.typeID, newHexEntity2.gridData.status);
			if (NewChessMapCfgManager.Instance.CheckGridTypeIsConveyorIDList(realTypeID))
			{
				int num3 = (NewChessHelper.GetDirByRotation((int)newHexEntity2.gridData.rotationY) + 3) % 6;
				if (intDirBySubXZ == num3)
				{
					return false;
				}
			}
			if (NewChessMapCfgManager.Instance.CheckGridTypeIsReverseConveyorIDList(realTypeID))
			{
				int dirByRotation3 = NewChessHelper.GetDirByRotation((int)newHexEntity2.gridData.rotationY);
				if (intDirBySubXZ == dirByRotation3)
				{
					return false;
				}
			}
			int realTypeID2 = NewChessMapCfgManager.Instance.GetRealTypeID(newHexEntity.gridData.typeID, newHexEntity.gridData.status);
			if (NewChessMapCfgManager.Instance.CheckGridTypeIsConveyorIDList(realTypeID2))
			{
				int num4 = (NewChessHelper.GetDirByRotation((int)newHexEntity.gridData.rotationY) + 3) % 6;
				if (intDirBySubXZ == num4)
				{
					return false;
				}
			}
			if (NewChessMapCfgManager.Instance.CheckGridTypeIsReverseConveyorIDList(realTypeID2))
			{
				int dirByRotation4 = NewChessHelper.GetDirByRotation((int)newHexEntity.gridData.rotationY);
				if (intDirBySubXZ == dirByRotation4)
				{
					return false;
				}
			}
			return node.Walkable;
		}
		if (NewChessHelper.AstarPathHelpCount > 0 && (node == (path as ABPath).startNode || node == (path as ABPath).endNode))
		{
			NewChessHelper.AstarPathHelpCount--;
			return node.Walkable;
		}
		GridNode gridNode3 = (path as ABPath).startNode as GridNode;
		GridNode gridNode4 = node as GridNode;
		NewHexEntity newHexEntity3 = NewHexManager.Instance.FindEntity(gridNode3.XCoordinateInGrid, gridNode3.ZCoordinateInGrid);
		NewHexEntity newHexEntity4 = NewHexManager.Instance.FindEntity(gridNode4.XCoordinateInGrid, gridNode4.ZCoordinateInGrid);
		if (!NewHexFogManager.Instance.GetIsOpenFog(newHexEntity4.gridData.x, newHexEntity4.gridData.z))
		{
			return false;
		}
		NewGridConfig gridConfig3 = NewChessMapCfgManager.Instance.GetGridConfig(newHexEntity3.gridData.typeID, newHexEntity3.gridData.status);
		NewGridConfig gridConfig4 = NewChessMapCfgManager.Instance.GetGridConfig(newHexEntity4.gridData.typeID, newHexEntity4.gridData.status);
		if (Math.Abs(gridConfig3.mapLayer - gridConfig4.mapLayer) > 1)
		{
			return false;
		}
		int subx2 = newHexEntity4.gridData.x - newHexEntity3.gridData.x;
		int subz2 = newHexEntity4.gridData.z - newHexEntity3.gridData.z;
		int intDirBySubXZ2 = NewHexGridCoord.GetIntDirBySubXZ(subx2, subz2);
		if (gridConfig4.mapLayer == 2)
		{
			int dirByRotation5 = NewChessHelper.GetDirByRotation((int)newHexEntity4.gridData.rotationY);
			if (gridConfig3.mapLayer == 1)
			{
				if (intDirBySubXZ2 != dirByRotation5)
				{
					return false;
				}
			}
			else if (gridConfig3.mapLayer == 3)
			{
				int num5 = (dirByRotation5 + 3) % 6;
				if (intDirBySubXZ2 != num5)
				{
					return false;
				}
			}
		}
		if (gridConfig3.mapLayer == 2)
		{
			int dirByRotation6 = NewChessHelper.GetDirByRotation((int)newHexEntity3.gridData.rotationY);
			if (gridConfig4.mapLayer == 1)
			{
				int num6 = (dirByRotation6 + 3) % 6;
				if (intDirBySubXZ2 != num6)
				{
					return false;
				}
			}
			else if (gridConfig4.mapLayer == 3 && intDirBySubXZ2 != dirByRotation6)
			{
				return false;
			}
		}
		int realTypeID3 = NewChessMapCfgManager.Instance.GetRealTypeID(newHexEntity4.gridData.typeID, newHexEntity4.gridData.status);
		if (NewChessMapCfgManager.Instance.CheckGridTypeIsConveyorIDList(realTypeID3))
		{
			int num7 = (NewChessHelper.GetDirByRotation((int)newHexEntity4.gridData.rotationY) + 3) % 6;
			if (intDirBySubXZ2 == num7)
			{
				return false;
			}
		}
		if (NewChessMapCfgManager.Instance.CheckGridTypeIsReverseConveyorIDList(realTypeID3))
		{
			int dirByRotation7 = NewChessHelper.GetDirByRotation((int)newHexEntity4.gridData.rotationY);
			if (intDirBySubXZ2 == dirByRotation7)
			{
				return false;
			}
		}
		int realTypeID4 = NewChessMapCfgManager.Instance.GetRealTypeID(newHexEntity3.gridData.typeID, newHexEntity3.gridData.status);
		if (NewChessMapCfgManager.Instance.CheckGridTypeIsConveyorIDList(realTypeID4))
		{
			int num8 = (NewChessHelper.GetDirByRotation((int)newHexEntity3.gridData.rotationY) + 3) % 6;
			if (intDirBySubXZ2 == num8)
			{
				return false;
			}
		}
		if (NewChessMapCfgManager.Instance.CheckGridTypeIsReverseConveyorIDList(realTypeID4))
		{
			int dirByRotation8 = NewChessHelper.GetDirByRotation((int)newHexEntity3.gridData.rotationY);
			if (intDirBySubXZ2 == dirByRotation8)
			{
				return false;
			}
		}
		return node.Walkable;
	}

	public uint GetTraversalCost(Path path, GraphNode node)
	{
		return node.Penalty;
	}
}
