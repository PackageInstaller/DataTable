using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改修正模式时长(逻辑)", 0)]
[Category("Logic/SourceSpace")]
[Description("在修正模式中,仅设置修正模式持续时长")]
public class ModifySourceSpaceKeepTime : FlowControlNode
{
	private int _NewKeepTime = -1;

	private ValueInput<int> _Value;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_Value = AddValueInput<int>("值(毫秒)", "value");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			EntitySourceSpace entitySourceSpace = base.mSimContext.entitySourceSpace;
			if (entitySourceSpace != null && entitySourceSpace.Enable && entitySourceSpace.SourceSpaceKeepTime > 0)
			{
				entitySourceSpace.SourceSpaceKeepTime = _Value.GetValue();
				_NewKeepTime = _Value.GetValue();
				_Out.Call(f);
			}
			else
			{
				_NewKeepTime = -1;
				_Error.Call(f);
			}
		});
		AddValueOutput("新的时长(毫秒)", "newKeepTime", () => _NewKeepTime);
	}
}
