namespace ACT.EventTrack;

public class NpcInteractEvent : TrackBaseEvt<NpcInteractEvent>
{
	public int npcId;

	public int type;

	public int dramaId;

	public int subMissionId;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("npc_interact", out var value))
		{
			value["npc_id"] = npcId;
			value["type"] = type;
			value["drama_id"] = dramaId;
			value["sub_mission_id"] = subMissionId;
			value["player_level"] = SystemUnlockManager.playerLevel;
			Send("npc_interact", value);
		}
	}
}
