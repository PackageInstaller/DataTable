using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("修改控制抗性时长", 0)]
[Category("Logic/Attribute")]
[Description("修改控制抗性时长, 当前不在免控期间的话, 就没意义")]
public class ModifyEntityResistanceTime : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> valueInput = AddValueInput<int>("目标值(毫秒)", "目标值");
		ValueInput<int> reasonInput = AddValueInput<int>("结束原因", "原因");
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOutput = AddFlowOutput("error");
		FlowOutput stateOutput = AddFlowOutput("非抗性状态中");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				Debug.LogError("实体为空");
				errorOutput.Call(f);
			}
			else if (!entityWithEntityID.hasEntityResistance)
			{
				errorOutput.Call(f);
			}
			else if (!entityWithEntityID.entityResistance.reState)
			{
				stateOutput.Call(f);
			}
			else
			{
				entityWithEntityID.entityResistance.curTime = (uint)valueInput.value;
				entityWithEntityID.entityResistance.exitReason = reasonInput.value;
				output.Call(f);
			}
		});
	}
}
