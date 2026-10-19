using ACT.Battle;
using Bamboo.ECS;
using Fundamental;

namespace ACT.EventTrack;

public class TrapInteractDamage : TrackHitedBaseEvt<TrapInteractDamage>
{
	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("trap_interact_damage", out var value) && attacker.IsCollection() && attacker.GetCompNeutral().trapType != 0 && attackee.IsCharacter())
		{
			SetTransNo(value);
			CompStateObject compStateObject = attacker.GetCompStateObject();
			value["world_id"] = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			value["swid"] = compStateObject.StateWorldAssetData.stateWorldAssetUid;
			value["value"] = compStateObject.StateWorldAssetData.stateId;
			value["interact_type"] = compStateObject.StateWorldAssetData.stateObjectType;
			value["character_id"] = attackee.GetCompCharacter().characterSource.Id();
			_ = LuminApplication.LogEnabled;
			Send("trap_interact_damage", value);
		}
	}
}
