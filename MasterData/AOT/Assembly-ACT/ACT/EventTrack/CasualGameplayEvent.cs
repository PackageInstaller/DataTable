using ACT.World.Asset;
using Fundamental;

namespace ACT.EventTrack;

public class CasualGameplayEvent : TrackBaseEvt<CasualGameplayEvent>
{
	public int swid;

	public int opNum;

	public int status;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("casual_gameplay", out var value))
		{
			value["world_id"] = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			value["swid"] = swid;
			StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(swid);
			if (worldStateAssetDataBySGOID != null)
			{
				value["interact_type"] = worldStateAssetDataBySGOID.stateObjectType;
			}
			value["op_num"] = opNum;
			value["status"] = status;
			Send("casual_gameplay", value);
		}
	}
}
