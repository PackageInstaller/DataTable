using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取技能下标", 0)]
[Category("Logic/Abilities")]
[Description("获取技能下标, 用于区别技能是普攻还是一技能等,没有配置则传出0")]
public class GetAbilitySkillIndex : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("TimelineID");
		AddValueOutput("实体ID", () => entityIDInput.GetValue());
		AddValueOutput("下标", () => ConfigHelper.GetInstance().GetConfig<public_skill>(abilityIDInput.GetValue()).SkillIndex);
	}
}
