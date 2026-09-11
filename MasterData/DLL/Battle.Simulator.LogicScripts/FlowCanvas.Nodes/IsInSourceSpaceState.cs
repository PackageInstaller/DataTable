using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否在修正模式中(逻辑)", 0)]
[Category("Logic/修正模式")]
[Description("判断当前是否处于修正模式")]
public class IsInSourceSpaceState : FlowControlNode
{
	private int m_raceID;

	protected override void RegisterPorts()
	{
		FlowOutput TrueOut = AddFlowOutput("True");
		FlowOutput FalseOut = AddFlowOutput("False");
		AddFlowInput("In", delegate(Flow f)
		{
			if (base.mSimContext.hasEntitySourceSpace)
			{
				m_raceID = base.mSimContext.entitySourceSpace.SourceSpaceRaceID;
			}
			else
			{
				m_raceID = 0;
			}
			if (CommonProcessor.IsInSourceSpaceState())
			{
				TrueOut.Call(f);
			}
			else
			{
				FalseOut.Call(f);
			}
		});
		AddValueOutput("阵营ID(0为通用)", "raceID", () => m_raceID);
	}
}
