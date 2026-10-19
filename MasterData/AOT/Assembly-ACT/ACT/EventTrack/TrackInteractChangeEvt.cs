using ACT.Battle;
using ACT.World.Asset;
using ACT.World.StateObject;
using Newtonsoft.Json.Linq;

namespace ACT.EventTrack;

public class TrackInteractChangeEvt : TrackInteractBaseEvt<TrackInteractChangeEvt>
{
	public int stateOld;

	public override void OnDispatch()
	{
		base.OnDispatch();
		MonoECS.instance.ruleManager.TryGetWorldStateAsset(interactId, out var asset);
		if (asset != null)
		{
			StateObjectBase stateObjectBase = asset.stateObjectBase;
			if ((bool)stateObjectBase && NeedRecord(asset.data) && EventConfigs.EventDictionary.TryGetValue("client_interact_state_change", out var value))
			{
				SetTransNo(value);
				value["world_id"] = worldId;
				value["swid"] = interactId;
				value["value_before"] = stateOld;
				value["value_after"] = stateCurrent;
				value["interact_type"] = interactType;
				value["character_id"] = Roleid;
				value["pos_x"] = stateObjectBase.transform.position.x;
				value["pos_y"] = stateObjectBase.transform.position.y;
				value["pos_z"] = stateObjectBase.transform.position.z;
				JObject jObject = value;
				int num = ((stateObjectBase is InteractCheckPoint) ? 1 : ((!(stateObjectBase is InteractLaser) && !(stateObjectBase is InteractLaserWeb) && !(stateObjectBase is InteractDamageArea) && !(stateObjectBase is InteractWalkureDamageArea) && !(stateObjectBase is InteractRaidTrap) && !(stateObjectBase is InteractOrbitTrap) && !(stateObjectBase is InteractMovableTrap) && !(stateObjectBase is InteractMechanismTrap)) ? ((stateObjectBase is InteractPortal) ? 6 : 0) : 4));
				jObject["event_type"] = num;
				_ = LuminApplication.LogEnabled;
				Send("client_interact_state_change", value);
			}
		}
	}

	private bool NeedRecord(StateWorldAssetData data)
	{
		if (interactType != 1 && interactType != -1)
		{
			return true;
		}
		if (data is BattleRoomData || data is ChallengeCheckPointData || data is ChallengePointData || data is ChallengePointDataEx || data is CollectionPointData || data is RaidRewardPointData || data is RogueGateData || data is RogueRewardData || data is DecodeRayCompData || data is ExplorationRobotData || data is HiddenRoomData || data is RaidCheckPointData || data is RaidCollectionData || data is RaidTrapData || data is RogueChestData || data is TempleRewardPointData)
		{
			return true;
		}
		return false;
	}
}
