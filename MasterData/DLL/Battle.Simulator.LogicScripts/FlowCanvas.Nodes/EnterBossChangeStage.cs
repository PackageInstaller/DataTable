using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("进入BOSS转阶段状态(看备注)(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("不可每帧调用;\n必须与【退出BOSS转阶段】成对存在;\n用于阻挡进入修正模式;\n本质相当于【增加释放QTE的玩家计数】值 +1 ")]
public class EnterBossChangeStage : FlowControlNode
{
	private FlowOutput _Out;

	protected override void RegisterPorts()
	{
		_Out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			base.mSimContext.sEntityWorldState.status.m_InQTERoleCount++;
			_Out.Call(f);
		});
	}
}
