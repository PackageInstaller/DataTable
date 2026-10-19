using ACT.Sound;

namespace ACT.Event;

public class PlayCommonAudioEvt : BaseEventContent
{
	public CommonAudioType AudioType;

	public bool NotifyAudioPlayOver;

	public override void ReleaseEvt()
	{
		AudioType = CommonAudioType.None;
		NotifyAudioPlayOver = false;
	}
}
