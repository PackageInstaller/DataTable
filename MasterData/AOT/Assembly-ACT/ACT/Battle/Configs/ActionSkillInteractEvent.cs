using ACT.Event;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行技能交互事件", "Action", new string[] { "skill", "interact", "event", "ability", "cd" })]
public class ActionSkillInteractEvent : ConfigAction
{
	public int id;

	public SendInteractEventType type;

	public string animatorPara;

	public ConfigAnimParameterType animType;

	public float floatValue;

	public int intValue;

	public bool boolValue;

	public override void Do(ActionMemory memory)
	{
		SkillInteractEvt evt = Singleton<EventManager>.instance.GetEvt<SkillInteractEvt>();
		evt.id = id;
		SendInteractEventType sendInteractEventType = type;
		if (sendInteractEventType != SendInteractEventType.FireEffect && sendInteractEventType == SendInteractEventType.needSendPara2Animator)
		{
			evt.interactEventType = SendInteractEventType.needSendPara2Animator;
			evt.animatorPara = animatorPara;
			evt.animatorPataType = animType;
			switch (animType)
			{
			case ConfigAnimParameterType.Int:
				evt.intvalue = intValue;
				break;
			case ConfigAnimParameterType.Float:
				evt.floatvalue = floatValue;
				break;
			case ConfigAnimParameterType.Bool:
				evt.boolValue = boolValue;
				break;
			case ConfigAnimParameterType.Trigger:
				evt.boolValue = true;
				break;
			}
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.SkillInteract, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
