using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[VHL]读取战术技能槽(逻辑)", 0)]
[Category("Logic/Config")]
[Description("根据输入槽位，读取本次战斗带入的战术技能id。仅AI玩法可用")]
[Color("ffffff")]
public class GetVHLSkillID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> indexInput = AddValueInput<int>("数组下标");
		FlowOutput output = AddFlowOutput("");
		FlowOutput outputError = AddFlowOutput("error");
		int result = 0;
		AddValueOutput("SkillID", () => result);
		AddFlowInput("", delegate(Flow f)
		{
			List<int> mVHLSkill = CommonProcessor.GetWorldState().mVHLSkill;
			int value = indexInput.value;
			if (mVHLSkill == null || value >= mVHLSkill.Count)
			{
				outputError.Call(f);
			}
			else
			{
				result = mVHLSkill[value];
				output.Call(f);
			}
		});
	}
}
