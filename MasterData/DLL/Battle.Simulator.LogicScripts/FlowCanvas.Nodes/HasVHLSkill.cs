using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[VHL]是否携带战术技能(逻辑)", 0)]
[Category("Logic/Config")]
[Description("检查指定ID的技能是否带入战斗，没有无过滤项。仅AI玩法可用")]
[Color("ffffff")]
public class HasVHLSkill : FlowNode
{
	private ValueInput<int> vInSkillId;

	private FlowOutput fTrue;

	private FlowOutput fFalse;

	protected override void RegisterPorts()
	{
		vInSkillId = AddValueInput<int>("技能Id");
		fTrue = AddFlowOutput("True");
		fFalse = AddFlowOutput("False");
		AddFlowInput("In", delegate(Flow f)
		{
			List<int> mVHLSkill = CommonProcessor.GetWorldState().mVHLSkill;
			if (mVHLSkill == null)
			{
				fFalse.Call(f);
			}
			else if (mVHLSkill.Contains(vInSkillId.value))
			{
				fTrue.Call(f);
			}
			else
			{
				fFalse.Call(f);
			}
		});
		AddValueOutput("技能Id", () => vInSkillId.value);
	}
}
