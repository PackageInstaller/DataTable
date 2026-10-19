using ACT.Game.Data;

namespace ACT.Event;

public class SceneChangeEvt : BaseEventContent
{
	public SceneStatus newScene;

	public int enterWorldId;

	public int leaveWorldId;
}
