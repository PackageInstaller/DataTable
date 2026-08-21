using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("退出BOSS转阶段状态(看备注)(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("不可每帧调用;\n必须与【进入BOSS转阶段】成对存在;\n本质相当于【增加释放QTE的玩家计数】值 -1 ")]
public class ExitBossChangeStage : FlowControlNode
{
	private FlowOutput _Out;

	protected override void RegisterPorts()
	{
		_Out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SEntityWorldState sEntityWorldState = base.mSimContext.sEntityWorldState;
			sEntityWorldState.status.m_InQTERoleCount--;
			if (sEntityWorldState.status.m_InQTERoleCount < 0)
			{
				sEntityWorldState.status.m_InQTERoleCount = 0;
			}
			_Out.Call(f);
		});
	}
}
