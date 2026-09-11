using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("移除指定属性抗性点", 0)]
[Category("Logic/Attribute")]
[Description("移除指定属性抗性点")]
public class RemoveTargetEleResistance : FlowNode
{
	private List<int> elementsChanged = new List<int>();

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> eleInput = AddValueInput<int>("属性");
		ValueInput<bool> onceInput = AddValueInput<bool>("只移除一个");
		ValueInput<int> reasonInput = AddValueInput<int>("变更/开始原因", "原因");
		FlowOutput output = AddFlowOutput("");
		FlowOutput reStateOutput = AddFlowOutput("抗性状态中", "reState");
		FlowOutput errorOut = AddFlowOutput("Error");
		int max = 0;
		AddValueOutput("最大点数", () => max);
		int cur = 0;
		AddValueOutput("当前值", () => cur);
		int res = 0;
		AddValueOutput("成功数量", () => res);
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				Debug.LogError("移除指定属性抗性点, 实体为空");
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
					int curValue = entityWithEntityID.entityResistance.curValue;
					elementsChanged.Clear();
					res = 0;
					if (entityResistance.element != null)
					{
						int value = eleInput.value;
						bool value2 = onceInput.value;
						for (int i = 0; i < entityResistance.curValue && i < entityResistance.element.Count; i++)
						{
							if (entityResistance.element[i] == value)
							{
								elementsChanged.Add(value);
								entityResistance.element.RemoveAt(i);
								res++;
								i--;
								entityResistance.curValue--;
								if (value2)
								{
									break;
								}
							}
						}
					}
					cur = entityResistance.curValue;
					max = entityResistance.maxValue;
					entityWithEntityID.entityResistance.enterReason = reasonInput.value;
					if (base.mSimContext.GetSimInterface().mResistanceChangeEvent != null)
					{
						base.mSimContext.GetSimInterface().mResistanceChangeEvent(entityWithEntityID.creationIndex, curValue, entityWithEntityID.entityResistance.curValue, elementsChanged);
					}
					f.Call(output);
				}
			}
		});
	}
}
