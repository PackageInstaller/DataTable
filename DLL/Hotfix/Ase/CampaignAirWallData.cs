using System;
using UnityEngine;

namespace Ase;

[Serializable]
public class CampaignAirWallData
{
	public const string AirWallTag = "AirWall";

	public const string DefaultObjectName = "Quad";

	public const string RuntimeRootName = "CampaignAirWallRoot";

	public const string DefaultMaterialAssetPath = "Assets/Art/MapData/Campaign/Unlit_Lattice.mat";

	public int airWallId;

	public Vector3 airWallPos;

	public Vector3 airWallRot;

	public Vector3 airWallScale = Vector3.one;

	public CampaignAirWallData Clone()
	{
		return new CampaignAirWallData
		{
			airWallId = airWallId,
			airWallPos = airWallPos,
			airWallRot = airWallRot,
			airWallScale = airWallScale
		};
	}
}
