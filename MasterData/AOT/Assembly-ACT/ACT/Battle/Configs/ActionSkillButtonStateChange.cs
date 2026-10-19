using System;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行技能按钮状态", "Action", new string[] { "skill", "button", "state", "change", "ui", "hud", "text", "tip" })]
public class ActionSkillButtonStateChange : ConfigAction
{
	[Serializable]
	public class CustomUIChangeAction
	{
	}

	public override async void Do(ActionMemory memory)
	{
	}
}
