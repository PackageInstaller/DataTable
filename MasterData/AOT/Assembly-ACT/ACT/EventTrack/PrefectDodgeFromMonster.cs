using Fundamental;

namespace ACT.EventTrack;

public class PrefectDodgeFromMonster : TrackBaseEvt<PrefectDodgeFromMonster>
{
	public int monsterId;

	public int monsterSwid;

	public int skillId;

	public bool isWitch;

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("perfect_dodge_from_monster", out var value))
		{
			SetTransNo(value);
			value["world_id"] = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
			value["monster_swid"] = monsterSwid;
			value["monster_id"] = monsterId;
			value["skill_id"] = skillId;
			value["is_witch"] = isWitch;
			_ = LuminApplication.LogEnabled;
			Send("perfect_dodge_from_monster", value);
		}
	}
}
