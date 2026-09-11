using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("是否为指定源技能ID", 0)]
[Category("Logic/Config")]
[Description("是否为指定源技能ID")]
public class IsOriginAbilityID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> roleIDInput = AddValueInput<int>("EntityID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("源技能ID(后三位)");
		ValueInput<int> currentAbilityIDInput = AddValueInput<int>("当前技能ID(后三位)");
		FlowOutput trueOutput = AddFlowOutput("True");
		FlowOutput falseOutput = AddFlowOutput("False");
		AddFlowInput("in", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(roleIDInput.value);
			if (entityWithEntityID == null)
			{
				Debug.LogError("无法找到有效实体 " + roleIDInput.value);
				falseOutput.Call(f);
			}
			else
			{
				int num = entityWithEntityID.entityConfig.mId * 1000 + abilityIDInput.value;
				AbilityConfig config = ConfigHelper.GetInstance().GetConfig<AbilityConfig>(entityWithEntityID.entityActionAbility.mAbilityID);
				if (config == null)
				{
					Debug.LogError("无效的技能" + num);
					falseOutput.Call(f);
				}
				else
				{
					AbilityConfig config2 = ConfigHelper.GetInstance().GetConfig<AbilityConfig>(currentAbilityIDInput.value);
					if (config2 == null)
					{
						Debug.LogError("无效的技能" + currentAbilityIDInput.value);
						falseOutput.Call(f);
					}
					else if (num == config2.OriginAbility)
					{
						trueOutput.Call(f);
					}
					else
					{
						falseOutput.Call(f);
					}
				}
			}
		});
	}
}
