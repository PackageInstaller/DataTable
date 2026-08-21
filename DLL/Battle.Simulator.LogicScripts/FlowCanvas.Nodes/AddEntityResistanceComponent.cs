using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("添加控制抗性组件", 0)]
[Category("Logic/Attribute")]
[Description("添加控制抗性组件, 需要累积点数不能超过5, 否则报错")]
public class AddEntityResistanceComponent : FlowNode
{
	private int maxValueLimit = 10;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> maxValueInput = AddValueInput<int>("需要累积点数");
		ValueInput<int> maxTimeInput = AddValueInput<int>("免控时间(毫秒)");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int value = maxValueInput.value;
			int value2 = maxTimeInput.value;
			if (value > maxValueLimit)
			{
				Debug.LogError("添加boss抗性, 点数超过上限了");
			}
			else
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
				if (entityWithEntityID == null)
				{
					Debug.LogError("添加boss抗性, 实体为空");
				}
				else
				{
					entityWithEntityID.AddEntityResistance(value, 0, (uint)value2, 0u, newReState: false, -1, 0, 0, new List<int>());
					output.Call(f);
				}
			}
		});
	}
}
