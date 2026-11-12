public class AdventureSpawnPointMsg : BaseAdventureEvent
{
	public string spawnGroupName;

	public string spawnWaveName;

	public int groupDiedNum;

	public int groupRemindNum;

	public int waveDiedNum;

	public int waveRemindNum;

	public static AdventureSpawnPointMsg Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureSpawnPointMsg>("BATTLE_SPAWNPOINT_MSG");
	}

	public AdventureSpawnPointMsg()
		: base("BATTLE_SPAWNPOINT_MSG")
	{
	}

	public override void Clear()
	{
		spawnGroupName = string.Empty;
		spawnWaveName = string.Empty;
	}
}
