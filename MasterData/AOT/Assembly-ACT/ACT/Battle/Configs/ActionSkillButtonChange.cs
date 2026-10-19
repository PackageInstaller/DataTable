using ACT.Event;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行技能按钮", "Action", new string[] { "skill", "button", "change", "ui", "hud", "text", "tip" })]
public class ActionSkillButtonChange : ConfigAction
{
	public string skillName;

	public override async void Do(ActionMemory memory)
	{
		RebindSkillBtnEvt evt = Singleton<EventManager>.instance.GetEvt<RebindSkillBtnEvt>();
		evt.entity = memory.target.entity;
		evt.motionName = skillName;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_OperateBtnRebindSkill, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
