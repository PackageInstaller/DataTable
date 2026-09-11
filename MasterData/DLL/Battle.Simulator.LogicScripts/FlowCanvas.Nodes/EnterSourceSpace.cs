using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("进入修正模式(逻辑)", 0)]
[Category("Logic/SourceSpace")]
[Description("发送进入修正模式的指令,这里的持续时长需要大于【SourceSpaceRenderConfigAsset】中【进入时长】\n当目标死亡时候,修正模式强制结束")]
public class EnterSourceSpace : FlowControlNode
{
	private ValueInput<int> m_breakEntityIDInput;

	protected override void RegisterPorts()
	{
		ValueInput<int> enterTimeInput = AddValueInput<int>("进入时长(毫秒)", "EnterTimeInput").SetDefaultAndSerializedValue(int.MaxValue);
		ValueInput<int> keepTimeInput = AddValueInput<int>("持续时长(毫秒)", "keepTimeInput");
		ValueInput<int> exitTimeInput = AddValueInput<int>("退出时长(毫秒)", "ExitTimeInput").SetDefaultAndSerializedValue(int.MaxValue);
		ValueInput<int> raceIDInput = AddValueInput<int>("阵营ID", "raceIDInput");
		m_breakEntityIDInput = AddValueInput<int>("Break实体ID", "breakEntityID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (SourceSpaceCommand.PrepareEnterSourceSpace(base.mSimContext, enterTimeInput.GetValue(), keepTimeInput.GetValue(), exitTimeInput.GetValue(), raceIDInput.GetValue(), m_breakEntityIDInput.GetValue()))
			{
				output.Call(f);
			}
			else
			{
				error.Call(f);
			}
		});
	}
}
