using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历抛掷物(逻辑)", 0)]
[Category("Logic/抛掷物")]
[Description("遍历抛掷物")]
public class ForeachThrowns : FlowControlNode
{
	private FlowOutput m_output;

	private int m_thrownID;

	private int m_thrownsListIndex;

	protected override void RegisterPorts()
	{
		m_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			List<ThrownState> mThrowns = CommonProcessor.GetWorldState().mThrowns;
			for (int num = mThrowns.Count - 1; num >= 0; num--)
			{
				m_thrownID = mThrowns[num].mCreationIndex;
				m_thrownsListIndex = num;
				m_output.Call(f);
			}
		});
		AddValueOutput("抛掷物ID", "thrownID", () => m_thrownID);
		AddValueOutput("抛掷物数组下标", "thrownListIndex", () => m_thrownsListIndex);
	}
}
