using System;
using ACT.Event;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[Obsolete]
[AbilityTypeMetadata("触发强化技能状态", "Action", new string[] { "trigger", "strength", "skill", "state", "ability", "cd" })]
public class ActionTriggerStrengthSkillState : ConfigAction
{
	[SerializeField]
	private BtnType customUIBtnType;

	public override void Do(ActionMemory memory)
	{
		TriggerSkillBtnStrengthStateEvt evt = Singleton<EventManager>.instance.GetEvt<TriggerSkillBtnStrengthStateEvt>();
		evt.entityId = memory.target.entity.Id;
		evt.btnType = customUIBtnType;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_OperateBtnStrengthSkillState, null);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
