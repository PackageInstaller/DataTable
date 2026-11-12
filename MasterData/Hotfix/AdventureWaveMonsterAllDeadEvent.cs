public class AdventureWaveMonsterAllDeadEvent : BaseAdventureEvent
{
	public int index;

	public static AdventureWaveMonsterAllDeadEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureWaveMonsterAllDeadEvent>("ADVENTURE_WAVE_MONSTER_ALL_DEAD");
	}

	public AdventureWaveMonsterAllDeadEvent()
		: base("ADVENTURE_WAVE_MONSTER_ALL_DEAD")
	{
	}

	public override void Clear()
	{
		index = 0;
	}
}
