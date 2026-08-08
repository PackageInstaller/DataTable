using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加修正模式时长(逻辑)", 0)]
[Category("Logic/SourceSpace")]
[Description("在修正模式中,仅增加修正模式持续时长")]
public class AddSourceSpaceKeepTime : FlowControlNode
{
	private int m_newRaceID = -1;

	private int m_newKeepTime = -1;

	private ValueInput<int> m_breakEntityIDInput;

	private ValueInput<int> _AddValue;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_AddValue = AddValueInput<int>("增量(毫秒)", "addValue");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			EntitySourceSpace entitySourceSpace = base.mSimContext.entitySourceSpace;
			if (entitySourceSpace != null && entitySourceSpace.Enable && entitySourceSpace.SourceSpaceKeepTime > 0)
			{
				int sourceSpaceKeepTime = entitySourceSpace.SourceSpaceKeepTime;
				m_newKeepTime = (entitySourceSpace.SourceSpaceKeepTime = sourceSpaceKeepTime + _AddValue.GetValue());
				_Out.Call(f);
			}
			else
			{
				m_newKeepTime = -1;
				_Error.Call(f);
			}
		});
		AddValueOutput("新的时长(毫秒)", "newKeepTime", () => m_newKeepTime);
	}
}
