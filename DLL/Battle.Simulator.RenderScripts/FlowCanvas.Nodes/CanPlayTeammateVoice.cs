using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否能播放队友战斗语音(渲染)", 0)]
[Category("Render/声音")]
[Description("判断是否能播放队友战斗语音;\nTure")]
public class CanPlayTeammateVoice : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("可以播放", "true");
		FlowOutput falseOut = AddFlowOutput("不能播放", "false");
		AddFlowInput("In", delegate(Flow f)
		{
			if (AudioManager.BattleTeammateVoiceSwitch)
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
