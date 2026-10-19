using ACT.UI;

namespace ACT.Event;

public class CharacterSecondOpenEvent : BaseEventContent
{
	public CharacterViewScene.CvSceneType type;

	public override void ReleaseEvt()
	{
		type = CharacterViewScene.CvSceneType.None;
	}
}
