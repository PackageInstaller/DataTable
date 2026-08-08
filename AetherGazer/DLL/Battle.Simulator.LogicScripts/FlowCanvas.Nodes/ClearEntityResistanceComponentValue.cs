using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("清除获得的抗性点数", 0)]
[Category("Logic/Attribute")]
[Description("清除获得的抗性点数, 修改控制抗性组件, 如果没有抗性组件, 也不会报错")]
public class ClearEntityResistanceComponentValue : FlowNode
{
	private List<int> elementsChanged = new List<int>();

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> reasonInput = AddValueInput<int>("变更/开始原因", "原因");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				Debug.LogError("清除获得的抗性点数, 实体为空");
			}
			else
			{
				if (entityWithEntityID.hasEntityResistance && !entityWithEntityID.entityResistance.reState)
				{
					int curValue = entityWithEntityID.entityResistance.curValue;
					entityWithEntityID.entityResistance.curValue = 0;
					elementsChanged.AddRange(entityWithEntityID.entityResistance.element);
					entityWithEntityID.entityResistance.element.Clear();
					entityWithEntityID.entityResistance.enterReason = reasonInput.value;
					if (base.mSimContext.GetSimInterface().mResistanceChangeEvent != null)
					{
						base.mSimContext.GetSimInterface().mResistanceChangeEvent(entityWithEntityID.creationIndex, curValue, 0, elementsChanged);
					}
				}
				f.Call(output);
			}
		});
	}
}
