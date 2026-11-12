using UnityEngine;

[CreateAssetMenu(fileName = "BootConfig", menuName = "BootConfig/BootConfig", order = 10)]
public class BootConfig : ScriptableObject, IBootConfig
{
	public const string PREFS_KEY_CONFIG_PATH = "editor_game_boot_config";

	public string entryLuaFile;

	public string entryModuleName;

	public bool skipUpdateClient = true;

	public bool skipUpdateResource = true;

	public bool skipNetworkConnection = true;

	public bool cleanBeforeInstall;

	public AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams();

	[SerializeField]
	public GameTeamConfig teamConfig;

	public AdventureAutoBattleConfig autoBattleConfig;

	public int metaTag;

	[TextArea(5, 50)]
	public string metaData;

	[Space]
	[TextArea(5, 50)]
	public string comment;

	string IBootConfig.EntryLuaFile => entryLuaFile;

	string IBootConfig.EntryModuleName => entryModuleName;

	bool IBootConfig.SkipNetworkConnection => skipNetworkConnection;

	bool IBootConfig.SkipUpdateClient => skipUpdateClient;

	bool IBootConfig.SkipUpdateResource => skipUpdateResource;

	bool IBootConfig.CleanBeforeInstall => cleanBeforeInstall;

	int IBootConfig.MetaTag => metaTag;

	string IBootConfig.MetaData => metaData;

	public int GetMetaTag()
	{
		return metaTag;
	}

	public object GetMetaData()
	{
		if (adventureModuleLevelLoadParams.loadType != AdventureModuleLevelLoadParams.BootConfigLoadType.None)
		{
			return adventureModuleLevelLoadParams;
		}
		return metaData;
	}
}
