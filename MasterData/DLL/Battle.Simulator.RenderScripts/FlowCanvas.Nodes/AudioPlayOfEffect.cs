using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("播放音效(全局)(渲染)", 0)]
[Category("Render/声音")]
[Description("播放音效,使用于播放音效")]
public class AudioPlayOfEffect : FlowControlNode
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
			AudioManager.Instance.Play("effect", sheetName.GetValue(), cueName.GetValue(), !string.IsNullOrEmpty(m_cueAwb.GetValue()));
			output.Call(f);
		});
	}
}
