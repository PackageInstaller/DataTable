using ACT.Game;
using ACT.Game.Data;
using ACT.World.Asset;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class CheckPointManager
{
	public void SetCheckPoint(int checkPointSwid)
	{
		if (GetCurrentSceneInfo().CheckPosUid != checkPointSwid)
		{
			G.service.RecordCheckPos(checkPointSwid);
		}
	}

	public Vector3 GetLastCheckPoint()
	{
		SceneInfo currentSceneInfo = GetCurrentSceneInfo();
		StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(currentSceneInfo.CheckPosUid);
		if (worldStateAssetDataBySGOID != null && worldStateAssetDataBySGOID is CheckPointData checkPointData)
		{
			return checkPointData.initPos;
		}
		return default;
	}

	public SceneInfo GetCurrentSceneInfo()
	{
		return G.localPlayer.Profile.SceneInfos[(int)G.localPlayer.Profile.SceneStatus];
	}
}
