using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("抗性点加一", 0)]
[Category("Logic/Attribute")]
[Description("抗性点加一, 修改控制抗性组件, 如果没有抗性组件, 也不会报错")]
public class UpdateEntityResistanceComponentOnce : FlowNode
{
	private List<int> elementsChanged = new List<int>();

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> eleInput = AddValueInput<int>("属性").SetDefaultAndSerializedValue(-1);
		ValueInput<int> reasonInput = AddValueInput<int>("变更/开始原因", "原因");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				Debug.LogError("抗性加一, 实体为空");
			}
			else
			{
				elementsChanged.Clear();
				if (entityWithEntityID.hasEntityResistance)
				{
					int curValue = entityWithEntityID.entityResistance.curValue;
					entityWithEntityID.entityResistance.curValue++;
					if (entityWithEntityID.entityResistance.element != null)
					{
						int value = eleInput.value;
						entityWithEntityID.entityResistance.element.Add(value);
						elementsChanged.Add(value);
					}
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
