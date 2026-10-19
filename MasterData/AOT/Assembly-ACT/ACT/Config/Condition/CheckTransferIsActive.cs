using ACT.Core;
using ACT.World.Asset;
using Fundamental;

namespace ACT.Config.Condition;

public class CheckTransferIsActive : GuideStepCondition
{
	public int transferAssetGuid;

	public override bool CheckCondition()
	{
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (worldManager.GetWorldStateAssetDataBySGOID(transferAssetGuid) is PortalData && CoreUtils.TryGetServiceSaveStateId(worldManager.ActiveWorldId, transferAssetGuid, out var stateId))
		{
			return stateId == -2;
		}
		return false;
	}
}
