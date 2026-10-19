using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改Boss音乐状态", "Action", new string[] { "change", "boss", "music", "state", "sound", "audio", "voice" })]
public class ActionChangeBossMusicState : ConfigAction
{
	public int state;

	public override void Do(ActionMemory memory)
	{
		Singleton<GameManager>.instance.audioManager.SetGlobalParameter("Boss_Music_Change", state);
	}
}
