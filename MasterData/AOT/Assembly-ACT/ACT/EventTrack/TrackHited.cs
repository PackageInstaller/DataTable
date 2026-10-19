using Bamboo.ECS;
using Fundamental;

namespace ACT.EventTrack;

public class TrackHited : TrackHitedBaseEvt<TrackHited>
{
	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("hit_by_monster", out var value) && attacker.IsMonster() && attackee.IsCharacter())
		{
			SetTransNo(value);
			value["world_id"] = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			value["monster_swid"] = attacker.GetCompStateObject()?.StateWorldAssetData?.stateWorldAssetUid ?? (-1);
			value["monster_id"] = attacker.GetCompMonster().id;
			value["character_id"] = attackee.GetCompCharacter().characterSource.Id();
			_ = LuminApplication.LogEnabled;
			Send("hit_by_monster", value);
		}
	}
}
