using System;
using ACT.Event;
using ACT.UI;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行技能按钮提示", "Action", new string[] { "skill", "button", "prompt", "ui", "hud", "text", "tip" })]
public class ActionSkillButtonPrompt : ConfigAction
{
	public enum SkillButtonPromptType
	{
		JumpBtn,
		DodgeBtn,
		AttackBtn,
		SpAttackBtn,
		UltraBtn
	}

	public SkillButtonPromptType type;

	public override void Do(ActionMemory memory)
	{
		PromptOperateBtnEvt evt = Singleton<EventManager>.instance.GetEvt<PromptOperateBtnEvt>();
		evt.entityId = memory.target.entity.Id;
		PromptOperateBtnEvt promptOperateBtnEvt = evt;
		promptOperateBtnEvt.customUICompType = type switch
		{
			SkillButtonPromptType.JumpBtn => CustomUICompType.JumpBtn, 
			SkillButtonPromptType.DodgeBtn => CustomUICompType.DodgeBtn, 
			SkillButtonPromptType.AttackBtn => CustomUICompType.AttackBtn, 
			SkillButtonPromptType.SpAttackBtn => CustomUICompType.SpAttackBtn, 
			SkillButtonPromptType.UltraBtn => CustomUICompType.UltraBtn, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_OperateBtn_PromptBtn, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
