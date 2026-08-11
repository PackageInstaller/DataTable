using GameFramework.Runtime;

namespace Ase;

public class LevelSaveMessage : MessageBase
{
	private int levelId;

	private int itemId;

	private LevelSaveMessageType messageType;

	public LevelSaveMessageType MessageType => messageType;

	public int LevelId => levelId;

	public int ItemId => itemId;

	public LevelSaveMessage(object sender, LevelSaveMessageType messageType, int levelId, int itemId)
		: base(sender)
	{
		this.messageType = messageType;
		this.levelId = levelId;
		this.itemId = itemId;
	}
}
