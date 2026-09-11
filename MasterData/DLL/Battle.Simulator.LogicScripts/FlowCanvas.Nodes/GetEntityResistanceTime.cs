using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("得到控制抗性时长", 0)]
[Category("Logic/Attribute")]
[Description("得到控制抗性时长")]
public class GetEntityResistanceTime : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		int max = 0;
		AddValueOutput("总时长(毫秒)", "总时长", () => max);
		int cur = 0;
		AddValueOutput("当前值(毫秒)", "当前值", () => cur);
		int res = 0;
		AddValueOutput("剩余值(毫秒)", "剩余值", () => res);
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOutput = AddFlowOutput("error");
		FlowOutput stateOutput = AddFlowOutput("非抗性状态中");
		AddFlowInput("", delegate(Flow f)
		{
			max = 0;
			cur = 0;
			res = 0;
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
			else
			{
				max = (int)entityWithEntityID.entityResistance.maxTime;
				cur = (int)entityWithEntityID.entityResistance.curTime;
				res = max - cur;
				if (!entityWithEntityID.entityResistance.reState)
				{
					stateOutput.Call(f);
				}
				else
				{
					output.Call(f);
				}
			}
		});
	}
}
