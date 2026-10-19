using ACT.Battle.Configs;

namespace ACT.UI;

public class BuffIconInfo
{
	public string AbilityName { get; private set; }

	public int IconId { get; private set; }

	public int Priority { get; private set; }

	public BuffIconType Type { get; private set; }

	public int Stack { get; set; }

	public BuffIconInfo(string abilityName, int iconId, int priority, BuffIconType type, int stack)
	{
		AbilityName = abilityName;
		IconId = iconId;
		Priority = priority;
		Type = type;
		Stack = stack;
	}
}
