using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能类型", 0)]
[Category("Logic/Abilities")]
[Description("判断ability的类型")]
public class IsAttack : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> abilityIDInput = AddValueInput<int>("abilityID");
		FlowOutput attack = AddFlowOutput("普攻");
		FlowOutput skill2 = AddFlowOutput("技能");
		FlowOutput other = AddFlowOutput("其他");
		FlowOutput error = AddFlowOutput("错误");
		AddFlowInput("In", delegate(Flow f)
		{
			int value = abilityIDInput.value;
			if (!ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(value / 1000, out var config))
			{
				error.Call(f);
			}
			else if (config.Melees.Contains(value))
			{
				attack.Call(f);
			}
			else if (config.Ability.Contains(value))
			{
				skill2.Call(f);
			}
			else
			{
				other.Call(f);
			}
		});
	}
}
