namespace Ase;

public class GameSettingConfig
{
	public string Name;

	public float DefaultValue;

	public float MinValue;

	public float MaxValue;

	public bool DefaultSwitchTag;

	public bool BlockInBattle;

	public bool RemoteSetting;

	public GameSettingConfig(string name, float defaultValue, bool blockInBattle = false, bool remoteSetting = false, float minValue = 0f, float maxValue = 0f, bool switchTag = true)
	{
		Name = name;
		DefaultValue = defaultValue;
		MinValue = minValue;
		MaxValue = maxValue;
		BlockInBattle = blockInBattle;
		DefaultSwitchTag = switchTag;
		RemoteSetting = remoteSetting;
	}
}
