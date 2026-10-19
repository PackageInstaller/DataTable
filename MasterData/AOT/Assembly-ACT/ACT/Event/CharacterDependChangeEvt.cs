using ACT.Game.Data;

namespace ACT.Event;

public class CharacterDependChangeEvt : BaseEventContent
{
	public int sceneEnum;

	public bool remove;

	public CharacterDependSnapshot characterDependSnapshot;

	public CharacterDependSnapshot extraCharacterDependSnapshot;
}
