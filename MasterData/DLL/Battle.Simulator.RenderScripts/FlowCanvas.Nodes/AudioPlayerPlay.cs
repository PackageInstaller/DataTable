using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("播放背景音乐(BGM)(渲染)", 0)]
[Category("Render/声音")]
[Description("播放默认全局声源(criware),适用于播放背景音乐等")]
public class AudioPlayerPlay : FlowControlNode
{
	private ValueInput<string> m_cueAwb;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		ValueInput<string> sheetName = AddValueInput<string>("sheetName");
		ValueInput<string> cueName = AddValueInput<string>("cueName");
		m_cueAwb = AddValueInput<string>("Awb file(xxx.awb)");
		AddFlowInput("In", delegate(Flow f)
		{
			AudioManager.Instance.Play("music", sheetName.GetValue(), cueName.GetValue(), !string.IsNullOrEmpty(m_cueAwb.GetValue()));
			output.Call(f);
		});
	}
}
