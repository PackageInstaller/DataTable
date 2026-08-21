using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("加载CueSheet(曲包)(渲染)", 0)]
[Category("Render/声音")]
[Description("激活曲包,以保证后续Criware内部调用需求")]
public class AddCueSheet : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput error = AddFlowOutput("Error");
		ValueInput<string> keyInput = AddValueInput<string>("标签", "key").SetDefaultAndSerializedValue("music");
		ValueInput<string> sheetNameInput = AddValueInput<string>("sheetName", "sheetName");
		ValueInput<bool> useStreamInput = AddValueInput<bool>("使用流", "useStream");
		AddFlowInput("In", delegate(Flow f)
		{
			if (string.IsNullOrEmpty(sheetNameInput.GetValue()))
			{
				error.Call(f);
			}
			else
			{
				AudioManager.Instance.AddCue(keyInput.value, sheetNameInput.value, useStreamInput.value);
				output.Call(f);
			}
		});
	}
}
