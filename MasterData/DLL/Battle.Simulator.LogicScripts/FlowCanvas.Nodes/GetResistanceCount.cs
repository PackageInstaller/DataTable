using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("得到抗性点数量(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("得到抗性点数量")]
public class GetResistanceCount : FlowNode
{
	private List<int> ret = new List<int>();

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		FlowOutput reStateOutput = AddFlowOutput("抗性状态中", "reState");
		FlowOutput errorOut = AddFlowOutput("Error");
		int max = 0;
		AddValueOutput("最大点数", () => max);
		int cur = 0;
		AddValueOutput("当前值", () => cur);
		AddValueOutput("指定属性点数", () => ret);
		AddFlowInput("", delegate(Flow f)
		{
			ret.Clear();
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
					if (entityResistance.element != null)
					{
						for (int i = 0; i < cur && i < entityResistance.element.Count; i++)
						{
							ret.Add(entityResistance.element[i]);
						}
					}
					f.Call(output);
				}
			}
		});
	}
}
