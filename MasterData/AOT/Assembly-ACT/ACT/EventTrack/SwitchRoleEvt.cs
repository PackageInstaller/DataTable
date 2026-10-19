using System;
using ACT.Battle;
using ACT.Model;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.EventTrack;

public class SwitchRoleEvt : TrackBaseEvt<SwitchRoleEvt>
{
	public Entity switchInRole;

	public Entity switchOffRole;

	public bool isAssist;

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("role_switch", out var value) && MonoECS.instance.playState == PlayState.Battle)
		{
			SetTransNo(value);
			value["world_id"] = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			value["character_id"] = switchInRole.GetCompCharacter().characterSource.Id();
			value["exit_character_id"] = switchOffRole.GetCompCharacter().characterSource.Id();
			Vector3 physicsPosition = switchOffRole.GetCompTransform().physicsPosition;
			value["pos_x"] = physicsPosition.x;
			value["pos_y"] = physicsPosition.y;
			value["pos_z"] = physicsPosition.z;
			value["event_duration"] = TimeSpan.FromMilliseconds(TimeManager.LocalTime.NowTimestamp - Model<TeamModel>.Interface.SwitchRoleBattleStamp).TotalSeconds;
			value["is_switch_skill"] = isAssist;
			_ = LuminApplication.LogEnabled;
			Send("role_switch", value);
		}
	}
}
