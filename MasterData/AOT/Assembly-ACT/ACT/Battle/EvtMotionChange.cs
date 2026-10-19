using ACT.Battle.Configs;

namespace ACT.Battle;

public class EvtMotionChange : BaseEvt
{
	public string from;

	public string to;

	public ConfigAnimState fromState;

	public ConfigAnimState toState;

	public ConfigMotion fromMotion;

	public ConfigMotion toMotion;

	public bool isFirstMotion;

	public int skillId;

	public override void Reset()
	{
		from = string.Empty;
		to = string.Empty;
		fromState = null;
		toState = null;
		fromMotion = null;
		toMotion = null;
		isFirstMotion = false;
		skillId = 0;
	}
}
