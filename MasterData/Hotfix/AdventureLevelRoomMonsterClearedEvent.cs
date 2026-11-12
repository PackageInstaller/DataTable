public class AdventureLevelRoomMonsterClearedEvent : BaseAdventureEvent
{
	public int x;

	public int y;

	public static AdventureLevelRoomMonsterClearedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureLevelRoomMonsterClearedEvent>("BATTLE_ROOM_MONSTER_CLEARED");
	}

	public AdventureLevelRoomMonsterClearedEvent()
		: base("BATTLE_ROOM_MONSTER_CLEARED")
	{
	}

	public override void Clear()
	{
	}
}
