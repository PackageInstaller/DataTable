using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("停止背景音乐(BGM)(渲染)", 0)]
[Category("Render/声音")]
[Description("停止默认全局声源(criware)，适用于播放背景音乐等")]
public class AudioPlayerStop : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			AudioManager.Instance.Stop("music");
			output.Call(f);
		});
	}
}
