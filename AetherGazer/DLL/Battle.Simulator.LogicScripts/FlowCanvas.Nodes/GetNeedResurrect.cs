using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断这一关能否复活", 0)]
[Category("Logic/Spawn")]
[Description("判断这一关能否复活")]
public class GetNeedResurrect : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		int coinNumber = 0;
		AddValueOutput("剩余复活币", () => coinNumber);
		int coinConsume = 0;
		AddValueOutput("每次复活消耗", () => coinConsume);
		int resurrectTimes = 0;
		AddValueOutput("已经复活次数", () => resurrectTimes);
		AddFlowInput("", delegate(Flow f)
		{
			SimWorldState worldState = CommonProcessor.GetWorldState();
			bool needResurrect = worldState.needResurrect;
			coinNumber = (int)worldState.coinNumber;
			resurrectTimes = worldState.resurrectTimes;
			coinConsume = (int)worldState.coinConsume;
			if (needResurrect)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
