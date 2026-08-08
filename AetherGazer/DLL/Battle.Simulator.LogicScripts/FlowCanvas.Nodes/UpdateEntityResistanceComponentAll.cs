using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("抗性点加满", 0)]
[Category("Logic/Attribute")]
[Description("抗性点加满, 修改控制抗性组件, 如果没有抗性组件, 也不会报错")]
public class UpdateEntityResistanceComponentAll : FlowNode
{
	private List<int> elementsChanged = new List<int>();

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> reasonInput = AddValueInput<int>("变更/开始原因", "原因");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				Debug.LogError("抗性点加满, 实体为空");
			}
			else
			{
				if (entityWithEntityID.hasEntityResistance)
				{
					int curValue = entityWithEntityID.entityResistance.curValue;
					for (int i = entityWithEntityID.entityResistance.curValue; i < entityWithEntityID.entityResistance.maxValue; i++)
					{
						if (entityWithEntityID.entityResistance.element != null)
						{
							entityWithEntityID.entityResistance.element.Add(-1);
							elementsChanged.Add(-1);
						}
					}
					entityWithEntityID.entityResistance.curValue = entityWithEntityID.entityResistance.maxValue;
					entityWithEntityID.entityResistance.enterReason = reasonInput.value;
					if (base.mSimContext.GetSimInterface().mResistanceChangeEvent != null)
					{
						base.mSimContext.GetSimInterface().mResistanceChangeEvent(entityWithEntityID.creationIndex, curValue, entityWithEntityID.entityResistance.curValue, elementsChanged);
					}
				}
				f.Call(output);
			}
		});
	}
}
