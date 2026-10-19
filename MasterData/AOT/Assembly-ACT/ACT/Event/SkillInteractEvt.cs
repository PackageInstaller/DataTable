using ACT.Battle.Configs;

namespace ACT.Event;

public class SkillInteractEvt : BaseEventContent
{
	public int id;

	public SendInteractEventType interactEventType;

	public string animatorPara;

	public ConfigAnimParameterType animatorPataType;

	public bool boolValue;

	public float floatvalue;

	public int intvalue;
}
