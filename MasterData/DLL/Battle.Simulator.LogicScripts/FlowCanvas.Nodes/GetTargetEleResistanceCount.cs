using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("得到指定属性抗性点数量", 0)]
[Category("Logic/Attribute")]
[Description("得到指定属性抗性点数量")]
public class GetTargetEleResistanceCount : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> eleInput = AddValueInput<int>("属性");
		FlowOutput output = AddFlowOutput("");
		FlowOutput reStateOutput = AddFlowOutput("抗性状态中", "reState");
		FlowOutput errorOut = AddFlowOutput("Error");
		int max = 0;
		AddValueOutput("最大点数", () => max);
		int cur = 0;
		AddValueOutput("当前值", () => cur);
		int res = 0;
		AddValueOutput("指定属性点数", () => res);
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				Debug.LogError("得到指定属性抗性点数量, 实体为空");
				errorOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityResistance)
			{
				Debug.LogError("得到指定属性抗性点数量, 实体没有控制抗性");
				errorOut.Call(f);
			}
			else
			{
				EntityResistance entityResistance = entityWithEntityID.entityResistance;
				if (entityResistance.reState)
				{
					reStateOutput.Call(f);
				}
				else
				{
					cur = entityResistance.curValue;
					max = entityResistance.maxValue;
					res = 0;
					if (entityResistance.element != null)
					{
						int value = eleInput.value;
						for (int i = 0; i < cur && i < entityResistance.element.Count; i++)
						{
							if (entityResistance.element[i] == value)
							{
								res++;
							}
						}
					}
					f.Call(output);
				}
			}
		});
	}
}
