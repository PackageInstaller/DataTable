using ACT.Battle;
using Bamboo.ECS;
using Fundamental;

namespace ACT.EventTrack;

public class MonsterDieEvent : TrackBaseEvt<MonsterDieEvent>
{
	public Entity entity;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("monster_die", out var value))
		{
			SetTransNo(value);
			CompStateObject compStateObject = entity.GetCompStateObject();
			CompTransform compTransform = entity.GetCompTransform();
			CompMonster compMonster = entity.GetCompMonster();
			value["world_id"] = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			value["monster_swid"] = ((compStateObject != null && compStateObject.StateWorldAssetData != null) ? compStateObject.StateWorldAssetData.stateWorldAssetUid : (-1));
			value["character_id"] = MonoECS.instance.mainEntity.GetTableId();
			value["damage"] = compMonster.totalDamage;
			value["monster_id"] = entity.GetTableId();
			value["pos_x"] = compTransform.physicsPosition.x;
			value["pos_y"] = compTransform.physicsPosition.y;
			value["pos_z"] = compTransform.physicsPosition.z;
			_ = LuminApplication.LogEnabled;
			Send("monster_die", value);
		}
	}
}
