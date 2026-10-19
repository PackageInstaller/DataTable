using ACT.Battle;
using Bamboo.ECS;
using Fundamental;

namespace ACT.EventTrack;

public class TrackEntityDie : TrackHitedBaseEvt<TrackEntityDie>
{
	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("killed_by_monster", out var value) && attacker.IsMonster() && attackee.IsCharacter())
		{
			SetTransNo(value);
			value["world_id"] = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			value["monster_swid"] = attacker.GetCompStateObject()?.StateWorldAssetData?.stateWorldAssetUid ?? (-1);
			value["monster_id"] = attacker.GetCompMonster().id;
			value["character_id"] = attackee.GetCompCharacter().characterSource.Id();
			value["damage"] = MonoECS.instance.damageStatisticsManager.MonsterDamage;
			_ = LuminApplication.LogEnabled;
			Send("killed_by_monster", value);
		}
	}
}
