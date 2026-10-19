using System;
using ACT.Game.Data;
using ACT.World;
using UnityEngine;

namespace ACT.UI;

[Serializable]
public class SelfNodeData
{
	public int id;

	public int iconTypeId;

	public Vector3 worldPos;

	public MapArea mapArea;

	public static SelfNodeData FromPB(MapCustomFlag pb)
	{
		if (pb == null)
		{
			return null;
		}
		return new SelfNodeData
		{
			id = pb.Id,
			iconTypeId = pb.Tid,
			worldPos = new Vector3(pb.Pos.X, pb.Pos.Y, pb.Pos.Z),
			mapArea = (MapArea)pb.AreaID
		};
	}

	public static void UpdateFromPB(SelfNodeData data, MapCustomFlag pb)
	{
		if (pb != null)
		{
			data.id = pb.Id;
			data.iconTypeId = pb.Tid;
			data.worldPos = new Vector3(pb.Pos.X, pb.Pos.Y, pb.Pos.Z);
			data.mapArea = (MapArea)pb.AreaID;
		}
	}
}
