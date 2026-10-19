using ACT.CharacterProperty;
using ACT.Game.Data;

namespace ACT.Event;

public class SkillGroupLevelUpEvt : BaseEventContent
{
	public int skillGrouID;

	public Character character;

	public SystemPropertySource skillSource;

	public int newLevel;

	public int rawLevel;
}
