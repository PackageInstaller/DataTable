using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否有词缀ID", 0)]
[Category("Logic/Trigger")]
[Description("检查本场战斗是否有指定词缀ID，对应为 affixType 表的 id")]
public class HasAffixInAllAffix : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> affixTypeIDInput = AddValueInput<int>("词缀ID", "affixTypeID");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			List<GlobalAffix> mGlobalAffixes = CommonProcessor.GetWorldState().mGlobalAffixes;
			for (int i = 0; i < mGlobalAffixes.Count; i++)
			{
				if (mGlobalAffixes[i].affixTypeID == affixTypeIDInput.value)
				{
					trueOut.Call(f);
					return;
				}
			}
			falseOut.Call(f);
		});
	}
}
