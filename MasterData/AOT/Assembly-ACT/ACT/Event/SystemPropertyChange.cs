using ACT.CharacterProperty;
using ACT.Game.Data;

namespace ACT.Event;

public class SystemPropertyChange : BaseEventContent
{
	public Character beLongCharacter;

	public SystemPropertySource systemSource;

	public int propertyId;

	public float changeVal;

	public bool isReduce;

	public override void ReleaseEvt()
	{
		beLongCharacter = null;
		systemSource = SystemPropertySource.None;
		propertyId = 0;
		changeVal = 0f;
		isReduce = false;
	}
}
