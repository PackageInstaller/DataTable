using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否普攻", 0)]
[Category("Logic/Config")]
[Description("判断是否为普攻，根据7位技能的前4位角色id寻找RoleConfig，并查找普攻栏\n传入的抛掷物ID不为0时，会优先以抛掷物的根源Timeline为准\nTrue：该技能为对应角色普攻技能时\nFalse：找不到对应角色的配置，或该技能不在对应角色配置的普攻列，或输入的ID为0时")]
public class IsAbilityNormalAttack : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> abilityID = AddValueInput<int>("技能ID");
		ValueInput<int> thrownID = AddValueInput<int>("抛掷物ID(可选)", "thrownID").SetDefaultAndSerializedValue(0);
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			int num = 0;
			RoleConfig roleConfig = null;
			if (thrownID.value != 0 && ThrownProcessor.TryGetThrown(base.mSimContext, thrownID.value, out var thrownState))
			{
				num = thrownState.mCreatedRootTimelineID / 1000;
				roleConfig = ConfigHelper.GetInstance().GetConfig<RoleConfig>(num);
				if (roleConfig == null)
				{
					falseOut.Call(f);
				}
				else if (roleConfig.Melees.Contains(thrownState.mCreatedRootTimelineID))
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
			else if (abilityID.value == 0)
			{
				falseOut.Call(f);
			}
			else
			{
				num = abilityID.value / 1000;
				roleConfig = ConfigHelper.GetInstance().GetConfig<RoleConfig>(num);
				if (roleConfig == null)
				{
					falseOut.Call(f);
				}
				else if (roleConfig.Melees.Contains(abilityID.value))
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
	}
}
